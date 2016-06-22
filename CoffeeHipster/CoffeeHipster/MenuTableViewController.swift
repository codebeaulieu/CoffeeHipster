//
//  MenuTableViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 2/8/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import CoreData

class MenuTableViewController: UITableViewController, ManagedObjectContextSettable, SegueHandlerType {

    enum SegueIdentifier : String {
        case Home = "homeSegue"
        case Explore = "exploreSegue"
    }
    
    var moc: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkManagedObjectContext("Menu")
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let nc = segue.destinationViewController as? RootViewController,
            vc = nc.viewControllers.first as? ManagedObjectContextSettable
            else { fatalError("wrong vc type") }
        vc.moc = moc
        
        switch segueIdenfifierForSegue(segue) {
        case .Home:
            print("Home")
        case .Explore:
            print("Explore")
        }
    }
    
}


