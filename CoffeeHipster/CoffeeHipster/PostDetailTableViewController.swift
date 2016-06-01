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
    
    var sectionData = [Section<PostCellViewModel>]()
    var contentHeights = [Double : CGFloat]()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkManagedObjectContext("PostDetail")
        navigationItem.title = post.title
        createRowsFromObject()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.questionLoaded(_:)), name: "questionLoadedId", object: nil)
    }
    
    func createRowsFromObject() {
        // TODO: re-evaluate all of this crap
        var postData = [PostCellViewModel]()
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
        
        sectionData.append(Section("question", objects: postData))
        // answers
        var answerArray = [PostCellViewModel]()
        for answer in post.answer! {
            let answerBody = PostCellViewModel(cellType: .Body, content: ["body": answer.body])
            answerArray.append(answerBody)
            
        }
        sectionData.append(Section("Answers", objects: answerArray))
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionData.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sectionData[section].items.count
    } 
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
 
        let current = sectionData[indexPath.section].items[indexPath.row]
        let position = indexPath.section.createDecimal(indexPath.row)
        
        print("tuple : \(position)")
        switch position {
        case 0.0 :
            let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as! TitleTableViewCell
            cell.titleLabel.text = current.content["title"]
            cell.voteCount.text = current.content["count"]
            cell.removeMargins()
            return cell
        case 0.1:
           
            let htmlHeight = contentHeights[position] ?? 0.0
            guard let body = current.content["body"] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCellWithIdentifier("bodyCell", forIndexPath: indexPath) as! BodyTableViewCell
            cell.postWebView.position = position
            cell.loadBody(body)
            cell.position = position
            cell.postWebView.frame = CGRectMake(0, 0, cell.frame.size.width, htmlHeight)
            cell.removeMargins()
            return cell
        case 0.2:
            let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as! UserTableViewCell
            
            guard let image = current.content["image"],
                name = current.content["name"],
                rep = current.content["rep"] else { return UITableViewCell() }
            print("image : \(image)")
            print("name: \(name)")
            cell.userImageView.imageFromUrl(image)
            cell.userNameLabel.text = name
            cell.userRepLabel.text = rep
            cell.removeMargins()
            return cell
        case 1.0...1.createDecimal(sectionData[1].items.count):
          
            let htmlHeight = contentHeights[position] ?? 0.0
            guard let body = current.content["body"] else { return UITableViewCell() }
            let cell = tableView.dequeueReusableCellWithIdentifier("bodyCell", forIndexPath: indexPath) as! BodyTableViewCell
            cell.postWebView.position = position
            cell.position = position
            cell.loadBody(body)
            cell.postWebView.frame = CGRectMake(0, 0, cell.frame.size.width, htmlHeight)
            cell.removeMargins()
            return cell


        default:
            assertionFailure("cell for row at index patch should never hit default switch")
        }
        

        // Configure the cell...

        return UITableViewCell()
    }
 
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let position = indexPath.section.createDecimal(indexPath.row)
        
        
        switch indexPath.row {
        case 0 :
            return 70
        case 1 :
            guard let height = contentHeights[position] else { return 0 }
            return height
        case 2 :
            return 50
        default:
            return 50
            
        }
        
    }
    
    func questionLoaded(sender: NSNotification) {
        print("loads")
        let userInfo : [String:AnyObject!] = sender.userInfo as! [String:AnyObject!]
        guard let height = userInfo["Height"] as? CGFloat else { return }
        guard let position = userInfo["Position"] as? Double else { return }
        print("height: \(height)")
        print("position: \(position)")
        
        if contentHeights[position] != height {
            contentHeights[position] = height
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: position.getRow(), inSection: 0)], withRowAnimation: .Automatic)
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: 1, inSection: 0)], withRowAnimation: .Automatic)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        if (contentHeights[webView.position] != 0.0) {
            return
        }
        
        contentHeights[webView.position] = webView.scrollView.contentSize.height
        tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: webView.position.getRow(), inSection: webView.position.getSection())], withRowAnimation: .Automatic)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let vc = segue.destinationViewController as? ManagedObjectContextSettable
            else { fatalError("Wrong View Controller Type") }
        vc.managedObjectContext = managedObjectContext
 
    }

}


