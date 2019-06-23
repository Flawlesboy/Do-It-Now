//
//  CreateTaskViewController.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 05.03.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import UIKit

class CreateTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateTaskCellDelegate, CreateTaskModelDelegate, NotificationDelegate, SoundDelegate   {
    
    
  
   
    var model = CreateTaskModel()
    var createTask: CreateTask = CreateTask()
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        model.saveTask(createTask: createTask)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func showError(error: String) {
        let ac = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
        
    }
    
    func didSaveSuccessfully() {
        self.appDelegate?.scheduleNotification(createTask: createTask)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    func didPick(sound: Sound?) {
        createTask.sound = sound
        tableView.reloadData()
    }
    
    
    
    func didPick(date: Date) {
        createTask.notificationDate = date
        tableView.reloadData()
        
    }
    
    func didSet(text: String) {
        createTask.title = text
        print(text)
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CreateTaskDescriptionCell
            
            cell.delegate = self
            
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! CreateTaskNotificationsViewCell
            
            if let date = createTask.notificationDate {
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "MM-dd-yyyy HH:mm"
                
                cell.dateTimeLabel.text = dateFormater.string(from: date)
            } else {
                cell.dateTimeLabel.text = "Выкл"
            }
        
            
            
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "soundsCell", for: indexPath) as! CreateTaskSoundCell
            
            if let data = createTask.sound?.name {
                print("Зага\(data)")
                cell.melodyLabel.text = data
                cell.melodyLabel.isHidden = false
            } else {
                cell.melodyLabel.isHidden = true
            }
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {            
            performSegue(withIdentifier: "notificationSegue", sender: nil)
        }
        
        if indexPath.row == 2 {
            performSegue(withIdentifier: "soundsSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "notificationSegue" {
            let secondVC = segue.destination as! NotificationsController
            secondVC.delegate = self
        }
        
        if segue.identifier == "soundsSegue" {
            let nc = segue.destination as! UINavigationController
            let secondVC = nc.topViewController as! SoundViewController
            secondVC.delegate = self            
        }
    }
    
    
}


