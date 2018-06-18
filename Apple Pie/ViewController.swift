//
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
        game = Game()
        updateUI()
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWorrdLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var game: Game!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        game.playerGuessed(letter: Character(sender.title(for: .normal)!.lowercased()))
        updateUI()
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Game()
        updateUI()
    }
    
    func updateUI() {
        updateImage()
        updateLetterButtons(gameState: game.state, roundState: game.currentRound.state)
        updateLabels()
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
    }
    
    func updateLabels() {
                             var letters = [String]()
                                 letters = game.currentRound.guessedFormattedWord.map { String($0) }
        correctWorrdLabel.text = letters.joined(separator: " ")
        
               scoreLabel.text = "Wins: \(game.wins), Losses: \(game.losses), Score: \(game.score)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

