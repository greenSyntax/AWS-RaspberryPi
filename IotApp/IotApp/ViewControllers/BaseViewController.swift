//
//  BaseViewController.swift
//  IotApp
//
//  Created by Abhishek Ravi on 07/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView{
    
    static let shared = UIActivityIndicatorView()
}

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- Progressbar
    private static func getActivityIndicator()->UIActivityIndicatorView{
        
        let activityIndicator = UIActivityIndicatorView.shared
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.color = UIColor.purple
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.layer.zPosition = 10
        
        return activityIndicator
    }
    
    /// Show Activity Indicator
    func showProgressBar(){
        
        let activityIndicator = BaseViewController.getActivityIndicator()
        activityIndicator.center = self.view.center
        activityIndicator.center.y = UIScreen.main.bounds.maxY/2.5
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(activityIndicator)
    }
    
    /// Hide Activity Indicator
    func hideProgressbar(){
        
        let activityIndicator = BaseViewController.getActivityIndicator()
        self.view.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
    }

    
    //MARK:- Alert
    func showAlert(title:String, message:String?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }

    
}
