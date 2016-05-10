//
//  TimerViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/9/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var modalTimerArea: UIView!
    @IBOutlet weak var timerDisplayLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton! 
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    
    var timer : NSTimer!
    var count : Int = 0 {
        didSet {
            timerDisplayLabel.text = "\(count)"
        }
    }
    
    @IBAction func handleStartButtonTapped(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(TimerViewController.iteration), userInfo: nil, repeats: true)
    }
    
    @IBAction func handleStopButtonTapped(sender: UIButton) {
        timer.invalidate()
        count = 0
        delay(3) {
            self.dismissModal()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        modalTimerArea.layer.cornerRadius = 5
        
        view.alpha = 0.0
        self.topLayoutConstraint.constant = 150
        self.performAnimations()
    
        
        
    }
    
    func performAnimations() {
    
        
       
        UIView.animateWithDuration(1.0) {
            self.view.alpha = 1.0
            self.view.layoutIfNeeded()
            
        }
        
       
    
    }
    
    func iteration() {
        count += 1
    }
    
    func dismissModal() {
        self.modalTransitionStyle = .CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
