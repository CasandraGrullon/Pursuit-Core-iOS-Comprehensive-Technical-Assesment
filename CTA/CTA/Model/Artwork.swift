//
//  Artwork.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct ArtworkResult: Codable {
    let artObject: Artwork
}
struct Artwork: Codable {
    let id: String
    let objectNumber: String
    let title: String
    let webImage: ArtImage
    let titles: [String]
    let description: String
    let objectTypes: [String]
    //let principalMakers: [PrincipalMakers]
    let physicalMedium: String
    let subTitle: String
    let dating: Dating
}
struct ArtImage: Codable {
    let url: String
}
//struct PrincipalMakers: Codable {
//    let name: String
//    let placeOfBirth: String
//    let dateOfBirth: String
//    let dateOfDeath: String
//    let placeOfDeath: String
//    let occupation: [String]
//    let nationality: String
//}
struct Dating: Codable {
    let presentingDate: String
}
