//
//  ChattyApp.swift
//  Chatty
//
//  Created by Praveen Murugan on 30/10/21.
//

import SwiftUI
import Firebase

@main
struct ChattyApp: App {
    
    init(){
        FirebaseApp.configure()
    }
 
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionManager())
                .environmentObject(FirestoreManager())
                .environmentObject(LocalAppStorage())
        }
    }
}
