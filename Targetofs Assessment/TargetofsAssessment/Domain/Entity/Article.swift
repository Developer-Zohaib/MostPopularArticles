//
//  Article.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 23/04/2024.
//

import Foundation

class ArticleResponse: NSObject, Decodable  {
    var results: [Article]?
    
    init(results: [Article]?) {
        self.results = results
    }
    
//    public func encode(with coder: NSCoder) {
//        coder.encode(results, forKey: "ArticlesKey")
//    }
//    
//    public required convenience init?(coder: NSCoder) {
//        let articles = coder.decodeObject(forKey: "ArticlesKey") as! [Article]
//        self.init(results: articles)
//     }
}

public class Article: NSObject, Decodable {
    let id: Int?
    let url: String?
    var updatedDate: String?
    var title: String?
    var abstract: String?
    var media: [MediaData]?
    var mediaUrl: String?
    /*
     - This init method is to validate unit test for our Article Property
     */
    
    init(id: Int, url: String, updated: String, title: String, abstract: String, media: [MediaData]?, mediaUrl: String) {
        self.id = id
        self.url = url
        self.updatedDate = updated
        self.title = title
        self.abstract = abstract
        self.media = media
        self.mediaUrl = mediaUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case url = "url"
        case updatedDate = "updated"
        case title = "title"
        case abstract = "abstract"
        case media = "media"
    }
    
//    public func encode(with coder: NSCoder) {
//        coder.encode(id, forKey: "id")
//        coder.encode(url, forKey: "url")
//        coder.encode(updatedDate, forKey: "updatedDate")
//        coder.encode(title, forKey: "title")
//        coder.encode(abstract, forKey: "abstract")
//        coder.encode(media, forKey: "media")
//    }
//    
//    public required convenience init?(coder: NSCoder) {
//        let id = coder.decodeObject(forKey: "id") as! Int
//        let url = coder.decodeObject(forKey: "url") as! String
//        let updated = coder.decodeObject(forKey: "updated") as! String
//        let title = coder.decodeObject(forKey: "title") as! String
//        let abstract = coder.decodeObject(forKey: "abstract") as! String
//        let media = coder.decodeObject(forKey: "media") as! [MediaData]
//        
//        self.init(id: id, url: url, updated: updated, title: title, abstract: abstract, media: media)
//     }
    
    // MARK: - Equatable Protocol
//    
//    static func ==(lhs: Article, rhs: Article) -> Bool {
//        
//        if lhs.id == rhs.id {
//            return true
//        }
//        return false
//    }
}

class MediaData: NSObject, Decodable {

    var mediaMetaData: [MediaMetaData]?
    
    /*
     - This init method is to validate unit test for our Article Property
     */
    
    init(mediaMetaData: [MediaMetaData]) {
        self.mediaMetaData = mediaMetaData
    }
    
    enum CodingKeys: String, CodingKey {
        case mediaMetaData = "media-metadata"
    }
    
//    public func encode(with coder: NSCoder) {
//        coder.encode(mediaMetaData, forKey: "mediaMetaData")
//    }
//    
//    public required convenience init?(coder: NSCoder) {
//        let mediaMetaData = coder.decodeObject(forKey: "mediaMetaData") as! [MediaMetaData]
//        self.init(mediaMetaData: mediaMetaData)
//     }
}

class MediaMetaData: NSObject, Decodable {
    var url: String?
    
    init(url: String) {
        self.url = url
    }
    
//    public func encode(with coder: NSCoder) {
//        coder.encode(url, forKey: "url")
//    }
//    
//    public required convenience init?(coder: NSCoder) {
//        let url = coder.decodeObject(forKey: "url") as! String
//
//        self.init(url: url)
//     }
}

