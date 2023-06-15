//
//  WordsTextField.swift
//  WordsGame
//
//  Created by Illia Wezarino on 11.06.2023.
//

import SwiftUI

struct WordsTextField: View {
    @State var word: Binding<String>
    var placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: word)
            .font(.title2)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color("dark"), lineWidth: 2))
            .background()
            .foregroundColor(Color("dark"))
    }
}
