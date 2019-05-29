//
//  ArticleData.swift
//  TestApp
//
//  Created by Mishko on 5/25/19.
//

import Foundation

typealias JSON = [String:Any]

enum ArticleFilter: String {
    case Shared = "SHARED"
    case MostViewed = "VIEWED"
    case Emailed = "EMAILED"
}

struct ArticleData {
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
    var filtered: ArticleFilter = .MostViewed
    //shared fields
    var shareCount: Int
    {
        didSet {
            if shareCount > 0 {
                filtered = .Shared
            }
        }
    }
    
    //emailed fields
    var emailedCount: Int
    {
        didSet {
            if emailedCount > 0 {
                filtered = .Emailed
            }
        }
    }
    //viewed fields
    var viewsCount: Int
    {
        didSet {
            if viewsCount > 0 {
                filtered = .MostViewed
            }
        }
    }
    static var keys:[String] = ["adx_keywords","section","subsection","byline","type",
    "title", "published_date", "source", "id", "asset_id", "url", "share_count", "emailed_count","viewed" ]
    
    init(dictionary: JSON) {
        keywords = dictionary["adx_keywords"] as? String ?? ""
        section = dictionary["section"] as? String ?? ""
        subsection = dictionary["subsection"] as? String ?? ""
        byline = dictionary["byline"] as? String ?? ""
        type = dictionary["type"] as? String ?? ""
        title = dictionary["title"] as? String ?? ""
        abstract = dictionary["abstract"] as? String ?? ""
        let date = dictionary["published_date"] as? String ?? ""
        publishedDate = DateFormatter().date(from: date) ?? Date()
        source = dictionary["source"] as? String ?? ""
        id = dictionary["id"] as? Int ?? -1
        assetId = dictionary["asset_id"] as? Int ?? -1
        articleUrl = dictionary["url"] as? String ?? ""
        
        shareCount = dictionary["share_count"] as? Int ?? 0
        emailedCount = dictionary["emailed_count"] as? Int ?? 0
        viewsCount = dictionary["views"] as? Int ?? 0
    }
    
    func getDictionary()->[String:Any] {
        var dictionary: [String:Any] = [:]
        dictionary["adx_keywords"] = keywords
        dictionary["section"] = section
        dictionary["subsection"] = subsection
        dictionary["byline"] = byline
        dictionary["type"] = type
        dictionary["title"] = title
        dictionary["published_date"] = publishedDate
        dictionary["source"] = source
        dictionary["id"] = id
        dictionary["asset_id"] = assetId
        dictionary["url"] = articleUrl
        dictionary["share_count"] = shareCount
        dictionary["email_count"] = emailedCount
        dictionary["views"] = viewsCount
        //let dict = Dictionary(uniqueKeysWithValues: Mirror(reflecting: self).children.map{($0.label!, $0.value)})
        return dictionary
    }
}
