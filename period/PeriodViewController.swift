//
//  ViewController.swift
//  period
//
//  Created by Ильгам Ахматдинов on 25.06.2021.
//

import UIKit

final class PeriodViewController: UIViewController {

    var periodView: UIView!
    
    var clearButton: UIButton!
    var periodLabel: UILabel!
    var closeButton: UIButton!
    weak var dateTextFieldFrom: UITextField!
    weak var dateTextFieldTo: UITextField!
    var chooseButton: UIButton!
    var closeImage: UIImage!
    
    var datePicker: UIDatePicker!
    
  
    
    
     override func loadView() {
         super.loadView()
        
        let periodView = UIView()
        
        let clearButton = UIButton()
        let periodLabel = UILabel()
        let closeButton = UIButton()
        let dateTextFieldFrom = UITextField()
        let dateTextFieldTo = UITextField()
        let chooseButton = UIButton()
        let closeImage = UIImage(named: "cancel_24px")
        
        
        
        periodView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(periodView)
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(clearButton)
        
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(periodLabel)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(closeButton)
        
        dateTextFieldFrom.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dateTextFieldFrom)
        
        dateTextFieldTo.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dateTextFieldTo)
        
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(chooseButton)
        
         NSLayoutConstraint.activate([
            periodView.topAnchor.constraint(equalTo: view.topAnchor, constant: 102),
            periodView.bottomAnchor.constraint(equalTo: chooseButton.bottomAnchor, constant: 16),
            periodView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            periodView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
         ])
            
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: periodView.topAnchor, constant: 14),
            clearButton.leadingAnchor.constraint(equalTo: periodView.leadingAnchor, constant: 16),
            clearButton.heightAnchor.constraint(equalToConstant: 44)
        ])
          
        NSLayoutConstraint.activate([
            periodLabel.topAnchor.constraint(equalTo: periodView.topAnchor, constant: 14),
            periodLabel.centerXAnchor.constraint(equalTo: periodView.centerXAnchor),
            periodLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: periodView.topAnchor, constant: 14),
            closeButton.trailingAnchor.constraint(equalTo: periodView.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            dateTextFieldFrom.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 8),
            dateTextFieldFrom.leadingAnchor.constraint(equalTo: periodView.leadingAnchor, constant: 16),
            dateTextFieldFrom.trailingAnchor.constraint(equalTo: periodView.centerXAnchor, constant: -5),
            dateTextFieldFrom.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        NSLayoutConstraint.activate([
            dateTextFieldTo.topAnchor.constraint(equalTo: dateTextFieldFrom.topAnchor),
            dateTextFieldTo.leadingAnchor.constraint(equalTo: periodView.centerXAnchor, constant: 5),
            dateTextFieldTo.trailingAnchor.constraint(equalTo: periodView.trailingAnchor, constant: -16),
            dateTextFieldTo.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        NSLayoutConstraint.activate([
            chooseButton.topAnchor.constraint(equalTo: dateTextFieldFrom.bottomAnchor, constant: 24),
            chooseButton.leadingAnchor.constraint(equalTo: periodView.leadingAnchor, constant: 16),
            chooseButton.trailingAnchor.constraint(equalTo: periodView.trailingAnchor, constant: -16),
            chooseButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        
        periodView.layer.cornerRadius = 8
        self.periodView = periodView
        
                
        self.clearButton = clearButton
        clearButton.setTitle("Очистить", for: .normal)
        clearButton.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        clearButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        clearButton.setTitleColor(#colorLiteral(red: 0.2591463923, green: 0.4271838069, blue: 0.6611289978, alpha: 1), for: .normal)
        clearButton.addTarget(self, action: #selector(tappedClearButton), for: .touchUpInside)
        
        self.periodLabel = periodLabel
        periodLabel.font = UIFont(name: "Inter-Regular", size: 16)
        periodLabel.text = "Период"
        
        self.closeButton = closeButton
        closeButton.setImage(closeImage, for: .normal)
        
        self.dateTextFieldFrom = dateTextFieldFrom
        dateTextFieldFrom.layer.cornerRadius = 8
        dateTextFieldFrom.placeholder = "Дата от"
        dateTextFieldFrom.font = UIFont(name: "Inter-Regular", size: 16)
        dateTextFieldFrom.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        dateTextFieldFrom.setLeftPaddingPoints(16)
        dateTextFieldFrom.setRightPaddingPoints(16)
        
        self.dateTextFieldTo = dateTextFieldTo
        dateTextFieldTo.layer.cornerRadius = 8
        dateTextFieldTo.placeholder = "Дата до"
        dateTextFieldTo.font = UIFont(name: "Inter-Regular", size: 16)
        dateTextFieldTo.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        dateTextFieldTo.setLeftPaddingPoints(16)
        dateTextFieldTo.setRightPaddingPoints(16)
        
        self.chooseButton = chooseButton
        chooseButton.layer.cornerRadius = 8
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.titleLabel?.font = UIFont(name: "Inter-Regular", size: 16)
        chooseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        chooseButton.backgroundColor = #colorLiteral(red: 0.2591463923, green: 0.4271838069, blue: 0.6611289978, alpha: 1)
        chooseButton.tintColor = .white
        chooseButton.addTarget(self, action: #selector(tappedChooseButton), for: .touchUpInside)
        
        
        
    }
    
    

     override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        self.periodView.backgroundColor = .white
        
        let dateOfBeginning = UIBarButtonItem(title: "Дата начала:", style: .plain, target: nil, action: nil)
        dateOfBeginning.isEnabled = false
        
        let dateOfEnding = UIBarButtonItem(title: "Дата конца:", style: .plain, target: nil, action: nil)
        dateOfEnding.isEnabled = false
        
        self.dateTextFieldFrom.setInputViewDatePicker(target: self, selector: #selector(tapDoneInFrom), dateOf:dateOfBeginning )
        self.dateTextFieldTo.setInputViewDatePicker(target: self, selector: #selector(tapDoneInTo), dateOf:dateOfEnding)
     }
    
    
    
    @objc func tapDoneInFrom() {
        if let datePicker = self.dateTextFieldFrom.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.locale = Locale(identifier: "ru-RU")
            dateformatter.dateStyle = .short
            self.dateTextFieldFrom.text = dateformatter.string(from: datePicker.date)
        }
        self.dateTextFieldFrom.resignFirstResponder()
        
    }
    @objc func tapDoneInTo() {
        if let datePicker = self.dateTextFieldTo.inputView as? UIDatePicker {
            let dateformatter = DateFormatter()
            dateformatter.locale = Locale(identifier: "ru-RU")
            dateformatter.dateStyle = .short
            self.dateTextFieldTo.text = dateformatter.string(from: datePicker.date)
        }
        self.dateTextFieldTo.resignFirstResponder() 
    }
    
    @objc func tappedClearButton() {
        dateTextFieldFrom.text = ""
        dateTextFieldTo.text = ""
    }
    
    @objc func tappedChooseButton() {
        self.dateTextFieldTo.resignFirstResponder()
        self.dateTextFieldFrom.resignFirstResponder()
    }
    
    
}
