//
//  UserSession.swift
//  CTA
//
//  Created by casandra grullon on 3/19/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserSession {
  private init() {}
  static let shared = UserSession()
  
  private var appuser: AppUser?
  
  public func getAppUser() -> AppUser? {
    guard let user = Auth.auth().currentUser else {
        return nil
    }
    DatabaseService.shared.getAPPUser(userId: user.uid) { (result) in
        switch result {
        case .failure(let error):
            print("could not get user \(error)")
        case .success(let appusers):
            guard let appUser = appusers.first else  {
                return
            }
            self.appuser = appUser
            
        }
        
    }
    return appuser
  }
  
}

