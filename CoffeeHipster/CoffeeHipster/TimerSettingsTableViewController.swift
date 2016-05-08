//
//  TimerSettingsTableViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/8/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit

class TimerSettingsTableViewController: UITableViewController {

    let userDefaults = NSUserDefaults.standardUserDefaults()
    var dataSource = [Section<String>]() {
        didSet {
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAeroPressOptions()
        

    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return dataSource.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource[section].items.count
    }
    
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCellWithIdentifier("settingsCell", forIndexPath: indexPath)
     cell.textLabel?.text = dataSource[indexPath.section].items[indexPath.row]
     // Configure the cell...
     
     return cell
     }
 
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataSource[section].header
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //guard let index = tableView.indexPathForSelectedRow else { return }
        guard let cell = tableView.cellForRowAtIndexPath(indexPath) else { return }
        
        print("cell : \(cell.textLabel?.text)")
        
        // give each cell a tag or identifier and switch on the identifier,
        // tapping row one toggles between AeroPress, French Press & Pour Over
        
        
    }
    
    
    func displayAeroPressOptions() {
        // user selects mode
        let modes = ["Aeropress", "French Press", "Pour Over"]
        let modesSection = Section("Mode", objects: modes)
        
        dataSource.append(modesSection)
        // aeropress settings
        
        // frenchpress settigns
        
        // pourover settings
        
        // global settings
        let settings = ["Cool Down Timer", "Cool Down Time"]
        let globalSection = Section("General", objects: settings)
        
        dataSource.append(globalSection)
    }

    func displayFrenchPressOptions() {
    }
    
    func displayPourOverOptions() {
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
