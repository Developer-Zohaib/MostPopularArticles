//
//  ImageUtility.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 19/04/2024.
//

import Foundation
import UIKit

class ImageUtility {
    
    static let documentsURL = FileManager.getDocumentsDirectory()

    static func getImage(from urlString: String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError(rawValue:"Wrong Url!")!))
            return
        }
        URLSession.shared.dataTask(with: url) { (data , response , error ) in
            if error != nil {
                completion(.failure(APIError(rawValue: error?.localizedDescription ?? "Unknown Error")!))
            } else {
                guard let data = data else {
                    completion(.failure(APIError(rawValue:"Unable to fetch image data")!))
                    return
                }
                completion(.success(data))
            }
        }.resume()
    }

    static func storeImageWith(fileName: String, image: UIImage) -> URL? {
        if let data = image.jpegData(compressionQuality: 0.5) {
            let fileURL = ImageUtility.documentsURL.appendingPathComponent(fileName)
            // Create the directory if it doesn't exist
            let directoryURL = fileURL.deletingLastPathComponent()
            if !FileManager.default.fileExists(atPath: fileURL.path) {
                // Create the directory if it doesn't exist

                do {
                    try FileManager.default.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                    try data.write(to: fileURL, options: .atomic)
                    return fileURL
                }
                catch {
                    print("Unable to create directory (\(error.localizedDescription))")
                    return nil
                }
            } else {
                return fileURL
            }
        } else {
            return nil
        }
    }
}
