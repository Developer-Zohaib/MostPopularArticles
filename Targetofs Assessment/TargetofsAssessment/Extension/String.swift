//
//  String.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 23/04/2024.
//

import Foundation

extension String {
    func toDateFormatted() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        return dateFormatter.string(from: date)
    }
    
    func toDate(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = dateFormat
         return dateFormatter.date(from: self)
     }
}
