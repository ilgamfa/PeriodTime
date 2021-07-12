//
//  launch.swift
//  period
//
//  Created by Ильгам Ахматдинов on 05.07.2021.
//

import UIKit

protocol LaunchViewDelegate: AnyObject {
    func tappedSetPeriodButton()
}

private extension LaunchView {
    struct Configurator {
        let heightDateLabel: CGFloat = 44
        let heightContentView: CGFloat = 80
        let cornerRadius: CGFloat = 8
        let boldSystemFont16 = UIFont.boldSystemFont(ofSize: 16)
        let boldSystemFont14 = UIFont.boldSystemFont(ofSize: 14)
        let fontInterRegular16 =  UIFont(name: "Inter-Regular", size: 16)
        let fontInterRegular14 =  UIFont(name: "Inter-Regular", size: 14)
        let sideOffset: CGFloat = 16
    }
}

final class LaunchView: UIView {
    private let configurator = Configurator()

    private var periodView = PeriodView(frame: UIScreen.main.bounds)
    
    weak var delegate: LaunchViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        setupViews()
        setupConstraints()
        addActions()
        periodView.updateDataDelegate = self
        self.addSubview(periodView)
        periodView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let contentView: UIView = {
        let contentView = UIView(frame: .zero)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = Configurator().cornerRadius
        return contentView
    }()
    
    
    private var dateLabelFrom: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = UIColor(named: "dateColor")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = Configurator().cornerRadius
        label.text = "  Дата от: "
        label.textAlignment = .left
        label.tintColor = .black
        label.font = Configurator().fontInterRegular16
        return label
    }()
    
    private var dateLabelTo: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = UIColor(named: "dateColor")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = Configurator().cornerRadius
        label.text = "  Дата до: "
        label.textAlignment = .left
        label.tintColor = .black
        label.font = Configurator().fontInterRegular16
        return label
    }()
    
    private let setPeriodButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = Configurator().cornerRadius
        button.setTitle("  Установить период  ", for: .normal)
        button.titleLabel?.font = Configurator().fontInterRegular16
        button.titleLabel?.font = Configurator().boldSystemFont16
        button.backgroundColor = #colorLiteral(red: 0.2591463923, green: 0.4271838069, blue: 0.6611289978, alpha: 1)
        button.tintColor = .white
        return button

    }()

    
    private func setupViews() {
        addSubview(contentView)
        addSubview(setPeriodButton)
        addSubview(dateLabelFrom)
        addSubview(dateLabelTo)
    }
    
    private func addActions() {
        setPeriodButton.addTarget(self, action: #selector(tappedSetPeriodButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: Configurator().heightContentView),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Configurator().sideOffset),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Configurator().sideOffset),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Configurator().sideOffset),
        ])
        
        setPeriodButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setPeriodButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            setPeriodButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            setPeriodButton.heightAnchor.constraint(equalToConstant: Configurator().heightDateLabel)
        ])
        
        dateLabelFrom.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabelFrom.heightAnchor.constraint(equalToConstant: Configurator().heightDateLabel),
            dateLabelFrom.bottomAnchor.constraint(equalTo: dateLabelTo.topAnchor, constant: -Configurator().sideOffset),
            dateLabelFrom.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Configurator().sideOffset),
            dateLabelFrom.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Configurator().sideOffset),
        ])
        
        dateLabelTo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabelTo.heightAnchor.constraint(equalToConstant: Configurator().heightDateLabel),
            dateLabelTo.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -Configurator().sideOffset),
            dateLabelTo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Configurator().sideOffset),
            dateLabelTo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Configurator().sideOffset),
        ])
        

    }

    @objc func tappedSetPeriodButton() {
        delegate?.tappedSetPeriodButton()
        dateLabelFrom.text = "  Дата до: "
        dateLabelTo.text = "  Дата от: "
        periodView.isHidden = !periodView.isHidden
    }

}

extension LaunchView: DataUpdateDelegate {
    
    func onDataUpdate(dateFrom: String, dateTo: String) {
        
        dateLabelFrom.text? += dateFrom
        dateLabelTo.text? += dateTo
    }
}
