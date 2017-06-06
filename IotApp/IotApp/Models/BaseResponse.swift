//
//  BaseResponse.swift
//  IotApp
//
//  Created by Abhishek Ravi on 07/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation
import JSONParserSwift

class ResponseStatus: ParsableModel {
    
    var statusCode: NSNumber?
    var message: String?
    var errorCode: NSNumber?
    
    required init(dictionary: [String : Any]) {
        super.init(dictionary: dictionary)
    }
    
    init() {
        super.init(dictionary: [:])
    }
}
