//
//  RootViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/10/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import CoreData

class RootViewController: UINavigationController, ManagedObjectContextSettable {

    var moc: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
