//
//  testViewController.swift
//  period
//
//  Created by Ильгам Ахматдинов on 29.06.2021.
//

import UIKit

final class PeriodViewController: UIViewController {
    private var periodView: PeriodView { return self.view as! PeriodView }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = PeriodView(frame: UIScreen.main.bounds)
    }

}
