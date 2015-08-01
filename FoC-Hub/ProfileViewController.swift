//
//  SecondViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var rankImage: UIImage = UIImage()
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var profileRank: UILabel!
    @IBOutlet weak var joinedAgo: UILabel!
    @IBOutlet weak var rankImg: UIImageView!
    @IBOutlet weak var numberOfPosts: UILabel!
    @IBOutlet weak var numberOfVotes: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.numberOfPosts.layer.cornerRadius = 6.0
        //self.numberOfPosts.layer.backgroundColor = UIColor.redColor()
        fetchData(self)
    }
    
    @IBAction func goHome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func refreshProfile(sender: AnyObject) {
        fetchData(self)
    }
    
    @IBAction func fetchData(sender: AnyObject) {
        let url = NSURL(string: "http://norbye.com/-other-/Festival%20of%20Code/API/index.php?profile=\(currentProfileID)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data, response, error) in
            do {
                let jsonObject:NSArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                
                debug(jsonObject)
                
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.username.text = jsonObject[0]["username"] as? String
                    self.joinedAgo.text = "Joined " + String(jsonObject[0]["timestamp"] as! String)
                    self.numberOfPosts.text = jsonObject[0]["posts"] as? String
                    self.numberOfVotes.text = jsonObject[0]["votes"] as? String
                    self.numberOfComments.text = jsonObject[0]["comments"] as? String
                    
                    if jsonObject[0]["rank"] as? String == "bronze baby" {
                        self.rankImage = UIImage(named: "bronze.png") as UIImage!
                    } else if jsonObject[0]["rank"] as? String == "silver scrub" {
                        self.rankImage = UIImage(named: "Silver.png") as UIImage!
                    } else if jsonObject[0]["rank"] as? String == "gold geek" {
                        self.rankImage = UIImage(named: "Gold.png") as UIImage!
                    } else if jsonObject[0]["rank"] as? String == "platinum prodigy" {
                        self.rankImage = UIImage(named: "Platinum.png") as UIImage!
                    } else if jsonObject[0]["rank"] as? String == "diamond darling" {
                        self.rankImage = UIImage(named: "Diamond.png") as UIImage!
                    } else {
                        debug("Rank not defined")
                    }
                    
                    self.rankImg.image = self.rankImage
                })
                
            } catch {
               print(error)
            }
        })
        task?.resume()
    }
}