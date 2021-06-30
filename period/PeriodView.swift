//
//  TestPeriodView.swift
//  period
//
//  Created by Ильгам Ахматдинов on 30.06.2021.
//

import UIKit

private extension PeriodView {
    struct Configurator {
        let cornerRadius: CGFloat = 8
    }
}

final class PeriodView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        setupViews()
        setupConstraints()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(contentView)
        self.addSubview(clearButton)
        self.addSubview(periodLabel)
        self.addSubview(closeButton)
        self.addSubview(dateTextFieldFrom)
        self.addSubview(dateTextFieldTo)
        self.addSubview(chooseButton)
    }
    
    
    func addActions() {
        clearButton.addTarget(self, action: #selector(tappedClearButton), for: .touchUpInside)
        chooseButton.addTarget(self, action: #selector(tappedChooseButton), for: .touchUpInside)
        let dateOfBeginning = UIBarButtonItem(title: "Дата начала:", style: .plain, target: nil, action: nil)
        dateOfBeginning.isEnabled = false
        let dateOfEnding = UIBarButtonItem(title: "Дата конца:", style: .plain, target: nil, action: nil)
        dateOfEnding.isEnabled = false
        dateTextFieldFrom.setInputViewDatePicker(target: self, selector: #selector(tapDoneInFrom), dateOf:dateOfBeginning )
        
        dateTextFieldTo.setInputViewDatePicker(target: self, selector: #selector(tapDoneInTo), dateOf:dateOfEnding)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 102),
            contentView.bottomAnchor.constraint(equalTo: chooseButton.bottomAnchor, constant: 16),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            clearButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            clearButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            periodLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            periodLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            periodLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        dateTextFieldFrom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateTextFieldFrom.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 8),
            dateTextFieldFrom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dateTextFieldFrom.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -5),
            dateTextFieldFrom.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        dateTextFieldTo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateTextFieldTo.topAnchor.constraint(equalTo: dateTextFieldFrom.topAnchor),
            dateTextFieldTo.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 5),
            dateTextFieldTo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateTextFieldTo.heightAnchor.constraint(equalToConstant: 52),
        ])
        
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseButton.topAnchor.constraint(equalTo: dateTextFieldFrom.bottomAnchor, constant: 24),
            chooseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            chooseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            chooseButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    
    let contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        
        return contentView
    }()
    
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Очистить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Regular", size: 14)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(named: "primary 500"), for: .normal)
        return button
    }()
    
    let periodLabel: UILabel = {
        let label = UILabel()
        label.font =  UIFont(name: "Inter-Regular", size: 16)
        label.text = "Период"
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cancel_24px"), for: .normal)
        return button
    }()
    
    let dateTextFieldFrom: UITextField = {
        let dateTextFieldFrom = UITextField()
        dateTextFieldFrom.layer.cornerRadius = 8
        dateTextFieldFrom.placeholder = "Дата от"
        dateTextFieldFrom.font = UIFont(name: "Inter-Regular", size: 16)
        dateTextFieldFrom.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        dateTextFieldFrom.setLeftPaddingPoints(16)
        dateTextFieldFrom.setRightPaddingPoints(16)
        return dateTextFieldFrom
    }()
    
    let dateTextFieldTo: UITextField = {
        let dateTextFieldTo = UITextField()
        dateTextFieldTo.layer.cornerRadius = 8
        dateTextFieldTo.placeholder = "Дата до"
        dateTextFieldTo.font = UIFont(name: "Inter-Regular", size: 16)
        dateTextFieldTo.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        dateTextFieldTo.setLeftPaddingPoints(16)
        dateTextFieldTo.setRightPaddingPoints(16)
        return dateTextFieldTo
    }()
    
    let chooseButton: UIButton = {
        let chooseButton = UIButton(type: .system)
        chooseButton.layer.cornerRadius = 8
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.titleLabel?.font = UIFont(name: "Inter-Regular", size: 16)
        chooseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        chooseButton.backgroundColor = #colorLiteral(red: 0.2591463923, green: 0.4271838069, blue: 0.6611289978, alpha: 1)
        chooseButton.tintColor = .white
        return chooseButton
    }()
    
    // MARK: - Handlers
    
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
