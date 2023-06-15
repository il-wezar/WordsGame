//
//  StartViewModel.swift
//  WordsGame
//
//  Created by Illia Wezarino on 14.06.2023.
//

import Foundation

class StartViewModel: ObservableObject {
    @Published var wordModel: WordModel
    
    init(word: WordModel) {
        self.wordModel = word
    }
    
    func getRandomWord()  {
        DatabaseService.shared.getWord { result in
            switch result {
            case .success(let word):
                print(word)
                self.wordModel = word
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
