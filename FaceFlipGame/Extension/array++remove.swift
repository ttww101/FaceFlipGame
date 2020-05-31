//
//  array++remove.swift
//  FlipCardGame
//
//  Created by Apple on 4/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension Array {
    mutating func cleanData(_ count: Int) {
        if self.count > count {
            for _ in count..<self.count {
                self.remove(at: count)
            }
        }
    }
}
