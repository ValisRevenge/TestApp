//
//  WebClient.swift
//  TestApp
//
//  Created by Mishko on 5/25/19.
//

import Foundation
import Alamofire

final class WebClient {
    
    private var baseUrl: String
    
    init(url: String) {
        baseUrl = url
    }
    
    func load(path: String, httpMethod:HTTPMethod, params:[String:Any], completion: @escaping(Any?, ServiceError?)->()) {
        let url = URL(string: baseUrl + path)!
        request(url, method: httpMethod, parameters: params, encoding: URLEncoding.default, headers: nil).validate().responseData(completionHandler: {
            response in
            switch response.result {
            case .success:
                
                break
            default:
                break
            }
            
        })
        
    }
    
}
