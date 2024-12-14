import SwiftUI
import Combine
import Domain

#if DEBUG
#Preview {
    return CurrencyConversorView.createPreview()
}

extension CurrencyConversorView {
    
    static func createPreview() -> UINavigationController {
        let navigationController = UINavigationController()
        let dependencies = CurrencyConversorDependencies.local
        let router = CurrencyConversorRouter(navigationController: navigationController)
        router.showScene(dependencies: dependencies)
        return navigationController
    }
    
}
#endif
