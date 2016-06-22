//
//  ExploreViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/11/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import CoreData

class ExploreViewController: UIViewController, ManagedObjectContextSettable, SegueHandlerType, Revealable {

    enum SegueIdentifier : String {
        case none = ""
    }
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBAction func handleTimerButtonTapped(sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ParentVC") as! TimerPageViewController
        vc.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(vc, animated: false, completion: nil)
    }
    
    var moc: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkManagedObjectContext("Explore")
        setupRevealMenu(self)
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
