//
//  TabBarView.swift
//  Chatty
//
//  Created by Praveen Murugan on 03/11/21.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            MainChatView()
                .tabItem {
                    Label("Chats", systemImage: "message")
                }
            GroupsPageView()
                .tabItem {
                    Label("Groups", systemImage: "person.3.fill")
                }
            ProfilePageView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        .accentColor(Constants.chattyBlue)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
