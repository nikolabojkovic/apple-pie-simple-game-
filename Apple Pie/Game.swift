//
//  Game.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/16/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

class Game: Undoable {
    var _states: [Game]
    var _state: State
    
    let incorenctMovesAllowed: Int
    var listOfWords: [String]
    
    var currentPlayer: Player!
    var players: [Player]
    
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
    
    internal init() {
        _state = State.new
        _states = [Game]()
        incorenctMovesAllowed = 7
        listOfWords = ["applẼ", "bannana", "orange"]
        wins = 0
        losses = 0
        players = [Player]()
        self.newRound()
    }
    
    internal init(state: State,
         states: [Game]!,
         incorenctMovesAllowed: Int,
         listOfWords: [String],
         players: [Player],
         currentPlayer: Player,
         currentRound: Round,
         wins: Int,
         losses: Int) {
        self._state = state
        self._states = states
        self.incorenctMovesAllowed = incorenctMovesAllowed
        self.listOfWords = listOfWords
        self.currentPlayer = currentPlayer
        self.players = players
        self.currentRound = currentRound
        self.wins = wins
        self.losses = losses
    }
    
    func start() {

    }
    
    func playerGuessed(letter: Character) {
        saveState()
        currentPlayer.score += currentRound.playerGuessed(letter: letter) ? 1 : 0
        updateState()
    }
    
    func playerGuessed(word: String) {
        saveState()
        currentPlayer.score += currentRound.playerGuessed(word: word)
            ? Set(currentRound.word).count + 3 : 0
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
    
    func saveState() {
        
    }
    
}
