//
//  TodayViewController.swift
//  Agenda
//
//  Created by Matthew Brightbill on 3/28/15.
//  Copyright (c) 2015 Matthew Brightbill. All rights reserved.
//

import UIKit
import CoreData

class TodayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var todayTableView: UITableView!
    
    var managedContext: NSManagedObjectContext!
    
    var tasks = [Task]()
    
    // MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.todayTableView.delegate = self
        self.todayTableView.dataSource = self
       
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.managedContext = appDelegate.managedObjectContext!
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addBarButtonPressed")
        self.navigationItem.rightBarButtonItem = addBarButton
        
        // Core Data
        var fetchRequest = NSFetchRequest(entityName: "Task")
        
        var error: NSError?
        var fetchResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let tasksFetched = fetchResults as? [Task] {
            self.tasks = tasksFetched
        } else {
            println("Fetching didn't work, here's the error: \(error?.localizedDescription)")
        }
    }
    
    // MARK: - UITableView methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TASK_CELL", forIndexPath: indexPath) as UITableViewCell
        let taskToDisplay = tasks[indexPath.row]
        cell.textLabel?.text = taskToDisplay.detail
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            managedContext.deleteObject(tasks[indexPath.row])
            
            var error: NSError?
            if !managedContext.save(&error) {
                println("Error occurred during save after delete: \(error?.localizedDescription)")
            }
            
            tasks.removeAtIndex(indexPath.row)
            
            todayTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            todayTableView.reloadData()
        }
        
    }
    
    // MARK: - Helper and selector methods
    
    func saveTask(taskToSave: String) {
        
        let taskEntity = NSEntityDescription.entityForName("Task", inManagedObjectContext: managedContext)
        
        let task = NSManagedObject(entity: taskEntity!, insertIntoManagedObjectContext: managedContext) as Task
        
        task.detail = taskToSave
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save the task -- some error occurred: \(error?.debugDescription)")
        }
        
        self.tasks.append(task)
    }
    
    func addBarButtonPressed() {
        
        let alert = UIAlertController(title: "Agenda", message: "What will you accomplish today?", preferredStyle: UIAlertControllerStyle.Alert)
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            println("addAction pressed!")
            
            let textField = alert.textFields![0] as UITextField
            self.saveTask(textField.text)
            self.todayTableView.reloadData()
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
