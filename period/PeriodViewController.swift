//  Created by Ильгам Ахматдинов on 29.06.2021.
//

import UIKit

protocol DataUpdateProtocol {
    func onDataUpdate(dateFrom: String, dateTo: String)
}


final class PeriodViewController: UIViewController {

    private var periodView = PeriodView(frame: UIScreen.main.bounds)
    private var launchView = LaunchView(frame: UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        self.view = launchView
        launchView.delegate = self
        view.addSubview(periodView)
        periodView.delegate = self
        periodView.isHidden = true
       }
}

extension PeriodViewController: LaunchViewDelegate {
    
    func tappedSetPeriodButton() {
        print(#function)
        periodView.isHidden = !periodView.isHidden
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
