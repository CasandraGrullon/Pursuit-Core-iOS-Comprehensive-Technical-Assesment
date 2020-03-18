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
        
        guard let email = authDataResult.user.email else {
            return
        }
        db.collection(DatabaseService.appUsers).document(authDataResult.user.uid).setData(["userId": authDataResult.user.uid, "userEmail": email]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    public func updateUserAPIChoice(apiChoice: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseService.appUsers).document(user.uid).updateData(["apiChoice": apiChoice]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    public func getUserAPIChoice(userId: String, completion: @escaping (Result<String, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseService.appUsers).whereField(user.uid, isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let appUsers = snapshot.documents.compactMap {AppUser ($0.data())}
                let currentUser = appUsers.filter {$0.userId == userId}
                guard let apichoice = currentUser.first?.apiChoice else {
                    return
                }
                completion(.success(apichoice))
                
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
