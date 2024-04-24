//
//  DataRepository.swift
//  TargetofsAssessment
//
//  Created by Zohaib Afzal on 24/04/2024.
//

import Foundation
import UIKit

protocol DataRepositoryProtocol {
    func fetchArticles(complete completion: @escaping (Result<[Article], Error>) -> Void)
    func fetchImage(id: String, url: String, complete completion: @escaping (Result<Data?, APIError>) -> Void)
    func saveArticles(articles: [Article])
}

final class DataRepository: DataRepositoryProtocol {
    
    private let persistanceStore: PersistanceStore
    private let apiClient: ArticlesApi
    
    init(persistanceStore: PersistanceStore, apiClient: APIClient) {
        self.persistanceStore = persistanceStore
        self.apiClient = ArticlesApi()
    }
    
    // write transaction in coredata
    
    func saveArticles(articles: [Article]) {
        persistanceStore.saveArticles(articles: articles)
    }
    
    func fetchImage(id: String, url: String, complete completion: @escaping (Result<Data?, APIError>) -> Void) {
        
        if Reachability.isConnectedToNetwork() {
            ImageUtility.getImage(from: url) {[weak self] result in
                switch result {
                case .success(let data):
                    self?.saveImageToFileManager(articleId: id, data: data)
                    completion(.success(data))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        } else {
            guard let imageDocumentUrl = persistanceStore.loadImage(with: id) else {
                completion(.failure(.localDatabaseError))
                return
            }
            loadImageFromDocuments(url: imageDocumentUrl, completion: completion)
        }
    }
    
    // read from coredata
    private func loadFromDB(complete completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let articles = persistanceStore.loadArticles() else { return }
        completion(.success(articles))
    }

    private func loadImageFromDocuments(url: String, completion: @escaping (Result<Data?, APIError>) -> Void) {
        let url = URL(string: url)
        let documentsURL = FileManager.getDocumentsDirectory()
        let fileURL = documentsURL.appendingPathComponent(url?.lastPathComponent ?? "")
        let fileExists = (try? fileURL.checkResourceIsReachable()) ?? false

        if fileExists {
            do {
                let imageData = try Data(contentsOf: fileURL)
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(.success(imageData))
                })
            } catch {
                completion(.failure(.somethingWentWrong))
            }
        } else {
            completion(.failure(.somethingWentWrong))
        }
    }

    private func saveImageToFileManager(articleId: String?, data: Data?) {
        if let data = data, let image = UIImage(data: data), let id = articleId {
            // photo id is unique so we can use it as file name for uniqueness
            // save the loaded image in document directory for faster load and offline support
            if let fileURL = ImageUtility.storeImageWith(fileName: articleId ?? "", image: image) {
                //photo.localURL = "\(fileURL)"
                self.saveImageUrlInCoreData(id: id, url: "\(fileURL)")
            }
        }
    }
    
    private func saveImageUrlInCoreData(id: String, url: String) {
        persistanceStore.saveImage(id: id, url: url)
    }

    func fetchArticles(complete completion: @escaping (Result<[Article], Error>) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            // incase of no internet load from dataBase
            loadFromDB() { result in
                switch result {
                case .success(let article):
                    completion(.success(article))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            
            apiClient.getArticles(from: .articleLists) { result in
                switch result {
                    // success
                case .success(let articles):
                    guard let articles = articles.results else { return }
                    self.saveArticles(articles: articles)
                    print(articles)
                    completion(.success(articles))
                    // failure
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
