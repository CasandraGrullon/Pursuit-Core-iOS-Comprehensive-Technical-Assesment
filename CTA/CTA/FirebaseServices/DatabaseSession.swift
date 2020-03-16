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

    public func createUser(authDataResult: AuthDataResult, apiChoice: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.appUsers).document(authDataResult.user.uid).setData(["userId": authDataResult.user.uid, "userEmail": email, "apiChoice": apiChoice]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    public func updateUser(displayName: String, photoURL: String, completion: @escaping (Result<Bool, Error>) -> ()) {
    
    guard let user = Auth.auth().currentUser else {
        return
    }
    
    db.collection(DatabaseService.appUsers).document(user.uid).updateData(["displayName": displayName, "photoURL": photoURL]) { (error) in
        
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
