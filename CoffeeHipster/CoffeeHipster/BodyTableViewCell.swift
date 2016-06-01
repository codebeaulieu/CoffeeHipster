//
//  BodyTableViewCell.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//
extension Int {
    func createDecimal(number: Int) -> Double {
        return Double("\(self).\(number)")! ?? 0
    }
}

extension Double {
    func getIndexPath() -> Int {
        return Int(Float(self % 1))
     
    }
}



import UIKit
var token: dispatch_once_t = 0
class BodyTableViewCell: UITableViewCell, UIWebViewDelegate {

    @IBOutlet weak var postWebViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postWebView: UIWebView!
    private var ObservationContext = 0
    private var observing = false
    var postBody : String!
    var position : Double! {
        didSet {
            ObservationContext = Int(position * 10)
            print("MyObservationContext \(ObservationContext)")
        }
    }
    private var _height : CGFloat = 0
    var height: CGFloat! {
        get {
         
            return _height
        }
        set {
            print("old height: \(_height)")
            print("new height: \(newValue)")
            if _height != newValue {
                _height = newValue
                    print("not equal")
                    var userInfo = [String:AnyObject]()
                    userInfo["Height"] = self.height
                    userInfo["Position"] = self.position!
                    
                    NSNotificationCenter.defaultCenter().postNotificationName("questionLoadedId", object: nil, userInfo: userInfo)
            } else {
                stopObservingHeight()
            }
        }
    }
    
    
    private var _setOnce : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadBody(body: String) {
        postBody = body
        print("body : \(postBody)")
        guard let body = postBody else { return }
        let fixImage = body.imageFix()
        postWebView.loadHTMLString(fixImage, baseURL: nil)
        postWebView.scrollView.scrollEnabled = false
        postWebView.userInteractionEnabled = false
        postWebView.delegate = self
        // Update cell UI as you wish
        
    }

    func startObservingHeight() {
        let options = NSKeyValueObservingOptions([.New])
        postWebView.scrollView.addObserver(self, forKeyPath: "contentSize", options: options, context: &ObservationContext)
        observing = true
    }
    
    func stopObservingHeight() {
        postWebView.scrollView.removeObserver(self, forKeyPath: "contentSize", context: &ObservationContext)
        observing = false
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        guard let keyPath = keyPath else {
            super.observeValueForKeyPath(nil, ofObject: object, change: change, context: context)
            return
        }
        switch (keyPath, context) {
        case("contentSize", &ObservationContext):
            postWebViewHeightConstraint.constant = postWebView.scrollView.contentSize.height
        default:
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        postWebViewHeightConstraint.constant = postWebView.scrollView.contentSize.height
        if (!observing) { startObservingHeight() }
        delay (0.1) {
            self.height = self.postWebView.scrollView.contentSize.height
        }
        
    }
    
    deinit {
        stopObservingHeight()
    } 
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
