//
//  AppUser.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct AppUser {
    let username: String
    let userEmail: String
    let userId: String
    let imageURL: String
    let apiChoice: String
}
extension AppUser {
    init?(_ dictionary: [String: Any]) {
        guard let username = dictionary["username"] as? String,
        let userEmail = dictionary["userEmail"] as? String,
        let userId = dictionary["userId"] as? String,
        let imageURL = dictionary["imageURL"] as? String,
            let apiChoice = dictionary["apiChoice"] as? String else {
                return nil
        }
        self.username = username
        self.userEmail = userEmail
        self.userId = userId
        self.imageURL = imageURL
        self.apiChoice = apiChoice
    }
}
