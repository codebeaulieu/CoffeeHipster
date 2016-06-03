//
//  CommentTableViewCell.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 6/2/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    var commentBody : String!
    private var ObservationContext = 0
    private var observing = false

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var commentHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func loadBody(body: String) {
        commentBody = body
        
        print("body : \(commentBody)")
        guard let body = commentBody else { return }
        let attrStr = try! NSAttributedString(
            data: body.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)

        commentTextView.attributedText = attrStr
        commentHeightConstraint.constant = commentTextView.contentSize.height
        height = commentHeightConstraint.constant
        //commentTextView.alpha = 0
        commentTextView.userInteractionEnabled = false
//        if score != nil {
//            self.votesLabel.text = score
//        }
        
    }
    var position : Double! {
        didSet {
            ObservationContext = Int(position * 10)
        }
    }
 
    private var _height : CGFloat = 0
    var height: CGFloat! {
        get {
            return _height
        }
        set {
            
            if _height != newValue {
                _height = newValue + 30
                var userInfo = [String:AnyObject]()
                userInfo["Height"] = self.height
                userInfo["Position"] = self.position! //TODO: guard
                
                NSNotificationCenter.defaultCenter().postNotificationName("questionLoadedId", object: nil, userInfo: userInfo)
                
            }  
        }
    }
}
