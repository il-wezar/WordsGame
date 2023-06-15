//
//  WordCell.swift
//  WordsGame
//
//  Created by Illia Wezarino on 12.06.2023.
//

import SwiftUI

struct WordCell: View {
    let word: String
    
    var body: some View {
        HStack {
            Text(word)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding()
                .font(.custom("AvenirNext-Bold", size: 22))
            Text("\(word.count)")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                .padding()
                .font(.custom("AvenirNext-Bold", size: 22))
        }
        .listRowSeparator(.hidden)
        .foregroundColor(.white)
    }
}

struct WordCell_Previews: PreviewProvider {
    static var previews: some View {
        WordCell(word: "магнит")
    }
}
