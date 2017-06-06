//
//  DateHelper.swift
//  IotApp
//
//  Created by Abhishek Ravi on 07/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation

class DateHelper{
    
    private static let formatter = DateFormatter()
    
    
    static func getRawDate(_ date:String)->Date? {
        
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        if let passedDate = formatter.date(from: date){
            
            return passedDate
        }
        return nil
    }

    static func getFormatedDate(date:Date)->String {
        
        formatter.dateFormat = "EEE,dd MMM,yy"
        
        return formatter.string(from: date as Date)
    }
    
}
