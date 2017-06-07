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
    
    var temperatureLog:[Double] = []
    var humidityLog:[Double] = []
    var pressureLog:[Double] = []
    var time: [String] = []
}

class ReportPresenter{
    
    //MARK:- Private Methods
    private static func getTwoPlacesDecimal(value:NSNumber)->Double{
        
        return Double(round(1000 * Double(value))/1000)
    }
    
    private static func prepareChartsLog(data:[ReportModel])->ChartsData{
        
        var charts = ChartsData()
        
        for dataum in data{
        
            if let temp = dataum.temperature, let humdidty = dataum.humidity, let pressure = dataum.pressure, let time = dataum.createddate {
             
                charts.temperatureLog.append(temp.doubleValue)
                charts.humidityLog.append(humdidty.doubleValue)
                charts.pressureLog.append(pressure.doubleValue)
                
                if var timestamp = Double(time) {
                    timestamp = timestamp / 1000
                    let date = Date(timeIntervalSince1970: timestamp)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm:ss"
                    
                    charts.time.append(dateFormatter.string(from: date))
                }
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
