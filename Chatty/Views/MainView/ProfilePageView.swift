//
//  ProfilePageView.swift
//  Chatty
//
//  Created by Praveen Murugan on 03/11/21.
//

import SwiftUI

struct ProfilePageView: View {
    
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var firestore: FirestoreManager
    
    @State var selection: Int? = nil
    
    func signOut() {
        let signout = session.signOut();
        if(signout) {
            withAnimation(.easeOut(duration: 0.5)) {
                self.selection = 1
            }
        } else {
            print("Can not signout")
        }
    }
    
    var body: some View {
        VStack {
            if selection == nil {
                Group {
                    Text("Current user ID")
                    Text(firestore.userId)
                        .foregroundColor(.blue)
                }
                .onTapGesture {
                    signOut()
                }
            } else if selection == 1 {
                WelcomeScreen()
            } else {
                Text("Something else")
            }
        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
