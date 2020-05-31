//
//  UIButton++reset.swift
//  FlipCardGame
//
//  Created by Apple on 4/25/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UIButton {
    func reset() {
        UIView.transition(with: self, duration: 0.35, options: .transitionFlipFromRight, animations: {
            self.setBackgroundImage(UIImage(named: "cardback.png"), for: .normal)
        }, completion: nil)
    }
}
