//
//  SecondViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit

var categoryChosen = "Default"

class CategoryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func goHome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func browseAllButton(sender: AnyObject) {
        categoryChosen = "Post"
    }
    
    @IBAction func tutorialButton(sender: AnyObject) {
        categoryChosen = "tutorial"
    }
    
    @IBAction func showcaseButton(sender: AnyObject) {
        categoryChosen = "showcase"
    }
    
    @IBAction func questionButton(sender: AnyObject) {
        categoryChosen = "question"
    }
}