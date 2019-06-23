//
//  NotificationsController.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 28.03.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import UIKit

class NotificationsController: UIViewController {
    
    weak var delegate: NotificationDelegate!
    
    var dismiss: Bool = true
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    
    @IBAction func saveAction(_ sender: Any) {
        delegate.didPick(date: datePicker.date)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        
        timeLabel.text = "\(dateFormatter.string(from: currentDateTime))"
        datePicker.minimumDate = Date()
    }
    
    override func viewDidLayoutSubviews() {
        let bounds: CGRect = timeLabel.bounds
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .bottomLeft]), cornerRadii: CGSize(width: 25.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        timeLabel.layer.mask = maskLayer
        
        saveButton.layer.cornerRadius = saveButton.frame.size.height / 2
        saveButton.layer.masksToBounds = true
        let saveBorderColor = UIColor.gray
        saveButton.layer.borderColor = saveBorderColor.cgColor
        saveButton.layer.borderWidth = 1
        
        cancelButton.layer.cornerRadius = cancelButton.frame.size.height / 2
        cancelButton.layer.masksToBounds = true
        let cancelBorderColor = UIColor.gray
        cancelButton.layer.borderColor = cancelBorderColor.cgColor
        cancelButton.layer.borderWidth = 0.5
       
    }
}
