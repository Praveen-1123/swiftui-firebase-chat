//
//  FireStoreManager.swift
//  Chatty
//
//  Created by Praveen Murugan on 04/11/21.
//

import Foundation
import Firebase
import SwiftUI

class FirestoreManager: ObservableObject {
  
    let db = Firestore.firestore()
    
    @AppStorage("userName") var userName: String = ""
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("imageUrl") var imageUrl: String = ""
    @AppStorage("userId") var userId: String = ""
    
    func createUser(userName: String, userId: String, userEmail: String, firstName: String, lastName: String) {
        
        let docRef = db.collection("Users").document(userId)
        
        let docdata: [String: Any] = [
            "userName": userName,
            "userId": userId,
            "email": userEmail,
            "firstName": firstName,
            "lastName": lastName,
            "lastSeen": Date().timeIntervalSince1970,
            "status": "Active",
            "imageUrl": "https://firebasestorage.googleapis.com/v0/b/chatty-app-swift.appspot.com/o/common%2Fuser_image.png?alt=media&token=f8a27307-16cf-455b-a541-ac078969f117"
        ]
        
        docRef.setData(docdata) {error in
            if let error = error {
                print("Can not create user: \(error)")
            } else {
                self.getUserDetails(userId: userId)
                print("User created successfully")
            }
        }
    }
    
    func getUserDetails(userId: String) {
        print("Current User id \(userId)")
        if userId != "" {
            
            let docRef = db.collection("Users").document(userId)
            
            docRef.getDocument {( document, error ) in
                guard error == nil else {
                    print("error", error ?? "")
                    return
                }
                
                if let document = document, document.exists {
                    let data = document.data()
                    if let data = data {
                        self.userName = data["userName"] as? String ?? ""
                        self.firstName = data["firstName"] as? String ?? ""
                        self.lastName = data["lastName"] as? String ?? ""
                        self.email = data["email"] as? String ?? ""
                        self.imageUrl = data["imageUrl"] as? String ?? ""
                        self.userId = data["userId"] as? String ?? ""
                    }
                }
            }
        } else {
            print("No User Found")
        }
    }
}
