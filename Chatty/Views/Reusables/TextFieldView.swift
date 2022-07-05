//
//  TextFieldView.swift
//  Chatty
//
//  Created by Praveen Murugan on 31/10/21.
//

import SwiftUI

struct TextFieldView: View {
    
    @State var username: String
    @State var hintText: String
    
    var body: some View {
        TextField(
                hintText,
                text: $username
            )
            .textInputAutocapitalization(.never)
            .disableAutocorrection(true)
    }
}
