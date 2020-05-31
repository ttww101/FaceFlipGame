//
//  RTYUActionViewVC.swift
//  FlipCardGame
//
//  Created by Apple on 4/19/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class RTYUActionViewVC: UIViewController {
    @IBOutlet weak var rtyuSecondLabel: UILabel!
    @IBOutlet weak var rtyuPointLabel: UILabel!
    @IBOutlet weak var rtyuNoEndLabel: UILabel!
    @IBOutlet weak var rtyuActionStackView: UIStackView!
    @IBOutlet weak var rtyuReadyLabel: UILabel!
    @IBOutlet weak var rtyuReadyView: UIView!
    
    var rtyuSteps = 0 {
        didSet {
            rtyuNoEndLabel.text = "步数\n\(rtyuSteps)"
            rtyuNoEndLabel.adjustsFontSizeToFitWidth = true
        }
    }
    var score = 0 {
        didSet {
            rtyuPointLabel.text = "\(score)"
            rtyuPointLabel.adjustsFontSizeToFitWidth = true
        }
    }
    var time = 0 {
        didSet {
            rtyuSecondLabel.text = "時間\n\(time.toTimeString())"
            rtyuSecondLabel.adjustsFontSizeToFitWidth = true
        }
    }
    var rtyuBackTime = 4 {
        didSet {
            if rtyuBackTime <= 3 {
                if rtyuBackTime == 0 {
                    rtyuReadyLabel.text = "开始！"
                } else if rtyuBackTime > 0 {
                    rtyuReadyLabel.text = "准备！\n\(rtyuBackTime)"
                }
            }
        }
    }
    var finishCom = 0
    var rtyuActionAddress = 6
    var stackviews = [UIStackView]()
    var buttons = [UIButton]()
    var rtyuActionG: RTYUActionGame!
    var rtyuOneId: Int?
    var timer: Timer?
    var aCbXRememberVC: RTYURememberVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rtyuActionG = RTYUActionGame()
        rtyuMaskUI(rtyux: nil, rtyuy: nil)
        rtyuRePlayOneTime(rtyux: nil, rtyuy: nil)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UI
    func rtyuMaskUI(rtyux: String?, rtyuy: UIViewController?) {
        setStackView(rtyux: nil, rtyuy: nil)
        setButton(rtyux: nil, rtyuy: nil)
        rtyuMaskActionView(rtyux: nil, rtyuy: nil)
    }
    func setStackView(rtyux: String?, rtyuy: UIViewController?) {
        for _ in 0...2 {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 2
            stackviews.append(stackView)
        }
    }
    func setButton(rtyux: String?, rtyuy: UIViewController?) {
        for i in 0...11 {
            let index = Int(i / 4)
            let button = UIButton()
            button.setBackgroundImage(UIImage(named: "cardback.png"), for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(BtnPressed(_:)), for: .touchUpInside)
            buttons.append(button)
            stackviews[index].addArrangedSubview(button)
        }
    }
    func rtyuMaskActionView(rtyux: String?, rtyuy: UIViewController?) {
        for i in 0..<stackviews.count {
            rtyuActionStackView.addArrangedSubview(stackviews[i])
        }
        self.view.bringSubviewToFront(rtyuReadyView)
    }
    
    // MARK: - btn click event
    @objc func BtnPressed(_ sender: UIButton) {
        let index = sender.tag
        var card = rtyuActionG.gameCards[index]
        if card.isDrawed {
            return
        } else {
            card.isDrawed = true
        }
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            sender.setTitle("", for: .normal)
            sender.setBackgroundImage(UIImage(named: card.image), for: .normal)
        }) {[weak self] (completion) in
            if completion {
                if let vc = self {
                    if let first = vc.rtyuOneId {
                        let firstCard = vc.rtyuActionG.gameCards[first]
                        if firstCard.image == card.image {
                            vc.rtyuOneId = nil
                            vc.finishCom += 1
                            vc.rtyuThisIsYou(rtyux: nil, rtyuy: nil)
                            if vc.finishCom == vc.rtyuActionAddress {
                                vc.rtyuNoMoreTime(rtyux: nil, rtyuy: nil)
                                vc.rtyuThisIsTheEnd(rtyux: nil, rtyuy: nil)
                            }
                        } else {
                            vc.buttons[first].reset()
                            sender.reset()
                            card.isDrawed = false
                            vc.rtyuActionG.gameCards[first].isDrawed = false
                            vc.rtyuOneId = nil
                        }
                    } else {
                        vc.rtyuOneId = index
                    }
                    vc.rtyuSteps += 1
                }
            }
        }
    }
    
    // MARK: - Game
    func rtyuRePlayOneTime(rtyux: String?, rtyuy: UIViewController?) {
        rtyuSteps = 0
        score = 0
        time = 0
        finishCom = 0
        rtyuActionG.start()
        registerReciprocal(rtyux: nil, rtyuy: nil)
        resetCard(rtyux: nil, rtyuy: nil)
    }
    func rtyuReadyPlayThisOne(rtyux: String?, rtyuy: UIViewController?) {
        rtyuNoMoreTime(rtyux: nil, rtyuy: nil)
        rtyuReadyView.isHidden = true
        registerGameTime(rtyux: nil, rtyuy: nil)
    }
    func resetCard(rtyux: String?, rtyuy: UIViewController?) {
        for i in 0..<buttons.count {
            buttons[i].reset()
        }
    }
    func rtyuThisIsTheEnd(rtyux: String?, rtyuy: UIViewController?) {
        aCbXRememberVC = RTYURememberVC(.action)
        aCbXRememberVC.rtyuAddInfo(RTYURememberModel(score: self.score, time: self.time, new: true), rtyux: nil, rtyuy: nil)
        self.addChild(aCbXRememberVC)
        self.view.addSubview(aCbXRememberVC.view)
        self.view.addViewLayout(aCbXRememberVC.view, 40, 40, 20, 20)
        aCbXRememberVC.rtyuReplayBlock = { [weak self] in
            self?.rtyuRePlayOneTime(rtyux: nil, rtyuy: nil)
            self?.aCbXRememberVC.view.removeFromSuperview()
        }
    }
    func rtyuThisIsYou(rtyux: String?, rtyuy: UIViewController?) {
        switch time {
        case 0...5:
            self.score += 8
        case 6...10:
            self.score += 6
        case 11...15:
            self.score += 4
        case 16...20:
            self.score += 2
        default:
            self.score += 1
        }
    }
    
    // MARK: - timer
    func registerReciprocal(rtyux: String?, rtyuy: UIViewController?) {
        rtyuReadyLabel.text = "准备！"
        rtyuReadyView.isHidden = false
        rtyuBackTime = 4
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runReciprocal(_:)), userInfo: nil, repeats: true)
    }
    func registerGameTime(rtyux: String?, rtyuy: UIViewController?) {
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runGameTime(_:)), userInfo: nil, repeats: true)
    }
    @objc func runReciprocal(_ timer: Timer) -> Void {
        if rtyuBackTime < 0 {
            rtyuReadyPlayThisOne(rtyux: nil, rtyuy: nil)
            return
        }
        rtyuBackTime -= 1
    }
    @objc func runGameTime(_ timer: Timer) -> Void {
        time += 1
    }
    func rtyuNoMoreTime(rtyux: String?, rtyuy: UIViewController?) {
        self.timer?.invalidate()
        self.timer = nil
    }

}
