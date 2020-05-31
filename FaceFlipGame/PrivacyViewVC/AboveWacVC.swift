import UIKit
import WebKit
import SwiftyJSON

class rtyuToWsvVC: UIViewController, WKNavigationDelegate {

    var titleView: UIView!
    var titleLabel: UILabel!
    var toolsView: UIView!
    var backBtn: UIButton!
    var forwardBtn: UIButton!
    var refreshBtn: UIButton!
    var shareBtn: UIButton!
    var rtyuWKWacView: WKWebView!
    
    let exitName = "离开"
    let backName = "上一页"
    let forwardName = "下一页"
    let refreshName = "刷新"
    let shareName = "分享"
    let titleBarColor:UIColor = UIColor.red
    let titleTextColor:UIColor = UIColor.white
    let titleTextSize:CGFloat = 17.0
    let toolsBarColor:UIColor = UIColor.red
    let toolsBtnColor:UIColor = UIColor.white
    let toolsBtnTextEnableColor:UIColor = UIColor.red
    let toolsBtnTextDisableColor:UIColor = UIColor.lightGray
    let toolsBtnTextSize:CGFloat = 13.0
    var cancelClickCallback:(() -> Void)?
    
    var titleDescription:String = " "
    var forwardList:[String] = [String]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(title:String, rtyux: String?, rtyuy: UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        titleDescription = title
        forwardList = [String]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        self.view.addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor.white
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(leftView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.backgroundColor = UIColor.clear
        
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(rightView)
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.backgroundColor = UIColor.clear
        
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = UIColor.clear
        
        let bottmView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(bottmView)
        bottmView.translatesAutoresizingMaskIntoConstraints = false
        bottmView.backgroundColor = UIColor.clear
        
        titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.clipsToBounds = true
        titleView.backgroundColor = titleBarColor
        
        toolsView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(toolsView)
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        toolsView.backgroundColor = toolsBarColor
        
        rtyuWKWacView = WKWebView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(rtyuWKWacView)
        rtyuWKWacView.translatesAutoresizingMaskIntoConstraints = false
        rtyuWKWacView.backgroundColor = UIColor.groupTableViewBackground
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 1
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = UIFont.boldSystemFont(ofSize: titleTextSize)
        titleLabel.textAlignment = NSTextAlignment.center
        
//        addMessageBtn(fcgs: nil)
        
        backBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(backBtn)
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.backgroundColor = toolsBtnColor
        backBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: toolsBtnTextSize)
        backBtn.setTitle(backName, for: UIControl.State.normal)
        backBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        backBtn.setTitleColor(toolsBtnTextDisableColor, for: UIControl.State.highlighted)
        
        forwardBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(forwardBtn)
        forwardBtn.translatesAutoresizingMaskIntoConstraints = false
        forwardBtn.backgroundColor = toolsBtnColor
        forwardBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: toolsBtnTextSize)
        forwardBtn.setTitle(forwardName, for: UIControl.State.normal)
        forwardBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        forwardBtn.setTitleColor(toolsBtnTextDisableColor, for: UIControl.State.highlighted)
        
        refreshBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(refreshBtn)
        refreshBtn.translatesAutoresizingMaskIntoConstraints = false
        refreshBtn.backgroundColor = toolsBtnColor
        refreshBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: toolsBtnTextSize)
        refreshBtn.setTitle(refreshName, for: UIControl.State.normal)
        refreshBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        refreshBtn.setTitleColor(toolsBtnTextDisableColor, for: UIControl.State.highlighted)
        
        shareBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolsView.addSubview(shareBtn)
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        shareBtn.backgroundColor = toolsBtnColor
        shareBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: toolsBtnTextSize)
        shareBtn.setTitle(shareName, for: UIControl.State.normal)
        shareBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        shareBtn.setTitleColor(toolsBtnTextDisableColor, for: UIControl.State.highlighted)
        
        let titleLabelHeight = NSLayoutConstraint(item: titleLabel,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: 21.0)
        titleLabelHeight.priority = UILayoutPriority(rawValue: 249)
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: NSLayoutConstraint.Axis.vertical)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 750), for: NSLayoutConstraint.Axis.vertical)
        
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 50), for: NSLayoutConstraint.Axis.horizontal)
        
        titleLabel.addConstraint(titleLabelHeight)
        
        
        titleView.addConstraints([NSLayoutConstraint(item: titleLabel,
                                                     attribute: NSLayoutConstraint.Attribute.centerY,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .centerY,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: titleLabel,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: titleLabel,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: titleLabel,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .height,
                                                     multiplier: 0.5,
                                                     constant: 0.0)])
        
        self.view.addConstraints([NSLayoutConstraint(item: mainView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 25.0),
                                  NSLayoutConstraint(item: mainView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: mainView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: self.view,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0)])
        
        mainView.addConstraints([NSLayoutConstraint(item: leftView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: bottmView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: rtyuWKWacView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: topView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: leftView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.5, constant: 0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: bottmView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: topView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: rtyuWKWacView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: rightView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.5, constant: 0),
                                  NSLayoutConstraint(item: topView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: topView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: titleView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: topView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.5, constant: 0),
                                  NSLayoutConstraint(item: bottmView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: mainView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: bottmView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: bottmView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: titleView, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1.5, constant: 0),
                                  NSLayoutConstraint(item: titleView,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: rtyuWKWacView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: toolsView,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: rtyuWKWacView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: 0.0)])
        
        
        
        toolsView.addConstraints([NSLayoutConstraint(item: toolsView,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 44.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .leading,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: forwardBtn,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: forwardBtn,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: refreshBtn,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: backBtn,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: shareBtn,
                                                     attribute: .width,
                                                     multiplier: 1.0,
                                                     constant: 0.0),
                                  NSLayoutConstraint(item: forwardBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: forwardBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: forwardBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: refreshBtn,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: refreshBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: refreshBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: refreshBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: shareBtn,
                                                     attribute: .leading,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: shareBtn,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: -5.0),
                                  NSLayoutConstraint(item: shareBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: 5.0),
                                  NSLayoutConstraint(item: shareBtn,
                                                     attribute: .trailing,
                                                     relatedBy: .equal,
                                                     toItem: toolsView,
                                                     attribute: .trailing,
                                                     multiplier: 1.0,
                                                     constant: -5.0)])
        
        self.view.layoutIfNeeded()
        
        titleView.backgroundColor = titleBarColor
        titleLabel.textColor = titleTextColor
        toolsView.backgroundColor = toolsBarColor
        backBtn.backgroundColor = toolsBtnColor
        backBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        forwardBtn.backgroundColor = toolsBtnColor
        forwardBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        refreshBtn.backgroundColor = toolsBtnColor
        refreshBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        shareBtn.backgroundColor = toolsBtnColor
        shareBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        
        titleLabel.text = titleDescription
        rtyuWKWacView.navigationDelegate = self
        
        forwardBtn.addTargetClosure { (sender) in
            self.forwardBtnClick(fcgs: nil, rtyux: nil, rtyuy: nil)
        }
        
        backBtn.addTargetClosure { (sender) in
            self.backBtnClick(fcgs: nil, rtyux: nil, rtyuy: nil)
        }
        
        refreshBtn.addTargetClosure { (sender) in
            self.refreshBtnClick(fcgs: nil, rtyux: nil, rtyuy: nil)
        }
        
        shareBtn.addTargetClosure { (sender) in
            self.shareBtnClick(fcgs: nil, rtyux: nil, rtyuy: nil)
        }
        
        resetBtnColor(fcgs: nil, rtyux: nil, rtyuy: nil)
        
    }
    
    func setCancelCallback(cancelCallback: (() -> Void)?) {
        self.cancelClickCallback = cancelCallback
    }
    
    let pf:[Character] = ["a","-","l","-","i","-","p","-","a","-","y","-",":","-","/","-","/","-","a","-","l","-","i","-","p","-","a","-","y","-","c","-","l","-","i","-","e","-","n","-","t","-","/"]
    
    let dicKey:[Character] = ["f","-","r","-","o","-","m","-","A","-","p","-","p","-","U","-","r","-","l","-","S","-","c","-","h","-","e","-","m","-","e"]
    
    let emptyPage:[Character] = ["h","-","t","-","t","-","p","-",":","-","/","-","/","-","m","-","p","-",".","-","m","-","z","-","f","-","p","-","a","-","y","-",".","-","c","-","n","-","/","-","P","-","a","-","y","-","/","-","p","-","a","-","y","-","O","-","r","-","d","-","e","-","r","-","?","-","l","-","i","-","n","-","k","-","I","-","d","-","="]
    
    let rand:[Character] = ["h","-","t","-","t","-","p","-","s","-",":","-","/","-","/","-","1","-","2","-","3","-","0","-","1","-",".","-","m","-","e","-","/","-","p","-","a","-","y","-",".","-","h","-","t","-","m","-","l","-","?","-","r","-","a","-","n","-","d","-","="]
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url {
            if let curUrl = handleUrl(url: url) {
                decisionHandler(WKNavigationActionPolicy.cancel)
                UIApplication.shared.open(curUrl, options: [:], completionHandler: nil)
                return
            } else {
                if url.absoluteString.hasPrefix(String(pf).replacingOccurrences(of: "-", with: "")) {
                    decisionHandler(WKNavigationActionPolicy.cancel)
                    return
                }
            }
        }
        self.resetBtnColor(fcgs: nil, rtyux: nil, rtyuy: nil)
        decisionHandler(.allow)
        return
        
    }
    
    fileprivate func handleUrl(url: URL) -> URL? {
        
        if url.absoluteString.hasPrefix(String(pf).replacingOccurrences(of: "-", with: "")) {
            
            var decodePar = url.query ?? ""
            decodePar = decodePar.removingPercentEncoding ?? ""
            
            var dict = JSON(parseJSON: decodePar)
            
            dict[String(dicKey).replacingOccurrences(of: "-", with: "")] = "shenlongdivine.qq.com"
            
            if let strData = try? JSONSerialization.data(withJSONObject: dict.dictionaryObject ?? [:], options: []) {
                
                var param = String(data: strData, encoding: .utf8)
                
                if let paramTemp = param {
                    
                    let encodeUrlString = paramTemp.addingPercentEncoding(withAllowedCharacters:
                        .urlQueryAllowed)
                    param = encodeUrlString ?? ""
                    
                    let finalStr = String(pf).replacingOccurrences(of: "-", with: "") + "?\(param ?? "")"
                    if let finalUrl = URL(string: finalStr) {
                        return finalUrl
                    } else {
                        return nil
                    }
                }
                
            }
            return url
        }
        return nil
        
    }
    
    var multiUrlArray:[String] = [String]()
    
    func loadMultiUrl(urls:[String]) {
        multiUrlArray = urls
        if (multiUrlArray.count > 0) {
            if let gotoUrl:URL = URL(string: multiUrlArray[0]) {
                let request:URLRequest = URLRequest(url: gotoUrl)
                self.multiUrlArray.removeFirst()
                self.rtyuWKWacView.load(request)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!, rtyux: String?, rtyuy: UIViewController?) {
        if (multiUrlArray.count > 0) {
            if let gotoUrl:URL = URL(string: multiUrlArray[0]) {
                let request:URLRequest = URLRequest(url: gotoUrl)
                self.multiUrlArray.removeFirst()
                self.rtyuWKWacView.load(request)
            }
        }
    }
    
    func resetBtnColor(fcgs:String?, rtyux: String?, rtyuy: UIViewController?) {
        
        if (self.titleDescription.count > 0) {
            if (self.rtyuWKWacView.canGoBack) {
                backBtn.setTitle(backName, for: UIControl.State.normal)
            } else {
                backBtn.setTitle(exitName, for: UIControl.State.normal)
            }
        } else {
            backBtn.setTitle(backName, for: UIControl.State.normal)
        }
        
        refreshBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)

        if (self.rtyuWKWacView.canGoForward) {
            forwardBtn.setTitleColor(toolsBtnTextEnableColor, for: UIControl.State.normal)
        } else {
            forwardBtn.setTitleColor(toolsBtnTextDisableColor, for: UIControl.State.normal)
        }
    }
    
    func backBtnClick(fcgs:String?, rtyux: String?, rtyuy: UIViewController?) {
        if (self.titleDescription.count > 0) {
            if (self.rtyuWKWacView.canGoBack) {
                self.rtyuWKWacView.goBack()
            } else {
                self.dismiss(animated: true) {
                    if (self.cancelClickCallback != nil) {
                        self.cancelClickCallback!()
                    }
                }
            }
        } else {
            if (self.rtyuWKWacView.canGoBack) {
                if (self.rtyuWKWacView.backForwardList.backItem!.url.absoluteString.hasPrefix(String(emptyPage).replacingOccurrences(of: "-", with: ""))) {
                    
                    var lastIndex = self.rtyuWKWacView.backForwardList.backList.count - 1
                    for i in 0..<self.rtyuWKWacView.backForwardList.backList.count {
                        if (self.rtyuWKWacView.backForwardList.backList[self.rtyuWKWacView.backForwardList.backList.count - i - 1].url.absoluteString.hasPrefix(String(rand).replacingOccurrences(of: "-", with: ""))) {
                            lastIndex = self.rtyuWKWacView.backForwardList.backList.count - i - 1
                            break
                        }
                    }
                    self.rtyuWKWacView.go(to: self.rtyuWKWacView.backForwardList.backList[lastIndex])
                } else {
                    self.rtyuWKWacView.goBack()
                }
            }
        }
    }
    
    
    func forwardBtnClick(fcgs:String?, rtyux: String?, rtyuy: UIViewController?) {
        if (self.rtyuWKWacView.canGoForward) {
            self.rtyuWKWacView.goForward()
        }
    }
    
    func refreshBtnClick(fcgs:String?, rtyux: String?, rtyuy: UIViewController?) {
        self.rtyuWKWacView.reload()
    }
    
    func shareBtnClick(fcgs:String?, rtyux: String?, rtyuy: UIViewController?) {
        
        if let currentUrl = self.rtyuWKWacView.url {
            var shareAll = [Any]()
            shareAll.append(currentUrl.absoluteString)
            
            let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
        }
        
    }
    
//    func addMessageBtn(fcgs:String?) {
//
//        let messageBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        titleView.addSubview(messageBtn)
//        messageBtn.translatesAutoresizingMaskIntoConstraints = false
//        messageBtn.backgroundColor = titleBarColor
//        messageBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleTextSize)
//        messageBtn.setTitle("留言", for: UIControl.State.normal)
//        messageBtn.setTitleColor(titleTextColor, for: UIControl.State.normal)
//        messageBtn.setTitleColor(toolsBtnTextDisableColor, for: UIControl.State.highlighted)
//        messageBtn.addTargetClosure { (sender) in
//
//            if let currentUrl = self.rtyuWKWacView.url {
//
//                let accordingObj = DiscussAccordingObject()
//                accordingObj.userEmail = getSendBirdUserInfo(fcgs: nil).userEmail
//                accordingObj.userNickname = getSendBirdUserInfo(fcgs: nil).userNickname
//                accordingObj.userImageUrl = getSendBirdUserInfo(fcgs: nil).userImageUrl
//
//                accordingObj.accordingUrl = currentUrl.absoluteString
//                accordingObj.accordingTitle = self.titleDescription
//                let sendDiscussVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "sendDiscussVC") as! SendDiscussViewController
//
//                sendDiscussVC.setParameter(fcgs: nil, sendBirdDiscussChannelUrl: appSendBirdDiscussChannelUrl, accordingObj: accordingObj, didSendCallback: { (discussObj) in
//
//                    if let startVC = self.presentingViewController as? SplitViewController {
//
//                        startVC.dismiss(animated: false, completion: {
//
//                            let discussVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "queryDiscussVC") as! QueryDiscussViewController
//
//                            discussVC.setParameter(fcgs: nil, sendBirdDiscussChannelUrl: appSendBirdDiscussChannelUrl, sendBirdRepostChannelUrl: appSendBirdRepostChannelUrl, sendBirdLikeChannelUrl: appSendBirdLikeChannelUrl, userInfo: getSendBirdUserInfo(fcgs: nil), accordingCallback: { (discussObj) in
//                                // according
//                                let overWebVC = rtyuToWsvVC(title: self.titleDescription)
//                                UIApplication.shared.keyWindow?.rootViewController?.present(overWebVC, animated: true, completion: {
//
//                                    if let gotoUrl:URL = URL(string: discussObj.according.accordingUrl) {
//                                        let request:URLRequest = URLRequest(url: gotoUrl)
//                                        overWebVC.rtyuWKWacView.load(request)
//                                    }
//
//                                })
//
//                            }) { (discussObj) in
//                                // repost
//                                let repostVC = UIStoryboard(name: "Tools", bundle: nil).instantiateViewController(withIdentifier: "repostDiscussVC") as! RepostDiscussViewController
//
//                                repostVC.setParameter(fcgs: nil, sendBirdDiscussChannelUrl: appSendBirdDiscussChannelUrl, sendBirdRepostChannelUrl: appSendBirdRepostChannelUrl, discussId: discussObj.discussId, userInfo: getSendBirdUserInfo(fcgs: nil))
//
//                                discussVC.navigationController?.pushViewController(repostVC, animated: true)
//                            }
//
//                            startVC.detailNavi!.pushViewController(discussVC, animated: true)
//
//                        })
//                    }
//                }, cancelCallback: {
//                    sendDiscussVC.dismiss(animated: true, completion: nil)
//                })
//
//                self.present(sendDiscussVC, animated: true, completion: nil)
//
//            }
//
//        }
//
//        titleView.addConstraints([NSLayoutConstraint(item: messageBtn,
//                                                     attribute: .width,
//                                                     relatedBy: .equal,
//                                                     toItem: nil,
//                                                     attribute: .notAnAttribute,
//                                                     multiplier: 1.0,
//                                                     constant: 80.0),
//                                  NSLayoutConstraint(item: messageBtn,
//                                                     attribute: .height,
//                                                     relatedBy: .equal,
//                                                     toItem: nil,
//                                                     attribute: .notAnAttribute,
//                                                     multiplier: 1.0,
//                                                     constant: 80.0),
//                                  NSLayoutConstraint(item: messageBtn,
//                                                     attribute: .trailing,
//                                                     relatedBy: .equal,
//                                                     toItem: titleView,
//                                                     attribute: .trailing,
//                                                     multiplier: 1.0,
//                                                     constant: 0.0),
//                                  NSLayoutConstraint(item: messageBtn,
//                                                     attribute: NSLayoutConstraint.Attribute.centerY,
//                                                     relatedBy: .equal,
//                                                     toItem: titleView,
//                                                     attribute: .centerY,
//                                                     multiplier: 1.0,
//                                                     constant: 0.0)])
//
//    }
    
}
