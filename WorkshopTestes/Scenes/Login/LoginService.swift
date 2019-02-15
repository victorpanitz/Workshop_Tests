
class LoginService: LoginServiceInput {
    weak var output: LoginServiceOutput?
    
    func validateLogin(email: String, password: String) {
        
        //TODO: Chamar serviço de validação
        
        // Retorno com sucesso
//        output?.validateLoginSucceeded()
        
        // Retorno com falha
//        output?.validateLoginFailed()
        
    }
    
}
