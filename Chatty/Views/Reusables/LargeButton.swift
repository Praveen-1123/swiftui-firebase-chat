//
//  LargeButton.swift
//  Chatty
//
//  Created by Praveen Murugan on 31/10/21.
//

import SwiftUI

struct LargeButton: View {
    
    @State var buttonText: String
    @State var buttonAction: () -> Void
    
    var body: some View {
        Button(action:
            buttonAction
        ) {
            Text(buttonText)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Constants.chattyBlue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
        }
    }
}
