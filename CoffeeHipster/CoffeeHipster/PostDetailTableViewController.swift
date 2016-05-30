//
//  PostDetailTableViewController.swift
//  CoffeeHipster
//
//  Created by Dan Beaulieu on 5/30/16.
//  Copyright © 2016 Dan Beaulieu. All rights reserved.
//

import UIKit
import CoreData

class PostDetailTableViewController: UITableViewController, ManagedObjectContextSettable, SegueHandlerType {
    enum SegueIdentifier : String {
        case UnwindPostDetail = "unwindPostDetail"
    }
    var context = 0
    weak var post: Post!
    
    @IBAction func handleBackButtonTapped(sender: UIBarButtonItem) {
        
    }
    
    var managedObjectContext: NSManagedObjectContext!
    var postData = [PostCellViewModel]()
    var contentHeights : [CGFloat] = [0.0, 0.0, 0.0]
    override func viewDidLoad() {
        super.viewDidLoad()
        checkManagedObjectContext("PostDetail")
        navigationItem.title = post.title
        createRowsFromObject()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.questionLoaded(_:)), name: "questionLoadedId", object: nil)
    }
    
    func createRowsFromObject() {
        // TODO: re-evaluate all of this crap
        
        // title
        let titleCell = PostCellViewModel(cellType: .Title,
                                          content: [
                                            "title":post.title,
                                            "count":"\(post.currentVoteCount)"])
        
        // body
        let bodyCell = PostCellViewModel(cellType: .Body,
                                         content: ["body":post.body!])
        
        // user
        let userCell = PostCellViewModel(cellType: .User,
                                         content: [
                                            "image":post.owner.image!,
                                            "name":post.owner.displayName,
                                            "rep":"\(post.owner.rep!)"])
        postData.append(titleCell)
        postData.append(bodyCell)
        postData.append(userCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postData.count
    } 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        switch postData[indexPath.row].cellType {
        case .Title :
            let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as! TitleTableViewCell
            cell.titleLabel.text = postData[indexPath.row].content["title"]
            cell.voteCount.text = postData[indexPath.row].content["count"]
            cell.removeMargins()
            return cell
        case .Body:
            print(indexPath.row)
            let htmlHeight = contentHeights[indexPath.row]
            guard let body = postData[indexPath.row].content["body"] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCellWithIdentifier("bodyCell", forIndexPath: indexPath) as! BodyTableViewCell
            cell.questionWebView.tag = indexPath.row
            cell.loadBody(body)
            cell.questionWebView.frame = CGRectMake(0, 0, cell.frame.size.width, htmlHeight)
            cell.removeMargins()
            return cell
        case .User:
            let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
            guard let image = postData[indexPath.row].content["image"],
                name = postData[indexPath.row].content["name"],
                rep = postData[indexPath.row].content["rep"] else { return UITableViewCell() }
            print("image : \(image)")
            print("name: \(name)")
            cell.userImageView.imageFromUrl(image)
            cell.userNameLabel.text = name
            cell.userRepLabel.text = rep
            cell.removeMargins()
            return cell
        default:
           // cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
            print("fuck off")
        }
        

        // Configure the cell...

        return UITableViewCell()
    }
 
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0 :
            return 70
        case 1 :
            return contentHeights[indexPath.row]
        case 2 :
            return 50
        default:
            return 50
            
        }
        
    }
    
    func questionLoaded(sender: NSNotification) {
        let userInfo : [String:CGFloat!] = sender.userInfo as! [String:CGFloat!]
        guard let height = userInfo["Height"] else { return }
        print("height : \(height)")
        // enum w raw value
        contentHeights[1] = height + 50
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
//        print(webView.request?.URL)
//        questionWebViewHeightConstraint.constant = questionWebView.scrollView.contentSize.height
//        
//        if (!observing) {
//            startObservingHeight()
//        }
        
        if (contentHeights[webView.tag] != 0.0)
        {
            // we already know height, no need to reload cell
            return
        }
        
        contentHeights[webView.tag] = webView.scrollView.contentSize.height
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: webView.tag, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let vc = segue.destinationViewController as? ManagedObjectContextSettable
            else { fatalError("Wrong View Controller Type") }
        vc.managedObjectContext = managedObjectContext
 
    }

}
