//
//  Card.swift
//  Concentration
//
//  Created by Сергей Дорошенко on 18/07/2019.
//  Copyright © 2019 Сергей Дорошенко. All rights reserved.
//

import Foundation

struct Card {
    
    var isFaceUp = false
    var isMatched = false
    var isUsed = false
    var identifier: Int
    
    static var indentifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        indentifierFactory += 1
        return indentifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

