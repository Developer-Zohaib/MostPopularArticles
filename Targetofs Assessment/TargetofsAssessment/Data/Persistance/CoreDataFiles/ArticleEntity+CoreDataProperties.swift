//
//  ArticleEntity+CoreDataProperties.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 24/04/2024.
//
//

import Foundation
import CoreData


extension ArticleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var url: String?
    @NSManaged public var updatedDate: String?
    @NSManaged public var title: String?
    @NSManaged public var abstract: String?
    @NSManaged public var mediaUrl: String?

}

extension ArticleEntity : Identifiable {
    func convertToArticle() -> Article {
        return Article(id: Int(self.id), url: self.url ?? "", updated: self.updatedDate ?? "", title: self.title ?? "", abstract: self.abstract ?? "", media: nil, mediaUrl: self.mediaUrl ?? "")
    }
}
