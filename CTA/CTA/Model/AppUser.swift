//
//  AppUser.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct AppUser {
    var username: String
    let userEmail: String
    let userId: String
    var imageURL: String
    var apiChoice: String
}
extension AppUser {
    init(_ dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? "no name"
        self.userEmail = dictionary["userEmail"] as? String ?? "no email"
        self.userId = dictionary["userId"] as? String ?? "no user id"
        self.imageURL = dictionary["imageURL"] as? String ?? "no image"
        self.apiChoice = dictionary["apiChoice"] as? String ?? "no api"
    }
}
