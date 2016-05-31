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
    private var MyObservationContext = 0
    private var observing = false
    var postBody : String!
    var position : Double!
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

//    func startObservingHeight() {
//        let options = NSKeyValueObservingOptions([.New])
//        questionWebView.scrollView.addObserver(self, forKeyPath: "contentSize", options: options, context: &MyObservationContext)
//        observing = true;
//    }
//    
//    func stopObservingHeight() {
//        questionWebView.scrollView.removeObserver(self, forKeyPath: "contentSize", context: &MyObservationContext)
//        observing = false
//    }
//    
//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        guard let keyPath = keyPath else {
//            super.observeValueForKeyPath(nil, ofObject: object, change: change, context: context)
//            return
//        }
//        switch (keyPath, context) {
//        case("contentSize", &MyObservationContext):
//            questionWebViewHeightConstraint.constant = questionWebView.scrollView.contentSize.height
//        default:
//            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
//        }
//    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
      
        postWebViewHeightConstraint.constant = postWebView.scrollView.contentSize.height
        
        
        var userInfo = [String:AnyObject]()
        userInfo["Height"] = postWebView.scrollView.contentSize.height
        userInfo["Position"] = self.position!
       
        dispatch_once(&token) {
            NSNotificationCenter.defaultCenter().postNotificationName("questionLoadedId", object: nil, userInfo: userInfo)
        }
    }
    
//    deinit {
//        stopObservingHeight()
//    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
