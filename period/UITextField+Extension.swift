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
        datePicker.locale = Locale(identifier: "ru_RU")
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
    
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let barButton = UIBarButtonItem(title: "Выбрать", style: .plain, target: target, action: selector)
        barButton.tintColor = UIColor(named: "primary 700")
        barButton.setTitleTextAttributes(
            [.font : UIFont.systemFont(ofSize: 17, weight: .semibold)], for: .normal )
        
        toolBar.setItems([dateOf, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
        }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
          let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
          self.rightView = paddingView
          self.rightViewMode = .always
      }
}
