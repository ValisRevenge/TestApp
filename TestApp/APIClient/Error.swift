//
//  Error.swift
//  TestApp
//
//  Created by Mishko on 5/25/19.
//

import Foundation

enum ServiceError: Error {
    case noInternetConnection
    case custom(String)
    case other
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection ("
        case .other:
            return "smth went wrong"
        case .custom(let message):
            return message
        }
    }
}

extension ServiceError {
    init(json: [String:Any]) {
        if let message = json["message"] as? String {
            self = .custom(message)
        }
        else {
            self = .other
        }
    }
}
