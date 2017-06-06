//
//  ListViewController.swift
//  IotApp
//
//  Created by Abhishek Ravi on 06/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSourceForReports:[ReportViewModel]?
    var charts:ChartsData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        intializeView()
        prepareTabeView()
        prepareList()
    }
    
    fileprivate func intializeView(){
        
        self.navigationItem.title = "Dashboard"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Connections
    
    @IBAction func barButtonChartsClicked(_ sender: Any) {
        
        //To Chart Screen
        navigateToChartScreen()
    }
    
    //MARK:- Tabel View
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataSourceForReports?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Constants.Identifer.reportCell, for: indexPath) as! ReportTableViewCell
        
        cell.labelTemperature.text = "Temp:"+String(describing: self.dataSourceForReports?[indexPath.row].temperature ?? 0)
        cell.labelHumidity.text = "Humidity:"+String(describing: self.dataSourceForReports?[indexPath.row].humidity ?? 0)
        cell.labelPressure.text = "Pressure:"+String(describing: self.dataSourceForReports?[indexPath.row].pressure ?? 0)
        return cell
    }

    //MARK:- Private Methods
    fileprivate func navigateToChartScreen(){
        
        let chartVc = self.storyboard?.instantiateViewController(withIdentifier: Constants.Identifer.chartsViewController) as! ChartsViewController
        chartVc.data = self.charts ?? nil
        self.navigationController?.pushViewController(chartVc, animated: true)
    }
    
    
    fileprivate func prepareTabeView(){
      
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    fileprivate func prepareList(){
        
        self.showProgressBar()
        ReportPresenter.getRecord(onSuccess: { (reports, chartData) in
            
            self.hideProgressbar()
            
            //Successfull got Records
            if reports.count == 0{
                
                self.tableView.backgroundView = NoData.getNoDataView()
            }
            else{
             
                
                self.dataSourceForReports = reports
                self.charts = chartData
                self.tableView.backgroundView = nil
                self.tableView.reloadData()
            }
            
        }) { (errorModel) in
            
            //Error
            self.hideProgressbar()
            self.showAlert(title: "Server Error", message: "There is something wrong with the Server")
            
        }
        
    }
    

}
