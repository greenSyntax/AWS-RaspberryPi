//
//  ErrorModel.swift
//  IELTSNew
//
//  Created by Chanchal Chauhan on 24/11/16.
//


public struct ErrorModel {
    var errorCode: Int!
    var errorMessage: String?
    
    
    /// This method take error code and error message as argument and return object of error model class which contains error code, error message and error title
    ///
    /// - parameter errorCode:    custom error code
    /// - parameter errorMessage: custom error message
    ///
    /// - returns: ErrorModel object
    static func error(errorCode: Int, errorMessage: String) -> ErrorModel {
        
        let errorModel: ErrorModel?
        
        // For other errors from server
        errorModel = ErrorModel(errorCode: errorCode, errorMessage: errorMessage)
        
        return errorModel!
        
    }
    
    
    /// This method takes Error type as argument and convert it into ErrorModel object
    ///
    /// - parameter error: Error type variable
    ///
    /// - returns: ErrorModel object
    static func error(error: Error) -> ErrorModel {
        
        let code = error._code
        let message = getErrorMessage(error: error)
        
        return ErrorModel(errorCode: code, errorMessage: message)
    }
    
    
    /// This method returns error message based on error code
    ///
    /// - parameter error: Error type variable
    ///
    /// - returns: error message as String type
    private static func getErrorMessage(error: Error) -> String {
        var message = ""
        return message
    }
}
