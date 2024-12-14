import Foundation
import UIKit

// import PKHUD

public extension LoadingHud where Self: UIViewController {
    func showLoadingDialog() {
        DispatchQueue.main.async {
//            PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
//            PKHUD.sharedHUD.show()
        }
    }
    
    func hideLoadingDialog() {
        DispatchQueue.main.async {
//            PKHUD.sharedHUD.hide(animated: true, completion: nil)
        }
    }
}
