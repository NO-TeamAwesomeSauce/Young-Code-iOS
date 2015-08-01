//
//  SecondViewController.swift
//  FoC-Hub
//
//  Created by Andreas Amundsen on 28/07/15.
//  Copyright © 2015 Andreas Amundsen. All rights reserved.
//

import UIKit

var title = "None"
var category = "None"


var titleList: [String] = []
var idList: [String] = []
var voteList: [String] = []
var colorList: [UIColor] = []

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var color: UIColor = UIColor.redColor()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(self)
        
    }
    
    @IBAction func goHome(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debug(titleList.count)
        return titleList.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = titleList[indexPath.row]
        cell.textLabel?.textColor = colorList[indexPath.row]
        cell.detailTextLabel?.text = ("Votes: \(voteList[indexPath.row])")
        
        //Change backgroundcolor of cell
        //cell.contentView.backgroundColor = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return categoryChosen.capitalizedString + "s"
    }
    
    @IBAction func fetchData(sender: AnyObject) {
        titleList = []
        voteList = []
        idList = []
        colorList = []
        
        let url = NSURL(string: "http://norbye.com/-other-/Festival%20of%20Code/API/index.php?limit=50&type="+categoryChosen)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {
            (data, response, error) in
            do {
                let jsonObject:NSArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
            
                debug(jsonObject)
                
                
                
                //Loops trough every item in jsonObject
                for i in 0..<jsonObject.count {
                    let title = jsonObject[i]["title"] as! String
                    let vote = jsonObject[i]["votes"] as! String
                    let id = jsonObject[i]["id"] as! String
                    
                    
                    //Controls the text color corresponding to the correct category
                    if jsonObject[i]["type"] as? String == "question" {
                        self.color = UIColor(red: 1, green: 0.4, blue: 0.4, alpha: 1)
                        
                    } else if jsonObject[i]["type"] as? String == "tutorial" {
                        self.color = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1)
                    
                    } else if jsonObject[i]["type"] as? String == "showcase" {
                        self.color = UIColor(red: 0.2, green: 0.4, blue: 1, alpha: 1)
                        
                    } else {
                        debug("Cant find category")
                        self.color = UIColor.redColor()
                    }
                    
                    
                    titleList.append(title)
                    voteList.append(vote)
                    idList.append(id)
                    colorList.append(self.color)
                }
                
                debug(titleList)
                self.tableView.reloadData()
                
                
                
            } catch {
               print(error)
            }
        })
        task?.resume()
        debug("Fetched data")
    }
    

    
    
    
    @IBAction func refreshCellView(sender: AnyObject) {
        fetchData(self)
        self.tableView.reloadData()
        debug("Fetched data")
    }
    
    //Called when a cell is pressed
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        debug(titleList[indexPath.row]) //CODE TO BE RUN ON CELL TOUCH
        
        //Changes color of text when cell is pressed
        //tableView.cellForRowAtIndexPath(indexPath)?.textLabel?.textColor = UIColor.greenColor()
        
        //Changes
        self.performSegueWithIdentifier("showDetails", sender: indexPath)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetails" {
            let indexPath:NSIndexPath = sender as! NSIndexPath
            let detailViewController:DetailViewController = segue.destinationViewController as! DetailViewController
            //detailViewController.detailTitle = titleList[indexPath.row]
            detailViewController.postID = idList[indexPath.row]
        }
    }
}
