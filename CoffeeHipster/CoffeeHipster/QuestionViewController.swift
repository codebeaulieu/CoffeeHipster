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

final class QuestionViewController: UIViewController, ManagedObjectContextSettable, SegueHandlerType {
    
    var post : Post!
   
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var temporaryAnswerView: UITextView!
    enum SegueIdentifier : String {
        case none = ""
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkManagedObjectContext("Question")
        titleLabel.text = post.title
        questionTextView.attributedText = post.body?.attrStr()
        temporaryAnswerView.attributedText = post.answer?.first?.body.attrStr()
        print("answerrr : \(post.answer?.first?.body)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
