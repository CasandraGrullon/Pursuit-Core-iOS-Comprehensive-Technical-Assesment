//
//  DatabaseSession.swift
//  CTA
//
//  Created by casandra grullon on 3/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

private let db = Firestore.firestore()

class DatabaseService {
    static let favoriteArtworks = "favoriteArtworks"
    static let favoriteEvents = "favoriteEvents"
    static let appUsers = "appUsers"
    
    private init() {}
    
    public static let shared = DatabaseService()

    public func createUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let email = authDataResult.user.email, let displayName = authDataResult.user.displayName else {
            return
        }
        db.collection(DatabaseService.appUsers).document(authDataResult.user.uid).setData(["username": displayName, "userId": authDataResult.user.uid, "userEmail": email]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    public func saveEvent() {
        
    }
    public func saveArtwork() {
        
    }
    
}
