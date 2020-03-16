//
//  TicketMasterAPI.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import NetworkHelper

class TicketMasterAPI {
    static func getEvents(postalCode: String, search: String, completion: @escaping (Result<[Events], AppError>) -> () ) {
        let searchQuery = search.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let endpointURL = "https://app.ticketmaster.com/discovery/v2/events.json?apikey=iYY6FrsDrhmcnXiLE9EvGCN9fA5mW775&postalCode=\(postalCode)&keyword=\(searchQuery)"
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
                    let events = try JSONDecoder().decode(EventsResults.self, from: data)
                    completion(.success(events.events))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
