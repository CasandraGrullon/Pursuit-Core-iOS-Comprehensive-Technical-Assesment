//
//  FavoriteEvent.swift
//  CTA
//
//  Created by casandra grullon on 3/20/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import Firebase

struct FavoriteEvent {
    let eventId: String
    let eventName: String
    let eventDate: String
    let eventImageURL: String
    let dateFavorited: Timestamp
}
extension FavoriteEvent {
    init?(_ dictionary: [String: Any]) {
        guard let eventId = dictionary["eventId"] as? String,
        let eventName = dictionary["eventName"] as? String,
            let eventDate = dictionary["eventDate"] as? String,
            let eventImageURL = dictionary["eventImageURL"] as? String,
        let dateFavorited = dictionary["dateFavorited"] as? Timestamp else {
                return nil
        }
        self.eventId = eventId
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventImageURL = eventImageURL
        self.dateFavorited = dateFavorited
    }
}
