//
//  QuestionViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/23/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import CoreData
// this will serve as a question view; users may answer question from here

final class QuestionViewController: UIViewController, ManagedObjectContextSettable, SegueHandlerType, UIWebViewDelegate {
    
    var post : Post!
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionWebView: UIWebView!
    @IBOutlet weak var temporaryAnswerView: UITextView!
    @IBOutlet weak var voteCount: UILabel!
    enum SegueIdentifier : String {
        case none = ""
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionWebView.delegate = self
        checkManagedObjectContext("Question")
        titleLabel.text = post.title
        print(post.body!)
        /* load a web-view */
        
        
        let fixImage = post.body!.imageFix()
        questionWebView.loadHTMLString(fixImage, baseURL: nil)
       
        //questionTextView.attributedText = post.body?.attrStr()
        temporaryAnswerView.attributedText = post.answer?.first?.body.attrStr()
        voteCount.text = "\(post.currentVoteCount)"
        print("answerrr : \(post.answer?.first?.body)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
