//
//  Player.swift
//  Apple Pie
//
//  Created by Nikola Bojkovic on 6/19/18.
//  Copyright © 2018 Nikola Bojkovic. All rights reserved.
//

import Foundation

class Player {
    var score = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(score: Int, name: String) {
        self.score = score
        self.name = name
    }
}
