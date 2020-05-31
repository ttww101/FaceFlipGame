//
//  RTYUCard.swift
//  FlipCardGame
//
//  Created by Apple on 4/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

struct RTYUCard {
    var image: String
    var isDrawed = false
    
    static func allImage() -> [String] {
        return ["card01.png", "card02.png", "card03.png", "card04.png", "card05.png", "card06.png"]
    }
}
