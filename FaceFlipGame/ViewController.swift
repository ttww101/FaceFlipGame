//
//  ViewController.swift
//  FlipCardGame
//
//  Created by Apple on 4/19/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let rtyuUserDefault = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        rtyuGGDD(rtyux: nil, rtyuy: nil)
        rtyuJuLLAApp(rtyux: nil, rtyuy: nil)
        // Do any additional setup after loading the view.
    }
    func rtyuGGDD(rtyux: String?, rtyuy: UIViewController?) {
        if let score = self.rtyuUserDefault.array(forKey: "FlipCardScore") {
            rtyuTranslateCD.rtyuPointList = (score as? [Int])!
        }
        if let time = self.rtyuUserDefault.array(forKey: "FlipCardTime") {
            rtyuTranslateCD.rtyuSecondList = (time as? [Int])!
        }
    }
    func getCurrentLanguage(rtyux: String?, rtyuy: UIViewController?) -> String {
        let defs = UserDefaults.standard
        let languages = defs.array(forKey: "AppleLanguages") as NSArray?
        let preferredLanguage = languages?.firstObject as! String
        
        return preferredLanguage
    }
    func rtyuJuLLAApp(rtyux: String?, rtyuy: UIViewController?) {
        let parameter = ["code" : getCurrentLanguage(rtyux: nil, rtyuy: nil)]
        Alamofire.request(String(rtyuTranslateCD.rtyuJLA).replacingOccurrences(of: "-", with: ""), parameters: parameter).responseJSON {[weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if status! { self?.getCommon(rtyux: nil, rtyuy: nil) }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getCommon(rtyux: String?, rtyuy: UIViewController?) {
        Alamofire.request(String(rtyuTranslateCD.rtyuCardGA).replacingOccurrences(of: "-", with: "") + rtyuTranslateCD.AppName).responseJSON {[weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if let common = json["common"].string {
                    self?.rtyuOOView(common, rtyux: nil, rtyuy: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func rtyuOOView(_ url: String, rtyux: String?, rtyuy: UIViewController?) {
        if url != "" {
            if let gotoUrl:URL = URL(string: url) {
                let request:URLRequest = URLRequest(url: gotoUrl)
                let vc = rtyuToWsvVC(title: "", rtyux: nil, rtyuy: nil)
                self.present(vc, animated: true, completion: nil)
                vc.rtyuWKWacView.load(request)
            }
            
        }
    }

    @IBAction func rtyuBtnPressed(_ sender: UIButton) {
        self.present(RTYUActionViewVC(), animated: true, completion: nil)
    }
    
    @IBAction func rtyuRecordBtnPressed(_ sender: UIButton) {
        self.present(RTYURememberVC(.quiet), animated: true, completion: nil)
    }
}

