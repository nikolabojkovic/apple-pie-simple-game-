//
//  Game.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/16/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

class Game {
    var currentPlayer: Player
    var players: [Player] = []
    
    let incorenctMovesAllowed: Int
    private var _state: State
    var listOfWords: [String]
    
    var currentRound: Round!
    var wins: Int {
        didSet {
            currentPlayer.score += 1
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
        wins = 0
        losses = 0
        players.append(Player(name: "Single player"))
        currentPlayer = players[0]
        self.newRound()
    }
    
    func playerGuessed(letter: Character) {
        currentPlayer.score += currentRound.playerGuessed(letter: letter) ? 1 : 0
        updateState()
    }
        
    private func newRound() {
        currentRound = Round(word: listOfWords.removeFirst(),
                             incorrectMovesRemaining: incorenctMovesAllowed)
    }
    
    private func updateState() {
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
