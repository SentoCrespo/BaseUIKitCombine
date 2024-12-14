import Foundation
import SwiftUI
import Domain

protocol CurrencyConversorRouterProtocol {
    func showScene(dependencies: CurrencyConversorDependencies) async
}

/// Scene constructor with dependencies and View<>ViewModel binding
class CurrencyConversorRouter {
    
    // MARK: - Properties
    private weak var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
 
extension CurrencyConversorRouter: CurrencyConversorRouterProtocol {

    func showScene(dependencies: CurrencyConversorDependencies) {
        guard let viewController = UIStoryboard(
            name: "CurrencyConversorView",
            bundle: nil
        ).instantiateInitialViewController() as? CurrencyConversorView else {
            fatalError("Initial controller not found")
        }
        
        let viewModel = CurrencyConversorViewModel(
            dependencies: dependencies,
            view: viewController
        )
        viewController.setup(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
}
