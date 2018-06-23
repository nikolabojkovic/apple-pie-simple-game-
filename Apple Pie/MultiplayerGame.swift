//
//  MultiplayerGame.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/18/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

class MultiplayerGame: Game {
    var playersWaitingToPlay: [Player]
    
    override init() {
        self.playersWaitingToPlay = [Player]()
        super.init()
        super.players = [
            Player(name: "Player one"),
            Player(name: "Player two")
        ]
        playersWaitingToPlay.append(contentsOf: super.players)
        currentPlayer = playersWaitingToPlay.removeFirst()
    }
    
    init(state: State,
         states: [Game],
         incorenctMovesAllowed: Int,
         listOfWords: [String],         
         players: [Player],
         currentPlayer: Player,
         currentRound: Round,
         wins: Int,
         losses: Int,
         playersWaitingToPlay: [Player]) {
        self.playersWaitingToPlay = playersWaitingToPlay
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
    
    override func playerGuessed(letter: Character) {
        let currentScore = currentPlayer.score
        super.playerGuessed(letter: letter)
        if currentScore == currentPlayer.score {
            switchToTheNextPlayer()
        }
    }
    
    override func playerGuessed(word: String) {
        let currentScore = currentPlayer.score
        super.playerGuessed(word: word)
        if currentScore == currentPlayer.score {
            switchToTheNextPlayer()
        }
    }
    
    private func switchToTheNextPlayer() {
        playersWaitingToPlay.append(currentPlayer)
        currentPlayer = playersWaitingToPlay.removeFirst()
    }
    
    internal override func saveState() {
        let players = [Player](self.players.map { player in Player(score: player.score, name: player.name) })
        _states.append(MultiplayerGame(state: self._state,
                                       states: self._states,
                                       incorenctMovesAllowed: self.incorenctMovesAllowed,
                                       listOfWords: [String](self.listOfWords),
                                       players: players,
                                       currentPlayer: players.first(where: { player in player.name == self.currentPlayer.name })!,
                                       currentRound: Round(state: self.currentRound.state,
                                                           guessedLetters: [Character](self.currentRound.guessedLetters),
                                                           guessedWords: [String](self.currentRound.guessedWords),
                                                           word: String(self.currentRound.word),
                                                           incorrectMovesRemaining: self.currentRound.incorrectMovesRemaining),
                                       wins: self.wins,
                                       losses: self.losses,
                                       playersWaitingToPlay: players.filter({ player in player.name != currentPlayer.name
                                       })
                                ))
    }
}
