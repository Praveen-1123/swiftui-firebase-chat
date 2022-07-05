//
//  TestFile.swift
//  Chatty
//
//  Created by Praveen Murugan on 31/10/21.
//

import SwiftUI

struct TextFieldView: View {

    // Constants, so all "TextFields will be the same in the app"
    let fontSize: CGFloat
    let backgroundColor: Color
    let textColor: Color

    // The @State Object
    @Binding var field: String

    // A custom variable for a "TextField"
    @Binding var isHighlighted: Bool

    init(field: Binding<String>, isHighlighted: Binding<Bool>, fontSize: CGFloat = 14, backgroundColor: Color = Color(UIColor.lightGray).opacity(0.3), textColor:Color = .white) {
        self._field = field
        self._isHighlighted = isHighlighted
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
        self.textColor = textColor
    }

    var body: some View {
        TextField(field, text: $field)
            .font(Font.system(size: fontSize))
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(backgroundColor))
            .foregroundColor(textColor)
            .padding()
    }
}
