//
//  TimerViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 4/23/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit

final class TimerViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRevealMenu()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
    }
    
    func setupRevealMenu() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.revealViewController().rearViewRevealWidth = 170
        }
    }
}
