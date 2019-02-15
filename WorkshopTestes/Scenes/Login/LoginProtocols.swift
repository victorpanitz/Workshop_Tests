protocol LoginView: AnyObject {
    func setSceneTitle(_ text: String)
    func setLoginPlaceholder(_ text: String)
    func setPasswordPlaceholder(_ text: String)
    func setPrimaryActionTitle(_ text: String)
    func showError(message: String)
}

protocol LoginServiceInput: AnyObject {
    var output: LoginServiceOutput? {get set}
    
    func validateLogin(email: String, password: String)
}

protocol LoginServiceOutput: AnyObject {
    func validateLoginSucceeded()
    func validateLoginFailed()
}

protocol LoginRoutering: AnyObject {
    func navigateToHome()
}
