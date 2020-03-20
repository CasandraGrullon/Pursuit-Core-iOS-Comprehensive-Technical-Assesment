//
//  MuseumAPI.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import NetworkHelper

class MuseumAPI {
    static func getCollections(search: String, completion: @escaping (Result<Collection, AppError>) -> ()) {
    
        let searchQuery = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let endpointURL = "https://www.rijksmuseum.nl/api/en/collection?key=GLNK3QhB&q=\(searchQuery)"
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let collection = try JSONDecoder().decode(Collection.self, from: data)
                    completion(.success(collection))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
    }
    
    static func getArtworkDetails(objectNumber: String, completion: @escaping (Result<ArtworkResult, AppError>) -> ()) {
        
        let endpointURL = "https://www.rijksmuseum.nl/api/en/collection/\(objectNumber)?key=GLNK3QhB"
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let art = try JSONDecoder().decode(ArtworkResult.self, from: data)
                    completion(.success(art))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
                
            }
        }
        
    }
}
