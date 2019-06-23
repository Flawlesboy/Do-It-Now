//
//  EditTaskModel.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 05.05.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EditTaskModel {
    
    weak var delegate: CreateTaskModelDelegate?
    
    func saveEditTask(task: Task, createTask: CreateTask) {
        if createTask.title == nil || createTask.title?.isEmpty == true {
            delegate?.showError(error: "Введите задачу")
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        task.title = createTask.title
        task.notificationDate = createTask.notificationDate
        task.nameSound = createTask.sound?.name
        task.nameFileSound = createTask.sound?.fileName
        
        do {
            try context.save()
            delegate?.didSaveSuccessfully()
            print("Save! God Job!")
        } catch {
            print(error.localizedDescription)
        }
    }
}

