//
//  NotificationProrocol.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 04.04.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import Foundation

protocol NotificationDelegate: class {
    func didPick(date: Date)
}

