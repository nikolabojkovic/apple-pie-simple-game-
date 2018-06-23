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
    private var _guessedLetters: [Character] = []
    private var _guessedWords: [String] = []
    var word: String
    let allLetters = ["e": ["e" ,"Ẽ", "Ẽ"]]
    var incorrectMovesRemaining: Int
    
    var guessedLetters: [Character] {
        get { return _guessedLetters }
    }
    
    var guessedWords: [String] {
        get { return _guessedWords }
    }
    
    var state: State {
        get { return _state }
    }
    
    init(word: String, incorrectMovesRemaining: Int) {
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    init(state: State,
         guessedLetters: [Character],
         guessedWords: [String],
         word: String,
         incorrectMovesRemaining: Int) {
        self._state = state
        self._guessedLetters = guessedLetters
        self._guessedWords = guessedWords
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    mutating func playerGuessed(letter: Character) -> Bool {
        var isGuessed = false
        
        if let group = allLetters[String(letter)] {
            for item in group {
                if word.contains(item) {
                    isGuessed = true
                    _guessedLetters.append(Character(item))
                }
            }
        } else {
            // if special letters are not mapped, check for regular guessed letter only,
            // not needed if all letter are mapped to their groups
            isGuessed = word.contains(letter)
            _guessedLetters.append(letter)
        }
        
        if  !isGuessed {
            incorrectMovesRemaining -= 1
        }
        
        updateState()
        return isGuessed
    }
    
    mutating func playerGuessed(word: String) -> Bool {
        let isGuessed = self.word == word
        
        if  !isGuessed {
            incorrectMovesRemaining -= 1
        } else {
            _guessedLetters.append(contentsOf: word)
        }
        
        _guessedWords.append(word)
        
        updateState()
        return isGuessed
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
        return word.map { letter in _guessedLetters.contains(letter) ? "\(letter)" : "_" }.joined()
    }
}
