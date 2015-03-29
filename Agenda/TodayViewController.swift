//
//  TodayViewController.swift
//  Agenda
//
//  Created by Matthew Brightbill on 3/28/15.
//  Copyright (c) 2015 Matthew Brightbill. All rights reserved.
//

import UIKit

class TodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var todayTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todayTableView.delegate = self
        self.todayTableView.dataSource = self

        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed")
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    // MARK: - UITableView delegate methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TASK_CELL", forIndexPath: indexPath) as UITableViewCell
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // MARK: - Helper and selector methods
    
    func saveTask(task: String) {
        
        
        
    }
    
    func addButtonPressed() {
        println("Compose button pressed")
        
        let alert = UIAlertController(title: "Agenda", message: "What will you accomplish today?", preferredStyle: UIAlertControllerStyle.Alert)
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            println("addAction pressed!")
            
            let textField = alert.textFields![0] as UITextField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
        }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK: - Memory warning method

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
