//
//  ContentView.swift
//  Chatty
//
//  Created by Praveen Murugan on 30/10/21.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var firestore: FirestoreManager
    @EnvironmentObject var storage: LocalAppStorage
    
    @State var isActive:Bool = false
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        VStack {
            if self.isActive {
                Group {
                    if (Auth.auth().currentUser != nil) {
                        TabBarView()
                    } else {
                        WelcomeScreen()
                    }
                }
                .onAppear(perform: getUser)
            } else {
                LaunchScreenView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionManager())
            .environmentObject(FirestoreManager())
            .environmentObject(LocalAppStorage())
    }
}
