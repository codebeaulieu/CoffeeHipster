//
//  HomeTableViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 2/8/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class HomeTableViewController: UITableViewController, ManagedObjectContextSettable, Revealable, SegueHandlerType {
    
    enum SegueIdentifier :  String {
        case Detail = "questionDetailSegue"
    }
    
    var moc: NSManagedObjectContext!
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBAction func handleTimerButtonTapped(sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ParentVC") as! TimerPageViewController
        vc.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(vc, animated: false, completion: nil)
    }
    
    @IBAction func unwindPostDetail(segue: UIStoryboardSegue) {
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkManagedObjectContext("Home")
        Connect.handle(api: .Post, request: .Get, moc: managedObjectContext)
        setupRevealMenu(self)
        setupTableView()
        
    } 
     
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let vc = segue.destinationViewController as? ManagedObjectContextSettable
            else { fatalError("Wrong View Controller Type") }
        vc.moc = moc
        
        switch segueIdenfifierForSegue(segue) {
        case .Detail:
            guard let view = segue.destinationViewController as? PostDetailTableViewController
                else { fatalError("wrong vc type") }
            view.moc = moc
            view.post = dataSource.selectedObject
        }
    }
    
    // MARK: Private
    
    private typealias Data = FetchedResultsDataProvider<HomeTableViewController>
    private var dataSource: TableViewDataSource<HomeTableViewController, Data, PostTableViewCell>!
    //private var observer: ManagedObjectObserver?
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 80
        let request = NSFetchRequest(entityName: Post.entityName)
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 100
        request.sortDescriptors = Post.defaultSortDescriptors
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
        let dataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
    } 
}


extension HomeTableViewController: DataProviderDelegate {
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Post>]?) {
        dataSource.processUpdates(updates)
    }
}

extension HomeTableViewController: DataSourceDelegate {
    func cellIdentifierForObject(object: Post) -> String {
        return "postCell"
    }
}

extension HomeTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("questionDetailSegue", sender: self)
        
    }
}
