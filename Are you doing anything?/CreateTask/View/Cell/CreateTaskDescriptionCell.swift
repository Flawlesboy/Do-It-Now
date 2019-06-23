//
//  CreateTaskCell.swift
//  Are you doing anything?
//
//  Created by Загид Гусейнов on 06.03.2019.
//  Copyright © 2019 Загид Гусейнов. All rights reserved.
//

import UIKit

class CreateTaskDescriptionCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    
    weak var delegate: CreateTaskCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.textField.delegate = self
       
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        delegate?.didSet(text: text)
        
                
   }
    
}
