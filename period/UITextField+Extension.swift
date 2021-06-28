//
//  File.swift
//  period
//
//  Created by Ильгам Ахматдинов on 28.06.2021.
//

import UIKit
extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector, dateOf: UIBarButtonItem) {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date //2
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
    
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: target, action: selector)
        barButton.tintColor = #colorLiteral(red: 0.2591463923, green: 0.4271838069, blue: 0.6611289978, alpha: 1)
        
        toolBar.setItems([dateOf, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
        }
}
