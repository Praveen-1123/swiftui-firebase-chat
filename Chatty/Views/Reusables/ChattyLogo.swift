//
//  ChattyLogo.swift
//  Chatty
//
//  Created by Praveen Murugan on 30/10/21.
//

import SwiftUI

struct ChattyLogo: View {
    
    @State var size : CGFloat
    @State var cornerRadius: CGFloat
    
    var body: some View {
        Image("chatty_logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(
                cornerRadius: cornerRadius,
                style: .continuous
            ))
    }
}
