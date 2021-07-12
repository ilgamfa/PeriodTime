//  Created by Ильгам Ахматдинов on 29.06.2021.
//

import UIKit

final class PeriodViewController: UIViewController {

    private var periodView = PeriodView(frame: UIScreen.main.bounds)
    private var launchView = LaunchView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = launchView
        launchView.delegate = self
        periodView.delegate = self
       }
}

extension PeriodViewController: LaunchViewDelegate {
    
    func tappedSetPeriodButton() {
        print(#function)
    }
}

extension PeriodViewController: PeriodViewDelegate {
    func tappedChooseButton() {
        
        print(#function)
    }

    func tappedCloseButton() {
        print(#function)
    }

    func tappedDateButtonFrom() {
        print(#function)
    }

    func tappedDateButtonTo() {
        print(#function)
    }

    func tappedClearButton() {
        print(#function)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}
