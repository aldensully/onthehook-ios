//
//  FirebaseUtility.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import Foundation
import Firebase

class FirebaseUtility {
    
    static func checkUsernameExists(_ username: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let usersRef = db.collection("users")
        
        usersRef.whereField("username", isEqualTo: username).getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                completion(false)
            } else {
                if let snapshot = querySnapshot, !snapshot.isEmpty {
                    // Username exists
                    completion(true)
                } else {
                    // Username does not exist
                    completion(false)
                }
            }
        }
    }
}
