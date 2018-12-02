//
//  TextFieldCell.swift
//  CodyRela
//
//  Created by Neil Jain on 12/1/18.
//  Copyright © 2018 Neil Jain. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    weak var value: TextValue?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        observeTextChange()
    }
    
    func observeTextChange() {
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: .main) { (notification) in
            guard let textField = notification.object as? UITextField else { return }
            guard textField === self.textField else { return }
            self.value?.value = textField.text
        }
    }
    
    func configure(with value: TextValue) {
        self.value = value
        self.textField.placeholder = value.name
        self.textField.text = value.value
        self.textField.keyboardType = value.keyboardType
    }
    
}
