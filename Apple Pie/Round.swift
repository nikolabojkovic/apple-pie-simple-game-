//
//  Round.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/17/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

struct Round {
    private var _state: State = State.new
    private var guessedLetters: [Character] = []
    var word: String
    var incorrectMovesRemaining: Int
    
    var state: State {
        get { return _state }
    }
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    mutating func playerGuessed(letter: Character) -> Bool {
        guessedLetters.append(letter)
        updateState()
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
            return false
        } else {
            return true
        }        
    }
    
    private mutating func updateState() {
        if (isWon || isLost) {
            _state = State.finished
        }
    
        _state = State.inProgress
    }
    
    var isWon: Bool {
        return word == guessedFormattedWord
    }
    
    var isLost: Bool {
        return incorrectMovesRemaining == 0
    }
    
    var guessedFormattedWord: String {
        return word.map { letter in guessedLetters.contains(letter) ? "\(letter)" : "_" }.joined()
    }
}
