//
//  Game.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/16/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

class Game {
    
    let incorenctMovesAllowed: Int
    var _state: State
    var listOfWords: [String]
    
    var currentPlayer: Player
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
    
    init() {
        _state = State.new
        incorenctMovesAllowed = 7
        listOfWords = ["applẼ", "bannana", "orange"]
        wins = 0
        losses = 0
        players = [Player(name: "Single player")]
        currentPlayer = players[0]
        self.newRound()
    }
    
    init(state: State,
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
    
    // undo
    
    var _states = [Game]()
    
    internal func saveState() {
        _states.append(Game(
            state: self._state,
            states: self._states,
            incorenctMovesAllowed: self.incorenctMovesAllowed,
            listOfWords: [String](self.listOfWords),
            players: [Player](self.players.map { player in Player(score: player.score, name: player.name) }),
            currentPlayer: Player(score: self.currentPlayer.score, name: self.currentPlayer.name),
            currentRound: Round(state: self.currentRound.state,
                                guessedLetters: [Character](self.currentRound.guessedLetters),
                                guessedWords: [String](self.currentRound.guessedWords),
                                word: String(self.currentRound.word),
                                incorrectMovesRemaining: self.currentRound.incorrectMovesRemaining),
            wins: self.wins,
            losses: self.losses
        ))
    }
    
    func undo() -> Game {
        return _states.removeLast()
    }
    
    func redu() -> Game {
        return Game()
    }
}
