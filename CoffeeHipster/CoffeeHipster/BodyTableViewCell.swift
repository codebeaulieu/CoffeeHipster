//
//  BodyTableViewCell.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

// TODO: again, hacky.
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

class BodyTableViewCell: UITableViewCell, UIWebViewDelegate {

    @IBOutlet weak var postWebViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var postWebView: UIWebView!
    @IBOutlet weak var votesLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    private var ObservationContext = 0
    private var observing = false
    var postBody : String!
    var score : String!
    
    var position : Double! {
        didSet {
            ObservationContext = Int(position * 10) 
        }
    }
    // TODO : This is all hacky
    private var _height : CGFloat = 0
    var height: CGFloat! {
        get {
            return _height
        }
        set {

            if _height != newValue && newValue > (_height - 50) {
                
                _height = newValue
                var userInfo = [String:AnyObject]()
                userInfo["Height"] = self.height
                userInfo["Position"] = self.position! //TODO: guard
           
                NSNotificationCenter.defaultCenter().postNotificationName("questionLoadedId", object: nil, userInfo: userInfo)
              
            } else {
                
                stopObservingHeight()
            }
        }
    }
    
    
    private var _setOnce : String?
    
    func loadBody(body: String) {
        postBody = body
        
        //print("body : \(postBody)")
        guard let body = postBody else { return }
        let fixImage = body.imageFix()
        postWebView.alpha = 0
        postWebView.loadHTMLString(fixImage, baseURL: nil)
        postWebView.scrollView.scrollEnabled = false
        postWebView.userInteractionEnabled = false
        postWebView.delegate = self
        if score != nil {
            self.votesLabel.text = score
        }
        
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
        delay (0.3) {
            self.height = self.postWebView.scrollView.contentSize.height
            UIView.animateWithDuration(0.5) {
                self.postWebView.alpha = 1
            }
        }
        
    }
    
    deinit {
        if observing { stopObservingHeight() }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
