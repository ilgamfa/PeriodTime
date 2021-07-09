//  Created by Ильгам Ахматдинов on 30.06.2021.
//

import UIKit

protocol PeriodViewDelegate: AnyObject {
    func tappedClearButton()
    func tappedCloseButton()
    func tappedDateButtonTo()
    func tappedDateButtonFrom()
    func tappedChooseButton()
}

private extension PeriodView {
    struct Configurator {
        let toolBarItemTop: CGFloat = 15
        let toolBarChooseTop: CGFloat = 11
        let toolBarItemBottom: CGFloat = -11
        let toolBarItemLeading: CGFloat = 16
        let toolBarItemTrailing: CGFloat = -16
        let chooseBtnTopOffset: CGFloat = 24
        let closeBtnSideOffset: CGFloat = -18
        let heightThirdLevel: CGFloat = 40
        let dateTopOffset: CGFloat = 8
        let heightFirstLevel: CGFloat = 44
        let heightSecondLevel: CGFloat = 52
        let heightDatePicker: CGFloat = 270
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
    
    private var launchView = LaunchView(frame: UIScreen.main.bounds)
    
    private let configurator = Configurator()
    
    weak var delegate: PeriodViewDelegate?
    var updateDataDelegate: DataUpdateProtocol?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        datePicker.backgroundColor = .white
        datePicker.isHidden = true
        toolBarFrom.isHidden = true
        toolBarTo.isHidden = true
        setupViews()
        setupConstraints()
        addActions()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - variables
    
    
    
    private var dateFrom: Date = {
        let dateFrom = Date()
        return dateFrom
    }()
    
    private var dateTo: Date = {
        let dateTo = Date()
        return dateTo
    }()
    
    private let contentView: UIView = {
        let contentView = UIView()
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
    
    private let dateButtonFrom: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = Configurator().cornerRadius
        button.setTitle("Дата от", for: .normal)
        button.titleLabel?.font = Configurator().fontInterRegular16
        button.backgroundColor = #colorLiteral(red: 0.9568068385, green: 0.9661124349, blue: 0.9732303023, alpha: 1)
        button.setTitleColor(UIColor(named: "dateColor"), for: .normal)
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
    
    private let toolBarFrom: UIView = {
        let toolBarFrom = UIView()
        toolBarFrom.backgroundColor = UIColor(named: "toolBarBackColor")
        return toolBarFrom
    }()
    
    private let toolBarTo: UIView = {
        let toolBarFrom = UIView()
        toolBarFrom.backgroundColor = UIColor(named: "toolBarBackColor")
        return toolBarFrom
    }()
    
    private let toolBarFromChooseButton: UIButton = {
        let chooseButton = UIButton(type: .system)
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.titleLabel?.font = Configurator().fontInterRegular16
        chooseButton.titleLabel?.font = Configurator().boldSystemFont16
        chooseButton.setTitleColor(UIColor(named: "primary 700"), for: .normal)
        chooseButton.addTarget(self, action: #selector(tapDoneButtonClickFrom), for: .touchUpInside)
        return chooseButton
    }()
    
    private let toolBarToChooseButton: UIButton = {
        let chooseButton = UIButton(type: .system)
        chooseButton.setTitle("Выбрать", for: .normal)
        chooseButton.titleLabel?.font = Configurator().fontInterRegular16
        chooseButton.titleLabel?.font = Configurator().boldSystemFont16
        chooseButton.setTitleColor(UIColor(named: "primary 700"), for: .normal)
        chooseButton.addTarget(self, action: #selector(tapDoneButtonClickTo), for: .touchUpInside)
        return chooseButton
    }()
    
    private let toolBarDateBeginning: UILabel = {
        let label = UILabel()
        label.text = "Дата начала:"
        label.textColor = UIColor(named: "dateColor")
        label.font =  Configurator().fontInterRegular14
        return label
    }()
    
    private let toolBarDateEnding: UILabel = {
        let label = UILabel()
        label.text = "Дата конца:"
        label.textColor = UIColor(named: "dateColor")
        label.font =  Configurator().fontInterRegular14
        return label
    }()
    
    private let datePicker: UIDatePicker = {
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")

        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        return datePicker
    }()
    
    //MARK: - functions
    
    private func setupViews() {
        addSubview(contentView)
        
        contentView.addSubview(clearButton)
        contentView.addSubview(periodLabel)
        contentView.addSubview(closeButton)
        contentView.addSubview(dateButtonFrom)
        contentView.addSubview(dateButtonTo)
        contentView.addSubview(chooseButton)
        
        addSubview(datePicker)
        addSubview(toolBarFrom)
        addSubview(toolBarTo)
        
        toolBarFrom.addSubview(toolBarFromChooseButton)
        toolBarFrom.addSubview(toolBarDateBeginning)
        
        toolBarTo.addSubview(toolBarToChooseButton)
        toolBarTo.addSubview(toolBarDateEnding)
    }

    private func addActions() {
        clearButton.addTarget(self, action: #selector(tappedClearButton), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(tappedCloseButton), for: .touchUpInside)

        dateButtonFrom.addTarget(self, action: #selector(tappedDateButtonFrom), for: .touchUpInside)
        dateButtonTo.addTarget(self, action: #selector(tappedDateButtonTo), for: .touchUpInside)
        
        chooseButton.addTarget(self, action: #selector(tappedChooseButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: Configurator().contentTopOffset),
            contentView.bottomAnchor.constraint(equalTo: chooseButton.bottomAnchor, constant: Configurator().sideOffset),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Configurator().sideOffset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Configurator().sideOffset),
        ])
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clearButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configurator().dateTopOffset),
            clearButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configurator().sideOffset),
            clearButton.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])
        
        periodLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            periodLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configurator().dateTopOffset),
            periodLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            periodLabel.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])

        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Configurator().dateTopOffset),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Configurator().closeBtnSideOffset),
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
            dateButtonTo.heightAnchor.constraint(equalTo: dateButtonFrom.heightAnchor),
        ])

        chooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseButton.topAnchor.constraint(equalTo: dateButtonFrom.bottomAnchor, constant: Configurator().chooseBtnTopOffset),
            chooseButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Configurator().sideOffset),
            chooseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Configurator().sideOffset),
            chooseButton.heightAnchor.constraint(equalToConstant: Configurator().heightThirdLevel)
        ])

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.bottomAnchor.constraint(equalTo: bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: Configurator().heightDatePicker)
        ])
//
        toolBarFrom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBarFrom.bottomAnchor.constraint(equalTo: datePicker.topAnchor),
            toolBarFrom.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolBarFrom.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolBarFrom.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])

        toolBarDateBeginning.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBarDateBeginning.topAnchor.constraint(equalTo: toolBarFrom.topAnchor, constant: Configurator().toolBarItemTop),
            toolBarDateBeginning.leadingAnchor.constraint(equalTo: toolBarFrom.leadingAnchor, constant: Configurator().toolBarItemLeading),
            toolBarDateBeginning.bottomAnchor.constraint(equalTo: toolBarFrom.bottomAnchor, constant: Configurator().toolBarItemBottom)
        ])
        
        toolBarFromChooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBarFromChooseButton.topAnchor.constraint(equalTo: toolBarFrom.topAnchor, constant: Configurator().toolBarChooseTop),
            toolBarFromChooseButton.bottomAnchor.constraint(equalTo: toolBarFrom.bottomAnchor, constant: Configurator().toolBarItemBottom),
            toolBarFromChooseButton.trailingAnchor.constraint(equalTo: toolBarFrom.trailingAnchor, constant: Configurator().toolBarItemTrailing),
        ])
        
        toolBarTo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBarTo.bottomAnchor.constraint(equalTo: datePicker.topAnchor),
            toolBarTo.leadingAnchor.constraint(equalTo: leadingAnchor),
            toolBarTo.trailingAnchor.constraint(equalTo: trailingAnchor),
            toolBarTo.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])
        
        toolBarDateEnding.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBarDateEnding.topAnchor.constraint(equalTo: toolBarTo.topAnchor, constant: Configurator().toolBarItemTop),
            toolBarDateEnding.leadingAnchor.constraint(equalTo: toolBarTo.leadingAnchor, constant: Configurator().toolBarItemLeading),
            toolBarDateEnding.bottomAnchor.constraint(equalTo: toolBarTo.bottomAnchor, constant: Configurator().toolBarItemBottom)
        ])
        
        toolBarToChooseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolBarToChooseButton.topAnchor.constraint(equalTo: toolBarTo.topAnchor, constant: Configurator().toolBarChooseTop),
            toolBarToChooseButton.bottomAnchor.constraint(equalTo: toolBarFrom.bottomAnchor, constant:Configurator().toolBarItemBottom),
            toolBarToChooseButton.trailingAnchor.constraint(equalTo: toolBarTo.trailingAnchor, constant: Configurator().toolBarItemTrailing),
        ])
        
        
    }
    // MARK: - Handlers

    @objc func tappedCloseButton() {
        delegate?.tappedCloseButton()
        self.isHidden = true
        tappedClearButton()
    }
    
    @objc func tappedClearButton() {
        delegate?.tappedClearButton()
        dateButtonFrom.setTitle("Дата от", for: .normal)
        dateButtonFrom.setTitleColor(UIColor(named: "dateColor"), for: .normal)
        
        dateButtonTo.setTitle("Дата до", for: .normal)
        dateButtonTo.setTitleColor(UIColor(named: "dateColor"), for: .normal)
    }
    
    @objc func tappedChooseButton() {
        delegate?.tappedChooseButton()
        datePicker.isHidden = true
        toolBarFrom.isHidden = true
        toolBarTo.isHidden = true
        
        if dateFrom > dateTo {
            let alert = UIAlertController(title: "Проверь корректность введенных данных!", message: "'Дата до' не может быть раньше 'Даты от'", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Исправить", style: .default, handler: nil))
            UIApplication.shared.windows.last?.rootViewController?.present(alert, animated: true, completion: nil)
        } else {
            
            let dateformatter = DateFormatter()
            dateformatter.locale = Locale(identifier: "ru-RU")
            dateformatter.dateStyle = .short
            
            let stringDateFrom = dateformatter.string(from: dateFrom)
            let stringDateTo = dateformatter.string(from: dateTo)
            
            updateDataDelegate?.onDataUpdate(dateFrom: stringDateFrom, dateTo: stringDateTo)
            
            tappedCloseButton()
        }
        
    }
    
    @objc func tappedDateButtonFrom() {
        delegate?.tappedDateButtonFrom()
        datePicker.isHidden = false
        toolBarFrom.isHidden = false
        toolBarTo.isHidden = true
    }

    @objc func tappedDateButtonTo() {
        delegate?.tappedDateButtonTo()
        datePicker.isHidden = false
        toolBarTo.isHidden = false
        toolBarFrom.isHidden = true
    }
    
    @objc func tapDoneButtonClickFrom() {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ru-RU")
        dateformatter.dateStyle = .short
        dateFrom = datePicker.date
        let stringDateFrom = dateformatter.string(from: datePicker.date)
        dateButtonFrom.setTitle(stringDateFrom, for: .normal)
        dateButtonFrom.setTitleColor(.black, for: .normal)
    }
    
    @objc func tapDoneButtonClickTo() {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "ru-RU")
        dateformatter.dateStyle = .short
        dateTo = datePicker.date
        let stringDateTo = dateformatter.string(from: datePicker.date)
        dateButtonTo.setTitle(stringDateTo, for: .normal)
        dateButtonTo.setTitleColor(.black, for: .normal)
    }
}

//extension PeriodView: LaunchViewDelegate {
//    func tappedSetPeriodButton() {
//        print(#function)
//    }
//}
