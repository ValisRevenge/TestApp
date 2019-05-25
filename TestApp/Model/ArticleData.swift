//
//  ArticleData.swift
//  TestApp
//
//  Created by Mishko on 5/25/19.
//

import Foundation

enum ArticleFilter: String {
    case Shared = "SHARED"
    case MostViewd = "VIEWED"
    case Emailed = "EMAILED"
}

struct ArticleData: Decodable {
    //main fields
    var keywords: String
    var section:String
    var subsection: String
    var byline: String
    var type: String
    var title: String
    var abstract: String
    var publishedDate: Date
    var source: String
    
    var id: Int
    var assetId: Int
    
    var deFacet: [String]?
    var org_facet: [String]?
    var per_facet: [String]?
    var geo_facet: [String]?
    var media: [String]?
    var articleUrl: String
    var filtered: ArticleFilter

    //shared fields
    var shareCount: Int
    var countType: String
    
    //emailed fields
    var emailedCount: String
    
    private enum keys: String, CodingKey {
        case num_results
        case results
    }
    
    init(from decoder:Decoder) throws {
        
    }
}
