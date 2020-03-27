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
    
    public func createDBUser(authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        
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
    public func getUserApiChoice(completion: @escaping (Result<String, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.appUsers).document(user.uid).getDocument { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot{
                guard let userData = snapshot.data() else { return }
                let appuser = AppUser(userData)
                completion(.success(appuser.apiChoice))
                
                
            }
        }
        
    }
    public func getAPPUser(userId: String, completion: @escaping (Result<[AppUser], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {
            return
        }
        db.collection(DatabaseService.appUsers).whereField(user.uid, isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let appUser = snapshot.documents.compactMap {AppUser ($0.data())}
                completion(.success(appUser))
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
    public func addToFavorites(event: Events? = nil, artwork: Artwork? = nil, artObject: ArtObjects? = nil, completion: @escaping (Result<Bool, Error>) -> () ) {
        guard let user = Auth.auth().currentUser else { return }
        if let event = event {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteEvents).document(event.id).setData(["eventId":event.id, "eventName": event.name, "eventDate": event.dates.start.localDate, "eventImageURL": event.images.first?.url ?? "", "dateFavorited": Timestamp(date: Date())]) { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        } else if let artwork = artwork {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).document(artwork.objectNumber).setData(["artObjectNumber": artwork.objectNumber, "artTitle": artwork.title, "artistName": artwork.principalMaker, "artImageURL": artwork.webImage.url, "dateFavorited": Timestamp(date: Date())]) { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        } else if let artObject = artObject {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).document(artObject.objectNumber).setData(["artObjectNumber": artObject.objectNumber, "artTitle": artObject.title, "artistName": artObject.artist, "artImageURL": artObject.webImage.url, "dateFavorited": Timestamp(date: Date())]) { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
        
    }
    
    public func removeFromFavorites(event: Events? = nil, artwork: Artwork? = nil, artObject: ArtObjects? = nil, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        if let event = event {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteEvents).document(event.id).delete { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        } else if let artwork = artwork {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).document(artwork.objectNumber).delete { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        } else if let artObject = artObject {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).document(artObject.objectNumber).delete { (error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(true))
                }
            }
        }
        
    }
    public func isInFavorites(event: Events? = nil,artwork: Artwork? = nil, artObject: ArtObjects? = nil, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        if let event = event {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteEvents).whereField("eventId", isEqualTo: event.id).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let snapshot = snapshot {
                    let count = snapshot.documents.count
                    if count > 0 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                }
            }
        } else if let artwork = artwork {                db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).whereField("artObjectNumber", isEqualTo: artwork.objectNumber).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let count = snapshot.documents.count
                if count > 0 {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            }
            }
        } else if let artObject = artObject {
            db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).whereField("artObjectNumber", isEqualTo: artObject.objectNumber).getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else if let snapshot = snapshot {
                    let count = snapshot.documents.count
                    if count > 0 {
                        completion(.success(true))
                    } else {
                        completion(.success(false))
                    }
                }
            }
        }
        
    }
    public func getFavoriteEvents(completion: @escaping (Result<[FavoriteEvent], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteEvents).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let favoriteEvents = snapshot.documents.compactMap {FavoriteEvent ($0.data())}
                completion(.success(favoriteEvents.sorted(by: {$0.dateFavorited.dateValue() > $1.dateFavorited.dateValue()})))
            }
        }
    }
    
    public func getFavoriteArtworks(completion: @escaping (Result<[FavoriteArtwork], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let favoriteArtworks = snapshot.documents.compactMap { FavoriteArtwork ($0.data()) }
                completion(.success(favoriteArtworks.sorted(by: {$0.dateFavorited.dateValue() > $1.dateFavorited.dateValue()} )))
            }
        }
    }
    
    public func deleteDBEventFavorite(event: FavoriteEvent, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteEvents).document(event.eventId).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    public func deleteDBArtworkFavorite(artwork: FavoriteArtwork, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        db.collection(DatabaseService.appUsers).document(user.uid).collection(DatabaseService.favoriteArtworks).document(artwork.artObjectNumber).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
}
