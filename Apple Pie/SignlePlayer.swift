//
//  SignlePlayer.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/25/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

class SinglePlayerGame: Game {
    
    override init() {
        super.init()
        players = [Player(name: "Single player")]
        currentPlayer = players[0]
    }
    
    init(state: State,
         states: [Game],
         incorenctMovesAllowed: Int,
         listOfWords: [String],
         players: [Player],
         currentPlayer: Player,
         currentRound: Round,
         wins: Int,
         losses: Int) {
        super.init(state: state,
                   states: states,
                   incorenctMovesAllowed: incorenctMovesAllowed,
                   listOfWords: listOfWords,
                   players: players,
                   currentPlayer: currentPlayer,
                   currentRound: currentRound,
                   wins: wins,
                   losses: losses)
    }
    
    internal override func saveState() {
        let players = [Player](self.players.map { player in Player(score: player.score, name: player.name) })
        _states.append(SinglePlayerGame(
            state: self._state,
            states: self._states,
            incorenctMovesAllowed: self.incorenctMovesAllowed,
            listOfWords: [String](self.listOfWords),
            players: players,
            currentPlayer: players[0],
            currentRound: Round(state: self.currentRound.state,
                                guessedLetters: [Character](self.currentRound.guessedLetters),
                                guessedWords: [String](self.currentRound.guessedWords),
                                word: String(self.currentRound.word),
                                incorrectMovesRemaining: self.currentRound.incorrectMovesRemaining),
            wins: self.wins,
            losses: self.losses
        ))
    }
}
