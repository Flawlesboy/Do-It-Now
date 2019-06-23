//
//  EditTaskViewController.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 26.04.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CreateTaskCellDelegate, NotificationDelegate, SoundDelegate, CreateTaskModelDelegate {
    
    var task: Task!
    var createTask = CreateTask()
    var model = EditTaskModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButton(_ sender: Any) {
        model.saveEditTask(task: task, createTask: createTask)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        
        createTask.title = task.title
        createTask.notificationDate = task.notificationDate
        createTask.sound = Sound(name: task.nameSound, fileName: task.nameFileSound)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func showError(error: String) {
        let ac = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
}
    
    func didSaveSuccessfully() {
        dismiss(animated: true, completion: nil)
    }
    
    func didSet(text: String) {
        createTask.title = text
        print(text)
        tableView.reloadData()
    }
    
    func didPick(date: Date) {
        createTask.notificationDate = date
        tableView.reloadData()
    }
    
    func didPick(sound: Sound?) {
        createTask.sound = sound
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editTextCell", for: indexPath) as! EditTaskDescriptionCell
            
            cell.textField.text = createTask.title
            cell.delegate = self
            
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editNotificationCell", for: indexPath) as! EditTaskNotificationsCell
            
            if let date = createTask.notificationDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
                
                cell.dateTimeLabel.text = dateFormatter.string(from: date)
            } else {
                cell.dateTimeLabel.text = "Выкл"
            }
            
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editSoundsCell", for: indexPath) as! EditTaskSoundCell
            
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editNotificationSegue" {
            let secondVC = segue.destination as! NotificationsController
            secondVC.delegate = self
            
        }
        
        if segue.identifier == "editSoundSegue" {
            let nc = segue.destination as! UINavigationController
            let secondVC = nc.topViewController as! SoundViewController
            secondVC.delegate = self
            
        }
    }
    

}
