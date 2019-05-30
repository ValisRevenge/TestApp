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
    
    func load(path: String, httpMethod:HTTPMethod, params:[String:Any]?, completion: @escaping(Any?, ServiceError?)-> Void) {
        let url = URL(string: baseUrl + path)!
        
        request(url, method: httpMethod, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success:
                let dictionary = try? JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments)
                completion(dictionary, nil)
                break
            default:
                completion(nil, ServiceError.custom(response.result.debugDescription))
                break
            }
            
        })
        
    }
    
}
