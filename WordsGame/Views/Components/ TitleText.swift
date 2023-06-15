//
//   TitleText.swift
//  WordsGame
//
//  Created by Illia Wezarino on 11.06.2023.
//

import SwiftUI

struct TitleText: View {
    @State var text: String
    
    var body: some View {
        Text(text)
            .padding()
            .font(.custom("AvenirNext-Bold", size: 42))
            .frame(maxWidth: .infinity)
            .background(Color("dark").opacity(0.9))
            .foregroundColor(.white)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "jojojo")
    }
}
