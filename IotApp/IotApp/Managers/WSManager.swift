//
//  WSManager.swift
//  Dominos
//
//  Created by Abhishek Ravi on 04/04/17.
//
//

import Foundation
import Alamofire
import JSONParserSwift

struct ApiStruct {
    
    let endPoint: String
    let type: HTTPMethod
    let body: [String : AnyObject]?
    let headers: [String: String]?
}

class WSManager {
    
    //Singleton
    static let shared = WSManager()
    
    // Initialize Alamofire Configurations
    private var manager: Alamofire.SessionManager
    private let configuration: URLSessionConfiguration
    
    private init() {
        
        // Default configuration
        configuration = URLSessionConfiguration.default
        
        // Timeout interval for web request
        configuration.timeoutIntervalForRequest = TimeInterval(Constants.App.timout)
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    //MARK:- API Request
    func getResponse(api:ApiStruct, onSuccess success:@escaping (_ json:Any?)->Void, onFailure fail:@escaping (_ error: ErrorModel)->Void){
        
        //URL
        let path = URL.init(string: "\(Constants.App.BASE_URL)\(api.endPoint)")
        
        //Header
        let headers = api.headers ?? [:]
        
        //Body
        let body = api.body
        
        //Indicator on StatusBar
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        manager.request(path!, method: api.type, parameters: body, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if response.result.isSuccess{
                
                //Response
                if let json = response.result.value as? [String: Any] {
                    if let responseStatus = json[Constants.Attributes.responseStatus] as? [String: Any] {
                        
                        let status: ResponseStatus = JSONParserSwift.parse(dictionary: responseStatus)
                        
                        if self.isResponseSuccess(response: status) {
                            
                            if let responseData = json[Constants.Attributes.responseData] as? [String: Any] {
                                
                                //When Response is a Dictionary
                                success(responseData)
                                
                            }else if let responseData = json[Constants.Attributes.responseData] as? [Any]{
                             
                                //When Response is [Array]
                                success(responseData)
                            }
                            else {
                                
                                //When There is No ResponseData
                                success(nil)
                            }
                        } else {
                            let error = self.getError(errorResponse: status)
                            fail(error)
                        }
                        
                    } else {
                        let error = self.getError(errorResponse: ResponseStatus())
                        fail(error)
                    }
                } else {
                    
                    let error = self.getError(errorResponse: ResponseStatus())
                    fail(error)
                }
            } else {
                //Fail Callback
                fail(ErrorManager.processError(error: response.error))
            }
        }
    }

    
    /// This method check if status code is 0 or not. If status code is zero it returns true otherwise false.
    ///
    /// - parameter response: It indicates complete response from server.
    ///
    /// - returns: True if status code is zero otherwise False.
    private func isResponseSuccess(response: ResponseStatus) -> Bool {
        
        return !(response.statusCode?.boolValue ?? false)
    }
    
    /// This method used to create custom error object of ErrorModel
    ///
    /// - parameter errorResponse: Response if status code is other than 0
    ///
    /// - returns: object of ErrorModel
    private func getError(errorResponse: ResponseStatus) -> ErrorModel {
        
        //let errorCode = errorResponse.errorCode?.intValue
        if let message = errorResponse.message{
            
            return ErrorManager.processError(errorCode: 101, errorMsg: message)
        }
        
        return ErrorManager.processError(errorCode: 101, errorMsg: "Something went wrong")
    }
}
