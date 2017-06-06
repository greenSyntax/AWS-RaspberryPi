//
//  ReportModel.swift
//  IotApp
//
//  Created by Abhishek Ravi on 07/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation
import JSONParserSwift

class ReportArrayModel : ParsableModel{
    
    var envDetails:[ReportModel]?
}

class ReportModel: ParsableModel{
    
    var temperature:NSNumber?
    var pressure:NSNumber?
    var humidity:NSNumber?
    var createddate:String?
}
