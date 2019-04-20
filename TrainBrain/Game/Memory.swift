//
//  Memory.swift
//  TrainBrain
//
//  Created by Роман Чулкевич on 20/04/2019.
//  Copyright © 2019 Роман Чулкевич. All rights reserved.
//

import Foundation

class Memory {
    
    var cards = [Card]()
    var indexOfFaceUpCard: Int?
    var total_clicks: Int
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched {
            return
        }
        
        self.total_clicks += 1
        if let matchIndex = indexOfFaceUpCard, matchIndex != index {
            if cards[matchIndex].face == cards[index].face {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = nil
        } else {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = index
        }
    }
    
    init(numberOfCards: Int) {
        for _ in 1...numberOfCards {
            let card = Card()
            cards += [card]
        }
        total_clicks = 0
    }
    
}

