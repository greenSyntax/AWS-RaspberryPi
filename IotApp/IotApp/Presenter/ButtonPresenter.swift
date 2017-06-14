//
//  ButtonPresenter.swift
//  IotApp
//
//  Created by Abhishek Ravi on 08/06/17.
//  Copyright © 2017 Abhishek Ravi. All rights reserved.
//

import Foundation
import JSONParserSwift

struct ButtonState {
    
    var state:Bool?
}

class ButtonPresenter{
    
    static func getStateOfButton(hasState:@escaping (Bool)->Void, onError:@escaping (ErrorModel)->Void){
        
        let apiStruct = ApiStruct(endPoint: Constants.Attributes.getledstate, type: .get, body: nil, headers: nil)
        
        WSManager.shared.getResponse(api: apiStruct, onSuccess: { (state) in
            
            let modelState:StateModel = JSONParserSwift.parse(dictionary: state as! [String : Any])
            
            if modelState.currentstate == Constants.Litrals.on{
                
                //onSuccess
                hasState(true)
            }
            else{
                
                //onSuccess
                hasState(false)
            
            }
            
        }) { (error) in
            
            let error = ErrorModel(errorCode: 101, errorMessage: Constants.ErrorMessage.unknownError)
            onError(error)
            
        }
    }
    
    
    static func changeButtonEvent(buttonState:ButtonState, onCahnge:@escaping (Bool)->Void){
        
        let buttonState = buttonState.state == true ? Constants.Attributes.on : Constants.Attributes.off
        
        let body = [Constants.Attributes.state:buttonState]
        
        //Structure
        let api = ApiStruct(endPoint: Constants.Attributes.updateEventState, type: .post, body: body as [String : AnyObject]?, headers: nil)
        
        WSManager.shared.getResponse(api: api, onSuccess: { (state) in
            
            onCahnge(true)
            
        }) { (error) in
            
            onCahnge(false)
        }
    }
    
}
