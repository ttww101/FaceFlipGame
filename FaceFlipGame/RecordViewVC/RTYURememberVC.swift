//
//  RTYURememberVC.swift
//  FlipCardGame
//
//  Created by Apple on 4/26/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

enum rtyuRememberThisType {
    case action, quiet
}

class RTYURememberVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var rtyuGammBtn: UIButton!
    @IBOutlet weak var rtyuRememberTable: UITableView!
    @IBOutlet weak var btnViewHeight: NSLayoutConstraint!
    
    let rtyuUserDefault = UserDefaults.standard
    var rtyuThisMode: rtyuRememberThisType!
    private var rtyuManyData = [RTYURememberModel]()
    
    var rtyuReplayBlock: (() -> Void)?
    
    init(_ rtyuThisMode: rtyuRememberThisType) {
        super.init(nibName: "RTYURememberVC", bundle: nil)
        self.rtyuThisMode = rtyuThisMode
        rtyuGGDD(rtyux: nil, rtyuy: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rtyuRememberTable.register(UINib(nibName: "RTYURememberCell", bundle: nil), forCellReuseIdentifier: "RTYURememberCell")
        rtyuSettingScreen(rtyux: nil, rtyuy: nil)
        rtyuRememberTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    private func rtyuSettingScreen(rtyux: String?, rtyuy: UIViewController?) {
        switch rtyuThisMode! {
        case .action:
            rtyuGammBtn.isHidden = false
        case .quiet:
            rtyuGammBtn.isHidden = true
            btnViewHeight.constant = 120
        }
    }
    
    // MARK: - Data
    private func rtyuGGDD(rtyux: String?, rtyuy: UIViewController?) {
        for i in 0..<rtyuTranslateCD.rtyuPointList.count {
            rtyuManyData.append(RTYURememberModel(score: rtyuTranslateCD.rtyuPointList[i], time: rtyuTranslateCD.rtyuSecondList[i], new: false))
        }
    }
    func rtyuAddInfo(_ data: RTYURememberModel, rtyux: String?, rtyuy: UIViewController?) {
        rtyuManyData.append(data)
        rtyuCleanInfo(rtyux: nil, rtyuy: nil)
        rtyuSubmitInfo(rtyux: nil, rtyuy: nil)
    }
    private func rtyuSubmitInfo(rtyux: String?, rtyuy: UIViewController?) {
        rtyuTranslateCD.rtyuPointList = [Int]()
        rtyuTranslateCD.rtyuSecondList = [Int]()
        for i in 0..<rtyuManyData.count {
            rtyuTranslateCD.rtyuPointList.append(rtyuManyData[i].score)
            rtyuTranslateCD.rtyuSecondList.append(rtyuManyData[i].time)
        }
        self.rtyuUserDefault.set(rtyuTranslateCD.rtyuPointList, forKey: "FlipCardScore")
        self.rtyuUserDefault.set(rtyuTranslateCD.rtyuSecondList, forKey: "FlipCardTime")
        self.rtyuUserDefault.synchronize()
    }
    
    // MARK: - sort
    private func rtyuCleanInfo(rtyux: String?, rtyuy: UIViewController?) {
        rtyuManyData.sort { (data1, data2) -> Bool in
            if data1.score == data2.score {
                return data1.time < data2.time
            } else {
                return data1.score > data2.score
            }
        }
        rtyuManyData.cleanData(10)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rtyuManyData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = rtyuManyData[indexPath.row]
        let cell = rtyuRememberTable.dequeueReusableCell(withIdentifier: "RTYURememberCell", for: indexPath) as! RTYURememberCell
        cell.rtyuFirstLastLabel.text = "\(indexPath.row + 1)."
        cell.rtyuPointLabel.text = "\(data.score)"
        cell.rtyuSecondLabel.text = "\(data.time.toTimeString())"
        if data.new {
            cell.changeColor(.red)
        }
        
        return cell
    }
    
    // MARK: - Button Click
    @IBAction func rtyuReplayClick(_ sender: UIButton) {
        rtyuReplayBlock?()
    }
    @IBAction func rtyuToBackClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
