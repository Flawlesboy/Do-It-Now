//
//  SaveDataModel.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 05.03.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol CreateTaskModelDelegate: class {
    func showError(error: String)
    func didSaveSuccessfully()
    
}

class CreateTaskModel {
    
    
    weak var delegate: CreateTaskModelDelegate?
    
    func saveTask(createTask: CreateTask) {
        if createTask.title == nil || createTask.title?.isEmpty == true {
            delegate?.showError(error: "Введите задачу")
            return
        }
        
        if createTask.notificationDate == nil {
            delegate?.showError(error: "Выберите время")
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context) as! Task
        
        object.createdAt = Date()
        object.notificationDate = createTask.notificationDate
        object.title = createTask.title
        object.nameSound = createTask.sound?.name
        object.nameFileSound = createTask.sound?.fileName
        object.updatedAt = Date()

        do {
            try context.save()
            delegate?.didSaveSuccessfully()
            print("Save! God Job!")
        } catch {
            print(error.localizedDescription)
        }
        
    }
}


