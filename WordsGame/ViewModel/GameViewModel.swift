//
//  GameViewModel.swift
//  WordsGame
//
//  Created by Illia Wezarino on 12.06.2023.
//

import Foundation

enum WordError: Error {
    case theSameWord
    case beforeWord
    case littleWord
    case wrongWord
}

class GameViewModel: ObservableObject {
    @Published var firstPlayer: PlayerModel
    @Published var secondPlayer: PlayerModel
    @Published var words = [String]()
    let word: String
    var isFirst = true
    
    init(firstPlayer: PlayerModel, secondPlayer: PlayerModel, word: String) {
        self.firstPlayer = firstPlayer
        self.secondPlayer = secondPlayer
        self.word = word.uppercased()
    }
    
    func validate(word: String) throws {
        let word = word.uppercased()
        guard word != self.word else {
            print("This word is unavilable")
            throw WordError.theSameWord
        }
        
        guard !(words.contains(word)) else {
            print("This word also been used")
            throw WordError.beforeWord
        }
        
        guard word.count > 1 else {
            print("This word is too short")
            throw WordError.littleWord
        }
        return
    }
    
    func wordToChars(word: String) -> [Character] {
        var chars = [Character]()
        
        for char in word.uppercased() {
            chars.append(char)
        }
        return chars
    }
    
    func cheak(word: String) throws -> Int {
        do {
            try self.validate(word: word)
        } catch {
            throw error
        }
        
        var bigWordArray = wordToChars(word: self.word)
        let smallWordArray = wordToChars(word: word)
        var  result = ""
        
        for char in smallWordArray {
            if bigWordArray.contains(char) {
                result.append(char)
                var i = 0
                while bigWordArray[i] != char {
                    i += 1
                }
                bigWordArray.remove(at: i)
                
            } else {
                throw WordError.wrongWord
            }
        }
        
        guard result == word.uppercased() else { return 0 }
        
        words.append(result)
        if  isFirst {
            firstPlayer.add(score: result.count)
        } else {
            secondPlayer.add(score: result.count)
        }
        isFirst.toggle()
        return result.count
    }
}
