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
        
            if let temp = dataum.temperature, let humdidty = dataum.humidity, let pressure = dataum.pressure{
             
                charts.temperatureLog.append(getFloat(value: temp))
                charts.humidityLog.append(getFloat(value: humdidty))
                charts.pressureLog.append(getFloat(value: pressure))
            }
        }
        
        return charts
    }
    
    private static func prepareViewModel(data:[ReportModel])->[ReportViewModel]{
        
        var arrayOfViewModel:[ReportViewModel] = []
        
        for dataum in data{
            
            var viewModel = ReportViewModel()
            
            if let temp = dataum.temperature, let humidty = dataum.humidity, let pressure = dataum.pressure{
             
                viewModel.temperature = getTwoPlacesDecimal(value: temp)
                viewModel.humidity = getTwoPlacesDecimal(value: humidty)
                viewModel.pressure = getTwoPlacesDecimal(value: pressure)
                viewModel.dateOfRecord = DateHelper.getRawDate(dataum.createddate ?? "")
                arrayOfViewModel.append(viewModel)
            }
        }
        
        return arrayOfViewModel
    }
    
    static func getRecord(onSuccess:@escaping (([ReportViewModel], ChartsData)->Void), onError:@escaping ((ErrorModel)->Void)){
        
        //Structure
        let api = ApiStruct(endPoint: Constants.Attributes.getenvdata, type: .get, body: nil, headers: nil)
        
        WSManager.shared.getResponse(api: api, onSuccess: { (reportsData) in
            
            let data:ReportArrayModel = JSONParserSwift.parse(dictionary: (reportsData as? [String:Any])!)
            
            if let data = data.envDetails{
             
                let chartData = prepareChartsLog(data: data)
                let reportData = prepareViewModel(data: data)
                
                onSuccess(reportData, chartData)
            }
    
        }) { (error) in
            
            //Error Occured
            onError(error)
            
        }
        
    }
}
