//
//  NoData.swift
//  IotApp
//
//  Created by Abhishek Ravi on 07/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation
import UIKit

class NoData : UIView{
    
    static func getNoDataView()->NoData{
        
        let instance:NoData = getInstance()
        instance.layer.masksToBounds = true
        
        return instance
        
    }
    
    private static func getInstance()->NoData{
        
        return Bundle.main.loadNibNamed("NoData", owner: self, options: nil)?.first as! NoData
    }
    
}
