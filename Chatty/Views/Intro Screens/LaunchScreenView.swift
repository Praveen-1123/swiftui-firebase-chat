//
//  LaunchScreenView.swift
//  Chatty
//
//  Created by Praveen Murugan on 05/11/21.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        GeometryReader {
            geometry in
            VStack(alignment: .center) {
                Spacer()
                HStack {
                    Spacer()
                    ChattyLogo(size: 200,cornerRadius: 40)
                    Spacer()
                }
                Text(Constants.chattyName)
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .font(.custom("Cochin", size: 60))
                Spacer()
            }
        }
        .background(Constants.chattyBlue)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
