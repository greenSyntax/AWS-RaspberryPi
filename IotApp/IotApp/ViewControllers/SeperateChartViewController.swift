//
//  SeperateChartViewController.swift
//  IotApp
//
//  Created by Abhishek Ravi on 13/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import UIKit
import SwiftChart

class SeperateChartViewController: UIViewController {

    
    @IBOutlet weak var chartTemperature: Chart!
    @IBOutlet weak var chartHumidity: Chart!
    @IBOutlet weak var chartPressure: Chart!
    
    var data: ChartsData?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        intializeView()
        prepareCharts()
    }
    
    func intializeView(){
        
        self.navigationItem.title = "Charts"
    }
    
    func prepareCharts(){
        
        if let chartsData = data{
            
            // Temperature
            let series = ChartSeries(getFloat(values:chartsData.temperatureLog))
            series.color = UIColor.red
            series.area = true
            self.chartTemperature.add(series)
            
            // Humidity
            let seriesHumdity = ChartSeries(getFloat(values:chartsData.humidityLog))
            seriesHumdity.color = UIColor.green
            seriesHumdity.area = true
            self.chartHumidity.add(seriesHumdity)
            
            // Pressure
            let seriesPressure = ChartSeries(getFloat(values:chartsData.pressureLog))
            seriesPressure.color = UIColor.purple
            seriesPressure.area = true
            self.chartPressure.add(seriesPressure)
        }
    }
    
    func getFloat(values:[Double])->[Float]{
        
        var data:[Float] = []
        for item in values{
            
            data.append(Float(item))
        }
        
        return data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
