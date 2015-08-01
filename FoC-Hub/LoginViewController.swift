//
//  SecondViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit

var currentProfileID: String = "Noname"

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func submit(sender: AnyObject) {
        fetchData(self)
    }
    
    @IBAction func registrerRedirect(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://yc.norbyec.com")!)
    }
    
    @IBAction func fetchData(sender: AnyObject) {
    let url = NSURL(string: "http://norbye.com/-other-/Festival%20of%20Code/API/index.php?username=\(username.text!)&password=\(password.text!)")
    let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
        
        currentProfileID = (NSString(data: data!, encoding: NSUTF8StringEncoding) as? String)!
        
        if currentProfileID == "false" {
            //Login incorrect
            
            
        } else {
            //Login correct
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.performSegueWithIdentifier("showContent", sender: nil)
            })
        }
    }
        
    task?.resume()
}}


