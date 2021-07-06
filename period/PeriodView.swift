//  Created by Ильгам Ахматдинов on 30.06.2021.
//

import UIKit

private extension PeriodView {
    struct Configurator {
        let chooseBtnTopOffset: CGFloat = 24
        let heightThirdLevel: CGFloat = 40
        let dateTopOffset: CGFloat = 8
        let heightFirstLevel: CGFloat = 44
        let heightSecondLevel: CGFloat = 52
        let contentTopOffset: CGFloat = 102
        let cornerRadius: CGFloat = 8
        let boldSystemFont16 = UIFont.boldSystemFont(ofSize: 16)
        let boldSystemFont14 = UIFont.boldSystemFont(ofSize: 14)
        let fontInterRegular16 =  UIFont(name: "Inter-Regular", size: 16)
        let fontInterRegular14 =  UIFont(name: "Inter-Regular", size: 14)
        let sideOffset: CGFloat = 16
        let topOffset: CGFloat = 14
        let centerOffset: CGFloat = 4
        let paddingPoints: CGFloat = 16
    }
}

final class PeriodView: UIView {
    
    private let configurator = Configurator()
    
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
    
   
    

    //MARK: - variables

    private let contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = Configurator().cornerRadius
        
        return contentView
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Очистить", for: .normal)
        button.titleLabel?.font = Configurator().fontInterRegular14
        button.titleLabel?.font = Configurator().boldSystemFont14
        button.setTitleColor(UIColor(named: "primary 500"), for: .normal)
        return button
    }()
    
    private let periodLabel: UILabel = {
        let label = UILabel()
        label.font =  Configurator().fontInterRegular16
        label.text = "Период"
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cancel_24px"), for: .normal)
        return button
    }()
    
    private let dateTextFieldFrom: UITextField = {
        let dateTextFieldFrom = UITextField()
        dateTextFieldFrom.layer.cornerRadius = Configurator().cornerRadius
        dateTextFieldFrom.placeholder = "Дата от"
        dateTextFieldFrom.font = Configurator().fontInterRegular16
        dateTextFieldFrom.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        dateTextFieldFrom.setLeftPaddingPoints(Configurator().paddingPoints)
        dateTextFieldFrom.setRightPaddingPoints(Configurator().paddingPoints)
        return dateTextFieldFrom
    }()
    
    private let dateButtonFrom: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Configurator().cornerRadius
        button.setTitle("Дата от", for: .normal)
        button.titleLabel?.font = Configurator().fontInterRegular16
        button.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        button.setTitleColor(UIColor(named: "dateColor"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return button
    }()
    
    private let dateButtonTo: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Configurator().cornerRadius
        button.setTitle("Дата до", for: .normal)
        button.titleLabel?.font = Configurator().fontInterRegular16
        button.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        button.setTitleColor(UIColor(named: "dateColor"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return button
    }()
    
    private let dateTextFieldTo: UITextField = {
        let dateTextFieldTo = UITextField()
        dateTextFieldTo.layer.cornerRadius = Configurator().cornerRadius
        dateTextFieldTo.placeholder = "Дата до"
        dateTextFieldTo.font = Configurator().fontInterRegular16
        dateTextFieldTo.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        dateTextFieldTo.setLeftPaddingPoints(Configurator().paddingPoints)
        dateTextFieldTo.setRightPaddingPoints(Configurator().paddingPoints)
        return dateTextFieldTo
    }()
    
    private let chooseButton: UIButton = {
        let chooseButton = UIButton(type: .system)
        chooseButton.layer.cornerRadius = Configurator().cornerRadius
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.titleLabel?.font = Configurator().fontInterRegular16
        chooseButton.titleLabel?.font = Configurator().boldSystemFont16
        chooseButton.backgroundColor = #colorLiteral(red: 0.2591463923, green: 0.4271838069, blue: 0.6611289978, alpha: 1)
        chooseButton.tintColor = .white
        return chooseButton
    }()
    
    //MARK: - functions
    
    private func setupViews() {
        self.addSubview(contentView)
        self.addSubview(clearButton)
        self.addSubview(periodLabel)
        self.addSubview(closeButton)
        self.addSubview(dateButtonFrom)
        self.addSubview(dateButtonTo)
        self.addSubview(chooseButton)
    }

    private func addActions() {
        clearButton.addTarget(self, action: #selector(tappedClearButton), for: .touchUpInside)
        chooseButton.addTarget(self, action: #selector(tappedChooseButton), for: .touchUpInside)
        
        dateButtonFrom.addTarget(self, action: #selector(tappedDateButtonFrom), for: .touchUpInside)
        dateButtonTo.addTarget(self, action: #selector(tappedDateButtonTo), for: .touchUpInside)
        
        let dateOfBeginning = UIBarButtonItem(title: "Дата начала:", style: .plain, target: nil, action: nil)
        dateOfBeginning.isEnabled = false
        let dateOfEnding = UIBarButtonItem(title: "Дата конца:", style: .plain, target: nil, action: nil)
        dateOfEnding.isEnabled = false
//        dateTextFieldFrom.setInputViewDatePicker(target: self, selector: #selector(tapDoneInFrom), dateOf:dateOfBeginning )
        
//        dateTextFieldTo.setInputViewDatePicker(target: self, selector: #selector(tapDoneInTo), dateOf:dateOfEnding)
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: Configurator().contentTopOffset),
            contentView.bottomAnchor.constraint(equalTo: chooseButton.bottomAnchor, constant: Configurator().sideOffset),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Configurator().sideOffset),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Configurator().sideOffset),
        ])
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configurator().topOffset),
            clearButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configurator().sideOffset),
            clearButton.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])
        
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            periodLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configurator().topOffset),
            periodLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            periodLabel.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configurator().topOffset),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configurator().sideOffset),
            closeButton.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])
        
        dateButtonFrom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateButtonFrom.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: Configurator().dateTopOffset),
            dateButtonFrom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configurator().sideOffset),
            dateButtonFrom.trailingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -Configurator().centerOffset),
            dateButtonFrom.heightAnchor.constraint(equalToConstant: Configurator().heightSecondLevel),
        ])
        
        dateButtonTo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateButtonTo.topAnchor.constraint(equalTo: dateButtonFrom.topAnchor),
            dateButtonTo.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: Configurator().centerOffset),
            dateButtonTo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configurator().sideOffset),
            dateButtonTo.heightAnchor.constraint(equalToConstant: Configurator().heightSecondLevel),
        ])
        
        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseButton.topAnchor.constraint(equalTo: dateButtonFrom.bottomAnchor, constant: Configurator().chooseBtnTopOffset),
            chooseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configurator().sideOffset),
            chooseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configurator().sideOffset),
            chooseButton.heightAnchor.constraint(equalToConstant: Configurator().heightThirdLevel)
        ])
        
    }
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
        dateButtonFrom.setTitle("Дата от", for: .normal)
        dateButtonTo.setTitle("Дата до", for: .normal)

//        dateTextFieldFrom.text = ""
//        dateTextFieldTo.text = ""
    }
    
    @objc func tappedChooseButton() {
        self.dateButtonFrom.resignFirstResponder()
        self.dateButtonTo.resignFirstResponder()
//        self.dateTextFieldTo.resignFirstResponder()
//        self.dateTextFieldFrom.resignFirstResponder()
    }
    
    @objc func tappedDateButtonFrom() {
        
    }
    
    @objc func tappedDateButtonTo() {
        
    }
    
}
