//
//  ChartsViewController.swift
//  IotApp
//
//  Created by Abhishek Ravi on 06/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import UIKit
import SwiftChart

class ChartsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var chartsTempersture: Chart!
    @IBOutlet weak var chartHumidity: Chart!
    @IBOutlet weak var chartPressure: Chart!
    
    var data:ChartsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initializeView()
        prepareCharts()
    }
    
    func initializeView(){
        
        self.navigationItem.title = Constants.Litrals.charts
    }
    
    func prepareCharts(){
        
        if let tempLog = self.data?.temperatureLog, let humidtyLog = self.data?.humidityLog, let pressureLog = self.data?.pressureLog{
            
            //Temp
            let seriesTemp = ChartSeries(tempLog)
            seriesTemp.color = ChartColors.greenColor()
            chartsTempersture.add(seriesTemp)
            
            //Humidty
            let seriesHumidty = ChartSeries(humidtyLog)
            seriesHumidty.color = ChartColors.greenColor()
            chartHumidity.add(seriesHumidty)
            
            //Pressure
            let seriesPressure = ChartSeries(pressureLog)
            seriesPressure.color = ChartColors.greenColor()
            chartPressure.add(seriesPressure)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
