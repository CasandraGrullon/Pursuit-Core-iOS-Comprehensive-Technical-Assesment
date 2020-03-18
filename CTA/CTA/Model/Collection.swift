//
//  RijkMuseum.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct Collection: Codable {
    let artObjects: [ArtObjects]
}
struct ArtObjects: Codable {
    let links: Links
    let id: String
    let objectNumber: String
    let title: String
    let artist: String//coding key
    let longTitle: String
    let webImage: WebImage
    
    enum CodingKeys: String, CodingKey {
        case links
        case id
        case objectNumber
        case title
        case artist = "principalOrFirstMaker"
        case longTitle
        case webImage
    }
}
struct Links: Codable {
    let web: String
}
struct WebImage: Codable {
    let url: String
}
