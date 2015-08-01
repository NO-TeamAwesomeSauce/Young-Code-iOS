//
//  ViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit

var jsonObject: NSArray = []

class DetailViewController: UIViewController {
    
    var postID = ""
    var hasVoted: Bool = false
    var numVotes: Int = 0
    var color: UIColor = UIColor.redColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(self)
    }
    
    @IBOutlet weak var titleDetailView: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var textviewDetailView: UITextView!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var numberOfVotes: UILabel!
    
    
    
    @IBAction func refreshDetailView(sender: AnyObject) {
        fetchData(self)
        debug("Fetched data")
    }
    
    @IBAction func goHome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
   
    @IBAction func votePost(sender: AnyObject) {
        
            let url = NSURL(string: "http://norbye.com/-other-/Festival%20of%20Code/API/index.php?votepost=\(postID)&user=\(currentProfileID)")
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                
                let success = NSString(data: data!, encoding: NSUTF8StringEncoding)
                debug(success!)
                
                }
        
            task?.resume()
        self.hasVoted = !self.hasVoted
        if self.hasVoted {
            self.numVotes = self.numVotes + 1
        } else {
            self.numVotes = self.numVotes - 1
        }
        updateVoteButton()
    }
    
    @IBAction func commentRedirect(sender: AnyObject) {
        //Redirect to comment view
        
        self.performSegueWithIdentifier("showComment", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showComment" {
            
            let commentViewController:CommentViewController = segue.destinationViewController as! CommentViewController
            commentViewController.postID = self.postID
        }
    }
 
    @IBOutlet weak var vote: UIButton!
    
    //Asks for ID in URL
    @IBAction func fetchData(sender: AnyObject) {
        let url = NSURL(string: "http://norbye.com/-other-/Festival%20of%20Code/API/index.php?id=\(postID)&user=\(currentProfileID)")
        debug(postID)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data, response, error) in
            do {
                 jsonObject = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                
                debug(jsonObject.count)
                debug(jsonObject)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    
                    //Display information from JSON to outlets in DetailedViewController
                    self.titleDetailView.text = jsonObject[0]["title"] as? String
                    
                    if jsonObject[0]["type"] as? String == "question" {
                        self.color = UIColor(red: 1, green: 0.9, blue: 0.9, alpha: 1)
                    } else if jsonObject[0]["type"] as? String == "tutorial" {
                        self.color = UIColor(red: 0.9, green: 1, blue: 0.9, alpha: 1)
                        
                    } else if jsonObject[0]["type"] as? String == "showcase" {
                        self.color = UIColor(red: 1, green: 1, blue: 0.9, alpha: 1)
                        
                    } else {
                        
                        self.color = UIColor.redColor()
                    }
                    
                    self.titleDetailView.backgroundColor = self.color
                    
                    
                    
                    self.textviewDetailView.text = jsonObject[0]["desc"] as? String
                    self.numberOfComments.text = jsonObject[0]["antcom"] as? String
                    self.authorLabel.text = jsonObject[0]["user"] as? String
                    self.timeStamp.text = jsonObject[0]["timestamp"] as? String
                    self.hasVoted = jsonObject[0]["hasvoted"] as? String == "true"
                    self.numVotes = Int(jsonObject[0]["votes"] as! String)!
        
                    self.updateVoteButton()
                    
                })
                
            } catch {
               print(error)
            }
        })
        task?.resume()
    }

    func updateVoteButton() {
        let image: UIImage
        if self.hasVoted {
            image = UIImage(named: "UpVoteGreen.png") as UIImage!
        } else {
            image = UIImage(named: "UpVote.png") as UIImage!
        }
        self.vote.setImage(image, forState: .Normal)
        self.numberOfVotes.text = String(self.numVotes)
    }
}
