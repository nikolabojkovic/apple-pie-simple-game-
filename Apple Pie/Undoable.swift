//
//  Undoable.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/25/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

protocol Undoable {
    var _states: [Game] { get set }
}

extension Undoable {
    
    mutating func saveState() {
        
    }
    
    mutating func undo() -> Game {
        return _states.removeLast()
    }
    
    func redu() -> Game {
        return Game()
    }
}
