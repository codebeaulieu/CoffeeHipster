//
//  RevealViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/10/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import CoreData

class RevealViewController: SWRevealViewController, ManagedObjectContextSettable, SegueHandlerType {
    
    enum SegueIdentifier : String {
        case SW_Rear = "sw_rear"
        case SW_Front = "sw_front"
    }
    
    var managedObjectContext: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkManagedObjectContext("Reveal")
    }

 
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdenfifierForSegue(segue) {
        case .SW_Rear:
            guard let vc = segue.destinationViewController as? ManagedObjectContextSettable
            else { fatalError("wrong vc type") }
            vc.managedObjectContext = managedObjectContext
        case .SW_Front:

            guard let nc = segue.destinationViewController as? RootViewController,
            vc = nc.viewControllers.first as? ManagedObjectContextSettable
                else { fatalError("wrong vc type") }
            vc.managedObjectContext = managedObjectContext
        }
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
