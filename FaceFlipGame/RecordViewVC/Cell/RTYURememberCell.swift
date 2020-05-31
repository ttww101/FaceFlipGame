//
//  RTYURememberCell.swift
//  FlipCardGame
//
//  Created by Apple on 4/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class RTYURememberCell: UITableViewCell {

    @IBOutlet weak var rtyuFirstLastLabel: UILabel!
    @IBOutlet weak var rtyuPointLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rtyuSecondLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        rtyuFirstLastLabel.textColor = UIColor.white
        rtyuPointLabel.textColor = UIColor.white
        pointsLabel.textColor = UIColor.white
        rtyuSecondLabel.textColor = UIColor.white
    }
    func changeColor(_ color: UIColor) {
        rtyuFirstLastLabel.textColor = color
        rtyuPointLabel.textColor = color
        pointsLabel.textColor = color
        rtyuSecondLabel.textColor = color
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
