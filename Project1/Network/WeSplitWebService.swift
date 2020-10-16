//
//  WeSplitWebService.swift
//  Project1
//
//  Created by vn00082 on 10/16/20.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import Foundation

class WeSplitWebService{
    private var urlSession: URLSession
    private var urlString : String
    init(urlString : String, urlSession:URLSession = .shared){
        self.urlString = urlString
        self.urlSession = urlSession
    }
    func WeSplit(withFrom ParamModel : WeSplitAppRequestModel, completionHandler: @escaping(WeSplitResponseModel?, WeSpliterror?)->Void){
        guard let url = URL(string:urlString) else{
            //Unit test for specific error message should be returned if URL is nil
            completionHandler(nil, WeSpliterror.invalidRequestURLStringError)
            return
        }
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try?JSONEncoder().encode(ParamModel)
       let dataTask = URLSession.shared.dataTask(with: request){(data,response,error) in
        if let requestError = error{
            completionHandler(nil, WeSpliterror.requestURLFail(description: requestError.localizedDescription))
            return
        }
         
        if let data = data, let weSplitResponsModel=try?JSONDecoder().decode(WeSplitResponseModel.self, from: data){
            completionHandler(weSplitResponsModel,nil)
        }else{
            completionHandler(nil, WeSpliterror.responseModelParsingError)
        }
            
        }
        dataTask.resume()
        
    }
}
