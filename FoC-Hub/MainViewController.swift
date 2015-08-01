//
//  ViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //Redirects to the category selection View Controller
    @IBAction func browsePosts(sender: AnyObject) {
        
    }
    
    //Redirects to map on yc.norbye.com
    //TODO: Implement native map support in app
    @IBAction func mapRedirect(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yc.norbye.com/includes/social.php")!)
        
    }
    
    
    //Redirects the user to a yc.norbye.com
    @IBAction func redirectToWebpage(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yc.norbye.com/")!)
    }
    
    

}

