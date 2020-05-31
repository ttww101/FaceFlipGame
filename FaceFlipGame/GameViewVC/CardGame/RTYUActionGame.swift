//
//  RTYUActionGame.swift
//  FlipCardGame
//
//  Created by Apple on 4/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GameplayKit

struct RTYUActionGame {
    var gameCards = [RTYUCard]()
    let manyCards: RTYUManyCards
    
    init() {
        manyCards = RTYUManyCards()
        start()
    }
    
    mutating func start() {
        gameCards.removeAll()
        
        var cards = manyCards.cards
        
        let shuffledDistribution = GKShuffledDistribution(lowestValue: 0, highestValue: cards.count - 1)
        for _ in 0..<cards.count {
            let index  = shuffledDistribution.nextInt()
            let card = cards[index]
            gameCards.append(card)
        }
    }
}
