//
//  Game.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/16/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

struct Game {
    let incorenctMovesAllowed: Int
    private var _state: State
    var listOfWords: [String]
    
    var currentRound: Round!
    var score: Int
    var wins: Int {
        didSet {
            score += 1
        }
    }
    var losses: Int
    
    var state: State {
        get { return _state }
    }
    
    init() {
        _state = State.new
        incorenctMovesAllowed = 7
        listOfWords = ["apple", "bannana", "orange"]
        score = 0
        wins = 0
        losses = 0
        self.newRound()
    }
    
    mutating func newRound() {
        currentRound = Round(word: listOfWords.removeFirst(),
                             incorrectMovesRemaining: incorenctMovesAllowed)
    }
    
    mutating func playerGuessed(letter: Character) {
        score += currentRound.playerGuessed(letter: letter) ? 1 : 0
        updateState()
    }
    
    private mutating func updateState() {
         if listOfWords.isEmpty && currentRound.isLost{
            losses += 1
            _state = State.finished
            return;
         }
        
         if listOfWords.isEmpty && currentRound.isWon {
            wins += 1
            _state = State.finished
            return;
         }
        
        if currentRound.isLost {
            losses += 1
            newRound()
            return;
        }
        
        if currentRound.isWon {
            wins += 1
            newRound()
            return;
        }
       
        _state = State.inProgress
    }
}
