//
//  RTYUManyCards.swift
//  FlipCardGame
//
//  Created by Apple on 4/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

struct RTYUManyCards {
    var cards = [RTYUCard]()
    
    init() {
        let allImage = RTYUCard.allImage()

        for _ in 0...1 {
            for i in 0...allImage.count - 1 {
                let card = RTYUCard(image: allImage[i], isDrawed: false)
                cards.append(card)
            }
        }
    }
}
