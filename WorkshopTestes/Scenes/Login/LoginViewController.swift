import UIKit

class LoginViewController: UIViewController {
    
    private let presenter: LoginPresenter
    
    init(presenter: LoginPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .blue
        
        setupTitleLayout()
        setupEmailFieldLayout()
        setupPasswordFieldLayout()
        setupPrimaryActionLayout()
        
        presenter.attachView(self)
    }
    
    private func setupTitleLayout() {}
    
    private func setupEmailFieldLayout() {}
    
    private func setupPasswordFieldLayout() {}
    
    private func setupPrimaryActionLayout() {}
    
}

extension LoginViewController: LoginView {
    func setSceneTitle(_ text: String) {
        
    }
    
    func setLoginPlaceholder(_ text: String) {
        
    }
    
    func setPasswordPlaceholder(_ text: String) {
        
    }
    
    func setPrimaryActionTitle(_ text: String) {
        
    }
    
    func showError(message: String) {
        
    }
    
}
