//
//  extension+UIViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/10/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import Foundation

extension UITableViewController {
    func setupRevealMenu<T : UITableViewController where T : Revealable>(controller : T) {
        if self.revealViewController() != nil {
            controller.menuButton.target = self.revealViewController()
            controller.menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(controller.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 200
        }
    }
}