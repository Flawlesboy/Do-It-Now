//
//  ViewController.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 01.03.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import UIKit
import CoreData

class TaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TaskModelDelegate {
    
    var tasks: [Task] = []    
    var model = TaskModel()
    var task: Task!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setup(_ tasks: [Task]) {
        self.tasks = tasks
        self.tableView.reloadData()
    }
    
    func deleteDate() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.fetchRequest()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskCell
        
        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.title
        
        if let date = task.notificationDate {
            let dateForematter = DateFormatter()
            dateForematter.dateFormat = "EEEE, MMM d HH:mm"            
            
            cell.dateTimeLabel.text = dateForematter.string(from: date)
        } else {
            cell.dateTimeLabel.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.task = tasks[indexPath.row]
        performSegue(withIdentifier: "EditTaskSegue", sender: nil)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditTaskSegue" {
            let nc = segue.destination as! UINavigationController
            let editController = nc.topViewController as! EditTaskViewController
            editController.task = self.task
        }
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            
            
            let object = self.tasks[indexPath.row]
            self.model.deleteData(object: object)
            
            tableView.beginUpdates()
            self.tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            
        }
        return [delete]
    }
    
}


