//
//  launch.swift
//  period
//
//  Created by Ильгам Ахматдинов on 05.07.2021.
//

import UIKit

private extension LaunchView {
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

final class LaunchView: UIView {
    private let configurator = Configurator()
    private let periodView = PeriodView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        periodView.isHidden = true
        setupViews()
        setupConstraints()
        addActions()
        
        
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
        self.addSubview(periodView)
        self.addSubview(contentView)
        self.addSubview(setPeriodButton)
    }
    
    private func addActions() {
        setPeriodButton.addTarget(self, action: #selector(tappedSetPeriodButton), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: Configurator().contentTopOffset),
            contentView.bottomAnchor.constraint(equalTo: setPeriodButton.bottomAnchor, constant: Configurator().sideOffset),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Configurator().sideOffset),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Configurator().sideOffset),
        ])
        
        setPeriodButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setPeriodButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            setPeriodButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            setPeriodButton.heightAnchor.constraint(equalToConstant: Configurator().heightFirstLevel)
        ])

    }
    
    @objc func tappedSetPeriodButton() {
        periodView.isHidden = false
        
    }
}
