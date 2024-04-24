//
//  FileManager.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 24/04/2024.
//

import Foundation

extension FileManager {    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
