//
//  SecondViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit

var comments: [String] = []
var commentAuthor: [String] = []

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var postID = ""
    
    
    @IBAction func goHome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(self)
    }
    
  
    @IBAction func refreshComments(sender: AnyObject) {
        fetchData(self)
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = comments[indexPath.row]
        cell.detailTextLabel?.text = commentAuthor[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Comments"
    }
    
    
    @IBAction func fetchData(sender: AnyObject) {
        comments = []
        commentAuthor = []
        
        let url = NSURL(string: "http://norbye.com/-other-/Festival%20of%20Code/API/index.php?comments=\(postID)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data, response, error) in
            do {
                let jsonObject:NSArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                
            
                debug(jsonObject.count)
                debug(jsonObject)
                debug(titleList)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    //Loops trough every item in jsonObject and saves title of each item in titleList
                    for i in 0..<jsonObject.count {
                        let comment = jsonObject[i]["text"] as! String
                        let author = jsonObject[i]["username"] as! String
                    
                        comments.append(comment)
                        commentAuthor.append(author)

                        }
                    
                        debug(comments)
                        debug(commentAuthor)
                
                    
                })
                
                self.tableView.reloadData()
                debug(self.tableView)
                //self.tableView.reloadData()
                
                
            } catch {
               print(error)
            }
            
            
        })
        task?.resume()
        debug("Fetched data")
    
    }
    
    
    
}

