//
//  MultiplayerGame.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/18/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

class MultiplayerGame: Game {
    var playersWaitingToPlay: [Player] = []
    override init() {
        super.init()
        super.players = []
        super.players.append(Player(name: "Player one"))
        super.players.append(Player(name: "Player two"))
        playersWaitingToPlay.append(contentsOf: super.players)
        currentPlayer = playersWaitingToPlay.removeFirst()
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
}
