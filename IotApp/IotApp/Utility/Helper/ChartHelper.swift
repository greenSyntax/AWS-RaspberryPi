//
//  ChartHelper.swift
//  IotApp
//
//  Created by Abhishek Ravi on 06/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation
import SwiftChart


class ChartHelper{
    
    static func getChartView(chart:Chart, data:[Float], isFill:Bool){
        
        let series = ChartSeries(data)
        series.color = ChartColors.yellowColor()
        series.area = isFill
        
        chart.add(series)
    }
    
}
