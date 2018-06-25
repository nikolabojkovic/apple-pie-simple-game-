
//  ViewController.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/16/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        create(SinglePlayerGame())
        updateUI()
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWorrdLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    @IBOutlet weak var fullTextGuess: UITextField!
    @IBOutlet weak var undoButton: UIButton!
    
    var game: Game!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        game.playerGuessed(letter: Character(sender.title(for: .normal)!.lowercased()))
        updateUI()
    }
    
    @IBAction func buttonGuessFullWordPressed(_ sender: UIButton) {
        game.playerGuessed(word: fullTextGuess.text!)
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        create(SinglePlayerGame())
        updateUI()
    }
    
    @IBAction func newMultiplayserGame(_ sender: UIButton) {
        create(MultiplayerGame())
        updateUI()
    }
    
    @IBAction func undo(_ sender: UIButton) {
        undo()
    }
    
    func create(_ game: Game) {
        self.game = game
        self.game.start()
    }
    
    func undo() {
        game = game.undo()
        updateUI()
    }
    
    func updateUI() {
        updateImage()
        updateLetterButtons(gameState: game.state, roundState: game.currentRound.state)
        
        if (game as? MultiplayerGame) != nil {
            updateLabelsForMultiplePlayer()
        } else {
            updateLabels()
        }
        
        undoButton.isEnabled = game.state != State.new
        if let lastWord = game.currentRound.guessedWords.last {
            fullTextGuess.text = lastWord
        }
    }
    
    func updateImage() {
        treeImageView.image = UIImage(named: "Tree \(game.currentRound.incorrectMovesRemaining)")
    }
    
    func updateLetterButtons(gameState: State, roundState: State) {
        if gameState == State.finished {
            letterButtons.forEach { button in button.isEnabled = false }
            return
        }
        
        if roundState == State.new || gameState == State.new {
            letterButtons.forEach { button in button.isEnabled = true }
            return;
        }
        
        if gameState == State.inProgress {
          letterButtons.forEach { button in button.isEnabled = !game.currentRound.guessedLetters.contains((Character)(button.title(for: .normal)!.lowercased())) }
        }
    }
    
    func updateLabels() {
                             var letters = [String]()
                                 letters = game.currentRound.guessedFormattedWord.map { String($0) }
        correctWorrdLabel.text = letters.joined(separator: " ")
        
               scoreLabel.text = "Wins: \(game.wins), Losses: \(game.losses), Score: \(game.currentPlayer.score)"
    }
    
    func updateLabelsForMultiplePlayer() {
                             var letters = [String]()
                                 letters = game.currentRound.guessedFormattedWord.map { String($0) }
        correctWorrdLabel.text = letters.joined(separator: " ")
        
        if game.state == State.finished {
            let playerWithMaxScore = game.players.max { (p1, p2) -> Bool in
                p1.score < p2.score
            }
            
            scoreLabel.text = game.players.filter( { $0.score == playerWithMaxScore!.score }).count == game.players.count ? " Tie " : "\(playerWithMaxScore!.name)" + " won!"
            return
        }
        
        scoreLabel.text = (game.players[0].name == game.currentPlayer.name ? "(Your turn) " : "") +
                          "\(game.players[0].name): \(game.players[0].score) points" +
                          "    |    " +
                          (game.players[1].name == game.currentPlayer.name ? "(Your turn) " : "") +
                          "\(game.players[1].name): \(game.players[1].score) points"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

