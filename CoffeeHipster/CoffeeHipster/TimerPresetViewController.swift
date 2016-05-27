//
//  TimerPresetViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/9/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit

class TimerPresetViewController: UIViewController {

    @IBOutlet weak var modalPresetArea: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modalPresetArea.layer.cornerRadius = 5
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
