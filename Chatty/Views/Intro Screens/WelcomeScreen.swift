//
//  WelcomeScreen.swift
//  Chatty
//
//  Created by Praveen Murugan on 30/10/21.
//

import SwiftUI

struct WelcomeScreen: View {
    
    @State var selection: Int? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome")
                    .foregroundColor(Constants.chattyBlue)
                    .fontWeight(.semibold)
                    .font(.custom("Optima", size: 40))
                Spacer()
                ChattyLogo(size: 175,cornerRadius: 30)
                Text(Constants.chattyName)
                    .foregroundColor(Constants.chattyBlue)
                    .fontWeight(.heavy)
                    .font(.custom("Cochin", size: 50))
                Spacer()
                NavigationLink(destination: SignInScreen(),
                    tag: 1, selection: $selection) {
                    LargeButton(
                        buttonText: "Get Started",
                        buttonAction: {
                            self.selection = 1
                        })
                }
            }
            .navigationBarHidden(true)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("")
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
