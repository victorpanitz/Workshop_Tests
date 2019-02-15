import UIKit

class LoginRouter: LoginRoutering {
    
    weak var view: UIViewController?

    func makeViewController() -> UIViewController {
        let service = LoginService()
        let presenter = LoginPresenter(service: service, router: self)
        service.output = presenter
        let viewController = LoginViewController(presenter: presenter)
        self.view = viewController
        
        return viewController
    }
    
    func navigateToHome() {
        // Navegar para HOME
    }
    
}
