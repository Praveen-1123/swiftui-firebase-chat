//
//  SessionManager.swift
//  Chatty
//
//  Created by Praveen Murugan on 03/11/21.
//

import SwiftUI
import Firebase
import Combine

class SessionManager : ObservableObject {
    var didChange = PassthroughSubject<SessionManager, Never>()
    var session: User? { didSet { self.didChange.send(self) }}
    var isLoggedIn = false { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?

    func listen () {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                print("Got user \(user)")
                self.isLoggedIn = true
                self.session = User(
                    uid: user.uid,
                    email: user.email
                )
            } else {
                print("Can not listen auth")
                self.isLoggedIn = false
                self.session = nil
            }
        }
    }
    
    func signUp(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }

    func signIn(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
        ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }

    func signOut () -> Bool {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.session = nil
            return true
        } catch {
            return false
        }
    }
}
