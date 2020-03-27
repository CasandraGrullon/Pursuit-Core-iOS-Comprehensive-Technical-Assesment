//
//  Events.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct TicketMaster: Codable {
    let embedded: EventsResults?
    
    enum CodingKeys: String, CodingKey {
        case embedded = "_embedded"
    }
}
struct EventsResults: Codable {
    let events: [Events]
}
struct Events: Codable {
    let name: String
    let type: String
    let id: String
    let url: String
    let images: [EventImages]
    let dates: EventDates
    let promoter: Promoter
    let pleaseNote: String?
    let priceRanges: [PriceRanges]
    let venueInfo: VenueInfo
    
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case id
        case url
        case images
        case dates
        case promoter
        case pleaseNote
        case priceRanges
        case venueInfo = "_embedded"
    }
}
struct EventImages: Codable {
    let ratio: String
    let url: String
}
struct EventDates: Codable {
    let start: Start
}
struct Start: Codable {
    let localDate: String
    let localTime: String
    let dateTime: String
}
struct Promoter: Codable {
    let name: String
    let description: String
}
struct PriceRanges: Codable {
    let type: String
    let min: Double
    let max: Double
}
struct VenueInfo: Codable {
    let venues: [Venues]
}
struct Venues: Codable {
    let name: String
    let type: String
    let id: String
    let url: String
    let images: [VenueImages]
    let postalCode: String
    let city: City
    let state: State
    let country: Country
    let address: Address
    let location: Location
}
struct VenueImages: Codable {
    let ratio: String
    let url: String
}
struct City: Codable {
    let name: String
}
struct State: Codable {
    let name: String
    let stateCode: String
}
struct Country: Codable {
    let name: String
    let countryCode: String
}
struct Address: Codable {
    let line1: String
}
struct Location: Codable {
    let longitude: String
    let latitude: String
}
extension String {
    var isInt: Bool {
        return Int(self) != nil
    }
}
