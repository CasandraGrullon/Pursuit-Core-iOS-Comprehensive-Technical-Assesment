//
//  FavoriteArtwork.swift
//  CTA
//
//  Created by casandra grullon on 3/20/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import Firebase

struct FavoriteArtwork {
    let artObjectNumber: String
    let artTitle: String
    let artistName: String
    let artImageURL: String
    let dateFavorited: Timestamp
}
extension FavoriteArtwork {
    init?(_ dictionary: [String: Any]) {
        guard let artObjectNumber = dictionary["artObjectNumber"] as? String,
        let artTitle = dictionary["artTitle"] as? String,
        let artistName = dictionary["artistName"] as? String,
        let artImageURL = dictionary["artImageURL"] as? String,
            let dateFavorited = dictionary["dateFavorited"] as? Timestamp else {
                return nil
        }
        self.artObjectNumber = artObjectNumber
        self.artTitle = artTitle
        self.artistName = artistName
        self.artImageURL = artImageURL
        self.dateFavorited = dateFavorited
    }
}
