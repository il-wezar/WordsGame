//
//  PlayerModel.swift
//  WordsGame
//
//  Created by Illia Wezarino on 12.06.2023.
//

import Foundation

struct PlayerModel {
    let name: String
    private(set) var score = 0
    
    mutating func add(score: Int) {
        self.score += score
    }
}
