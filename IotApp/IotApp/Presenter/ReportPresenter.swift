//
//  ReportPresenter.swift
//  IotApp
//
//  Created by Abhishek Ravi on 06/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation
import JSONParserSwift

struct ReportViewModel{
    
    var temperature:Double?
    var humidity:Double?
    var pressure:Double?
    var dateOfRecord:Date?
}

struct ChartsData {
    
    var temperatureLog:[Float] = []
    var humidityLog:[Float] = []
    var pressureLog:[Float] = []
}

class ReportPresenter{
    
    //MARK:- Private Methods
    private static func getTwoPlacesDecimal(value:NSNumber)->Double{
        
        return Double(round(1000 * Double(value))/1000)
    }
    
    private static func getFloat(value:NSNumber)->Float{
        
        return Float(value)
    }
    
    private static func prepareChartsLog(data:[ReportModel])->ChartsData{
        
        var charts = ChartsData()
        
        for dataum in data{
        
            charts.temperatureLog.append(getFloat(value: dataum.temperature!))
            charts.humidityLog.append(getFloat(value: dataum.humidity!))
            charts.pressureLog.append(getFloat(value: dataum.pressure!))
        }
        
        return charts
    }
    
    private static func prepareViewModel(data:[ReportModel])->[ReportViewModel]{
        
        var arrayOfViewModel:[ReportViewModel] = []
        
        for dataum in data{
            
            var viewModel = ReportViewModel()
            viewModel.temperature = getTwoPlacesDecimal(value: dataum.temperature!)
            viewModel.humidity = getTwoPlacesDecimal(value: dataum.humidity!)
            viewModel.pressure = getTwoPlacesDecimal(value: dataum.pressure!)
            viewModel.dateOfRecord = DateHelper.getRawDate(dataum.createddate ?? "")
            arrayOfViewModel.append(viewModel)
        }
        
        return arrayOfViewModel
    }
    
    static func getRecord(onSuccess:@escaping (([ReportViewModel], ChartsData)->Void), onError:@escaping ((ErrorModel)->Void)){
        
        //Structure
        let api = ApiStruct(endPoint: Constants.Attributes.getenvdata, type: .get, body: nil, headers: nil)
        
        WSManager.shared.getResponse(api: api, onSuccess: { (reportsData) in
            
            let data:ReportArrayModel = JSONParserSwift.parse(dictionary: (reportsData as? [String:Any])!)
            
            let chartData = prepareChartsLog(data: data.envDetails!)
            let reportData = prepareViewModel(data: data.envDetails!)
            
            onSuccess(reportData, chartData)
    
        }) { (error) in
            
            //Error Occured
            onError(error)
            
        }
        
    }
}
