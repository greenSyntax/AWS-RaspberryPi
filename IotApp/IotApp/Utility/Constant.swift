//
//  Constant.swift
//  IotApp
//
//  Created by Abhishek Ravi on 06/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation

struct Constants{
    
    struct App{
        
        static let HOST_NAME = "http://52.25.130.85:8085"
        
        static let BASE_URL = "\(HOST_NAME)/iotplatformserver/api/"
        static let timout = 30
    }
    
    struct Litrals{
        
        static let dashboard = "Dashboard"
        static let charts = "Charts"
        
    }
    
    struct Attributes{
        
        static let responseStatus = "responseStatus"
        static let responseData = "responseData"
        static let getenvdata = "getenvdata"
    }
    
    struct ErrorMessage{
        
        static let requesrtTimeOut = "Request Time Out"
        static let unknownError = "Unknown Error"
        static let noInternetError = "No Internet"
        static let serverNotResponding = "Server Not Responding"
    }
    
    struct Identifer{
        
        //Cell
        static let reportCell = "reportCell"
        
        //View Cntrollers
        static let chartsViewController = "chartsViewController"
    }
}
