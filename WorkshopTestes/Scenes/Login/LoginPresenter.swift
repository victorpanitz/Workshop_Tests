import Foundation

final class LoginPresenter {
    
    var router: LoginRoutering
    var service: LoginServiceInput
    weak var view: LoginView?
    
    private var emailValue: String?
    private var passwordValue: String?
    
    init(service: LoginServiceInput, router: LoginRoutering) {
        self.service = service
        self.router = router
    }
    
    func attachView(_ view: LoginView) {
        self.view = view
        
        view.setSceneTitle("Cocoaheads")
        view.setLoginPlaceholder("Insira seu email")
        view.setPasswordPlaceholder("Insira sua senha")
        view.setPrimaryActionTitle("Entrar")
    }
    
    func emailInputDidChange(_ text: String) {
        emailValue = text
    }
    
    func passwordInputDidChange(_ text: String) {
        passwordValue = text
    }
    
    func primaryActionTriggered() {
        
        guard
            let email = emailValue,
            let pass = passwordValue,
            !email.isEmpty,
            !pass.isEmpty else {
            
                view?.showError(message: "Dados inválidos")
                
            return
        }
        
        service.validateLogin(email: email, password: pass)
        
    }
    
}

extension LoginPresenter: LoginServiceOutput {
    
    func validateLoginSucceeded() {
        router.navigateToHome()
    }
    
    func validateLoginFailed() {
        view?.showError(message: "Erro ao validar o seu usuário.")
    }
    
}
