//
//  TaskModel.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 12.03.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol TaskModelDelegate: class {
    func setup(_ tasks: [Task])
    func deleteDate()
}

class TaskModel {
    
    weak var delegate: TaskModelDelegate?
    
    
    func fetchRequest() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let sort = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do {
            let result = try context.fetch(fetchRequest) as! [Task]
            
            print(result)
            delegate?.setup(result)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(object: Task) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        context.perform {
            
            do {
                context.delete(object)
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
                
            }
        }
    }
}




    


    
    


