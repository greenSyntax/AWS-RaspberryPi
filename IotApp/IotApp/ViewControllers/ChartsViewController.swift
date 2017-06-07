//
//  ChartsViewController.swift
//  IotApp
//
//  Created by Mukesh Yadav on 06/06/17.
//  Copyright © 2017 Mukesh Yadav. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var lineChartView: LineChartView!
    
    var data: ChartsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }
    
    func initializeView(){
        
        self.navigationItem.title = Constants.Litrals.charts
        configureCharts()
    }
    
    private func configureCharts() {
        lineChartView.chartDescription?.enabled = false
        lineChartView.dragEnabled = false
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.gridBackgroundColor = .clear
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.isUserInteractionEnabled = false
        lineChartView.xAxis.axisMinimum = 0
        lineChartView.xAxis.spaceMin = 1
        lineChartView.xAxis.spaceMax = 1
        lineChartView.xAxis.valueFormatter = XAxisFormatter(data?.time ?? [])
        
        var dataSets = [ChartDataSet]()
        
        if let temprature = data?.temperatureLog {
            dataSets.append(addDataToChart(temprature, label: "Temprature", color: .red))
        }
        
        if let pressure = data?.pressureLog {
            dataSets.append(addDataToChart(pressure, label: "Pressure", color: .blue))
        }
        
        if let humidity = data?.humidityLog {
            dataSets.append(addDataToChart(humidity, label: "Humidity", color: .green))
        }
        
        let chartData = LineChartData(dataSets: dataSets)
        
        lineChartView.data = chartData
        lineChartView.animate(xAxisDuration: 0.5)
    }
    
    private func addDataToChart(_ data: [Double], label: String, color: UIColor) -> ChartDataSet {
        var values = [ChartDataEntry]()
        let dataSet = LineChartDataSet()
        
        for i in 0..<data.count {
            let entry = ChartDataEntry(x: Double(i), y: data[i])
            values.append(entry)
        }
        
        dataSet.label = label
        dataSet.values = values
        dataSet.setColor(color)
        dataSet.setCircleColor(color)
        dataSet.circleRadius = 4.0
        dataSet.drawCircleHoleEnabled = false
        dataSet.mode = .cubicBezier
        dataSet.drawFilledEnabled = true
        dataSet.fillColor = color
        
        return dataSet
    }
}

class XAxisFormatter: NSObject, IAxisValueFormatter {
    
    var time: [String]
    
    init(_ time: [String]) {
        self.time = time
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        if index < time.count {
            return time[index]
        }
        return ""
    }
}
