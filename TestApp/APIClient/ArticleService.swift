//
//  ArticleService.swift
//  TestApp
//
//  Created by Mishko on 5/28/19.
//

import Foundation
import Alamofire

class ArticleService {
    
    let client:WebClient = WebClient(url: "https://api.nytimes.com/svc/mostpopular/v2/")
    
    func loadArticlesData(filterType: ArticleFilter, completion: @escaping(Any?, ServiceError?)-> Void) {
        
        var path = ""
        switch filterType {
        case .Emailed:
            path = "emailed/1.json"
            break
        case .Shared:
            path = "shared/1.json"
            break
        default:
            path = "viewed/1.json"
            break
        }
        
        let url = String(path: path, params: ["api-key":"AVWhbG0l8u70pfMzA9k1VYUSPAorkRLL"], method: .get)
        client.load(path: url, httpMethod: .get, params: nil, completion: completion)
    }
}

extension String {
    init(path: String, params: [String:Any], method: HTTPMethod) {
        var components = URLComponents(string: path)!
        
        switch method {
        case .get:
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }
        
        self = components.string!
    }
}
