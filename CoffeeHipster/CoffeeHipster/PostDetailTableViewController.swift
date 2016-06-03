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
        
        // TODO: protocol - delegate pattern would be better
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.questionLoaded(_:)), name: "questionLoadedId", object: nil)
    }
    
    // TODO: not proud of this, but wanted to move forward. I'll re-evaluate this in time
    func createRowsFromObject() {
        
        // TODO: since this is all going to change I'm just slapping this together.
        var postData = [PostCellViewModel]()
        // title
        let titleCell = PostCellViewModel(cellType: .Title, content: [ "title":post.title, "count":"\(post.currentVoteCount)"])
        // body
        let bodyCell = PostCellViewModel(cellType: .Question(.Body), content: ["body":post.body!])
        let userCell = PostCellViewModel(cellType: .Question(.Author), content: [ "image":post.owner.image!, "name":post.owner.displayName, "rep":"\(post.owner.rep!)"])
        
        postData.append(titleCell)
        postData.append(bodyCell)
        postData.append(userCell)
        
        let postComments = post.comments!.sort { $0.0.creation_date.isLessThanDate($0.1.creation_date) }
        for comment in postComments {
            let commentCell = PostCellViewModel(cellType: .Question(.Comment), content: [ "date":comment.creation_date, "body":comment.body, "name":"\(comment.owner.displayName)"])
            postData.append(commentCell)
        }
        /*******************************************************************/
        // selected
        sectionData.append(Section("question", objects: postData))
        // other answers
        let isAccepted = post.answer!.filter { $0.is_accepted == true}.first
        // TODO: overload the greater than operator to handle NSNumbers
        let allAnswers = post.answer!.sort { Int($0.0.score) > Int($0.1.score) }
        
        if let accepted = isAccepted {
            var selectedSection = [PostCellViewModel]()
            let selected = PostCellViewModel(cellType: .Answer(.Body), content: [ "body": accepted.body, "score": "\(accepted.score)", "accepted": accepted.is_accepted])
            selectedSection.append(selected)
            
            let acceptedAuthor = PostCellViewModel(cellType: .Answer(.Author), content: [ "image":post.owner.image!, "name":accepted.owner.displayName, "rep":"\(accepted.owner.rep!)"])
            selectedSection.append(acceptedAuthor)
            
            let acceptedComments = accepted.comments!.sort { $0.0.creation_date.isLessThanDate($0.1.creation_date) }
            for comment in acceptedComments {
                let commentCell = PostCellViewModel(cellType: .Answer(.Comment), content: [ "date":comment.creation_date, "body":comment.body, "name":"\(comment.owner.displayName)"])
                selectedSection.append(commentCell)
            }
            
            sectionData.append(Section("Answers", objects: selectedSection))
        } 
        /*******************************************************************/
        // other answers

        for answer in allAnswers where answer.is_accepted == false {
            var answerSection = [PostCellViewModel]()
            let ans = PostCellViewModel(cellType: .Answer(.Body), content: [ "body": answer.body, "score": "\(answer.score)", "accepted": answer.is_accepted])
            answerSection.append(ans)
            
            let answerAuthor = PostCellViewModel(cellType: .Answer(.Author), content: [ "image":answer.owner.image!, "name":answer.owner.displayName, "rep":"\(answer.owner.rep!)"])
            answerSection.append(answerAuthor)
            
            let answerComments = answer.comments!.sort { $0.0.creation_date.isLessThanDate($0.1.creation_date) }
            
            for comment in answerComments {
                let commentCell = PostCellViewModel(cellType: .Answer(.Comment), content: [ "date":comment.creation_date, "body":comment.body, "name":"\(comment.owner.displayName)"])
                answerSection.append(commentCell)
            }
            
            sectionData.append(Section("Answers", objects: answerSection))
        }
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
       
        print(current.content)
 
        print("items :  \(sectionData[indexPath.section].items.count)")
        print("indexPath :  \(indexPath.row)")
        
        
            let position = indexPath.section.createDecimal(indexPath.row)

            switch current.cellType {
            case .Title:
                guard let cell = tableView.dequeueReusableCellWithIdentifier("titleCell", forIndexPath: indexPath) as? TitleTableViewCell
                else { fatalError("failed to dequeue cell") }
                cell.titleLabel.text = current.content["title"] as? String
                cell.voteCount.text = current.content["count"] as? String
                cell.removeMargins()
                return cell
            case .Question(let sort):
                if case .Body = sort {
                    let htmlHeight = contentHeights[position] ?? 100.0
                    guard let body = current.content["body"] as? String else { return UITableViewCell() }
                    
                    guard let cell = tableView.dequeueReusableCellWithIdentifier("bodyCell", forIndexPath: indexPath) as? BodyTableViewCell
                    else { fatalError("failed to dequeue cell") }
                    
                    cell.postWebView.position = position
                    cell.loadBody(body)
                    cell.position = position
                    cell.postWebView.frame = CGRectMake(0, 0, cell.frame.size.width, htmlHeight)
                    cell.removeMargins()
                    return cell ?? UITableViewCell()
                } else if case .Comment = sort {
                    // comment
                    guard let body = current.content["body"] as? String,
                        date = current.content["date"] as? NSDate,
                        name = current.content["name"] as? String
                    else { fatalError("failed to unwrap body") }
                    
                    guard let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as? CommentTableViewCell
                    else { fatalError("failed to dequeue cell") }
                    
                    cell.position = position
                    cell.loadBody(body)
                    cell.userNameLabel.text = name ?? "broke"
                    cell.createdOnLabel.text = "\(date.readable())"
                    cell.removeMargins()
                    
                    return cell
                } else if case .Author = sort {
                    
                    guard let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as? UserTableViewCell
                    else { fatalError("failed to dequeue cell") }
                    
                    guard let image = current.content["image"] as? String,
                        name = current.content["name"] as? String,
                        rep = current.content["rep"] as? String else { return UITableViewCell() }
                    
                    cell.userImageView.imageFromUrl(image)
                    cell.userNameLabel.text = name
                    cell.userRepLabel.text = rep
                    cell.removeMargins()
                    return cell
                }
            case .Answer(let sort): 
                if case .Body = sort {
                    let htmlHeight = contentHeights[position] ?? 100.0
                    guard let body = current.content["body"] as? String,
                        score = current.content["score"] as? String,
                        accepted = current.content["accepted"] as? Bool
                        else { return UITableViewCell() }
                    
                    guard let cell = tableView.dequeueReusableCellWithIdentifier("answerCell", forIndexPath: indexPath) as? BodyTableViewCell
                    else { fatalError("failed to dequeue cell") }
                    
                    cell.postWebView.position = position
                    cell.position = position
                    cell.loadBody(body)
                    cell.votesLabel.text = score
                    cell.checkMarkImageView.hidden = !accepted ?? true
                    cell.postWebView.frame = CGRectMake(0, 0, cell.frame.size.width, htmlHeight)
                    cell.removeMargins()
                    return cell

                } else if case .Comment = sort {

                    guard let body = current.content["body"] as? String,
                        date = current.content["date"] as? NSDate,
                        name = current.content["name"] as? String
                    else { fatalError("failed to unwrap body") }
                    
                    guard let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as? CommentTableViewCell
                    else { fatalError("failed to dequeue cell") }
                
                    cell.position = position
                    cell.loadBody(body)
                    cell.userNameLabel.text = name ?? "broke"
                    cell.createdOnLabel.text = "\(date.readable())"
                    cell.removeMargins()
                    
                    return cell

                } else if case .Author = sort {
                    print("author position: \(position)")
                    
                    guard let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) as? UserTableViewCell
                    else { fatalError("failed to dequeue cell") }
                    
                    guard let image = current.content["image"] as? String,
                        name = current.content["name"] as? String,
                        rep = current.content["rep"] as? String
                    else { return UITableViewCell() }
                    
                    cell.userImageView.imageFromUrl(image)
                    cell.userNameLabel.text = name
                    cell.userRepLabel.text = rep
                    cell.removeMargins()
                    
                    return cell
                }
            }
          //assertionFailure("Should never reach this point")
        return UITableViewCell()
    }
 
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //TODO: this is causing display issues
        let position = indexPath.section.createDecimal(indexPath.row)
 
        switch position {
        case 0 :
            return 70
        case 0.1 :
            guard let height = contentHeights[position] else { return 0 }
            return height
        case let x where x >= 0.3 && x < 1.0:
            guard let height = contentHeights[position] else { return 50 }
            return height
        case let x where x >= 1.0:
            guard let height = contentHeights[position] else { return 50 }
            return height
        default:
            return 50
        }
    }
    
    func questionLoaded(sender: NSNotification) {
      
        let userInfo : [String:AnyObject!] = sender.userInfo as! [String:AnyObject!]
        guard let height = userInfo["Height"] as? CGFloat else { return }
        guard let position = userInfo["Position"] as? Double else { return }
    
        
        if contentHeights[position] != height {
            contentHeights[position] = height
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: position.getRow(), inSection: position.getSection())], withRowAnimation: .Automatic) 
        }
    }
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "questionLoadedId", object: nil)
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


