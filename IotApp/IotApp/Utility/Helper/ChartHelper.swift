//
//  ChartHelper.swift
//  IotApp
//
//  Created by Abhishek Ravi on 07/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation
import SwiftChart

class ChartHelper{
    
    static func getLineChart(data:[Float], chartView:Chart){
        
        let series = ChartSeries(data)
        series.color = UIColor.green
        chartView.add(series)
    }
}
