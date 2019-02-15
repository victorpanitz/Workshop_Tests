import Quick
import Nimble

@testable import WorkshopTestes

/*
 
 Para relembrar o flow da criação dos testes :
 
 1º - Descrever o comportamento da camada de apresentação
 
 2º - Adicionar expect(camada.variavelObservada) == valor_esperado;
        Vai quebrar tudo! Após isto, é só atender o que está acusando ao não buildar.
        A cada vez que é atendido, nascerá um novo erro de build, até o momento que o build seja
        succeeded e seja possível fazer o teste passar.
 
 3º - Para fazer passar, deve-se criar os Spy's. Eles apenas implementam a interface de cada camada (view, router, service)
        acessada pelos delegates. O Spy é sempre da camada de fora, a camada que está sendo testada (neste caso, Presenter),
        utiliza-se a classe concreta. Quando houver a implementação dos testes do service por exemplo, a camada concreta
        será a do service e haverá um spy do Output que no caso é o Presenter (que implementa LoginServiceOutput, logo existiria no teste do service um LoginServiceOutputSpy).
 
 */


class LoginPresenterTests: QuickSpec {
 
    override func spec() {
        
        var presenter: LoginPresenter!
        var view: LoginViewSpy!
        var service: LoginServiceInputSpy!
        var router: LoginRouteringSpy!
        
        describe("LoginPresenter") {
            
            beforeEach {
                service = LoginServiceInputSpy()
                router = LoginRouteringSpy()
                view = LoginViewSpy()
                presenter = LoginPresenter(service: service, router: router)
    
                presenter.attachView(view)
            }
            
            describe("quando a view carregar") {
                
                it("então deverá configurar o titulo da cena") {
                    
                    expect(view.valorDoTituloPassado) == "Cocoaheads"
                    expect(view.setarTituloDaCenaFoiChamado) == true
                    
                }
                
                it("então deverá configurar o placeholder do login") {
                    
                    expect(view.valorDoPlaceholderLoginPassado) == "Insira seu email"
                    expect(view.setarPlaceholderLoginFoiChamado) == true
                    
                }
                
                it("então deverá configurar o placeholder da senha") {
                    
                    expect(view.valorDoPlaceholderSenhaPassado) == "Insira sua senha"
                    expect(view.setarPlaceholderSenhaFoiChamado) == true
                    
                }
                
                it("então deverá configurar o titulo ação primária") {
                    
                    expect(view.valorTituloBotaoPassado) == "Entrar"
                    expect(view.setarTituloAcaoPrimarioFoiChamado) == true
                    
                }
                
            }
            
            // TODO: implementar em caso de algum tratamento específico (ex: máscara)
            
//            describe("quando o input de email alterar") {
//
//                it("")
//
//            }
//
//            describe("quando o input de password alterar") {
//
//                it("")
//
//            }
            
            describe("quando a acao primaria for acionada") {
                
                context("e os dados inputados forem validos") {
                
                    beforeEach {
                        presenter.emailInputDidChange("email value")
                        presenter.passwordInputDidChange("password value")
                        presenter.primaryActionTriggered()
                    }
                    
                    it("então deverá delegar a validação do login") {
                        
                        expect(service.valorDeEmailPassado) == "email value"
                        expect(service.valorDePasswordPassado) == "password value"
                        expect(service.validarLoginChamado) == true
                        
                    }
                    
                }
                
                context("e os dados inputados forem invalidos") {
                    
                    beforeEach {
                        presenter.emailInputDidChange("")
                        presenter.passwordInputDidChange("")
                        presenter.primaryActionTriggered()
                    }
                    
                    it("então deverá exibir um alerta de erro ao usuário") {
                        
                        expect(view.showErrorMessagePassed) == "Dados inválidos"
                        expect(view.showErrorCalled) == true
                        
                    }
                    
                }
                
            }
            
            describe("quando a validação retornar com sucesso") {
                
                beforeEach {
                    presenter.validateLoginSucceeded()
                }
                
                it("então deverá delegar a navegação para `Home`") {
                    expect(router.navigateToHomeCalled) == true
                }
                
            }
            
            describe("quando a validação retornar com erro") {
                
                beforeEach {
                    presenter.validateLoginFailed()
                }

                
                it("então deverá exibier um alerta de erro ao usuário") {
                    expect(view.showErrorCalled) == true
                    expect(view.showErrorMessagePassed) == "Erro ao validar o seu usuário."
                }
                
            }
            
        }
        
    }
    
}


private class LoginViewSpy: LoginView {

    var valorDoTituloPassado: String?
    var setarTituloDaCenaFoiChamado: Bool?
    
    var valorDoPlaceholderLoginPassado: String?
    var setarPlaceholderLoginFoiChamado: Bool?
    
    var valorDoPlaceholderSenhaPassado: String?
    var setarPlaceholderSenhaFoiChamado: Bool?
    
    var valorTituloBotaoPassado: String?
    var setarTituloAcaoPrimarioFoiChamado: Bool?
    
    var showErrorMessagePassed: String?
    var showErrorCalled: Bool?
    
    func showError(message: String) {
        showErrorMessagePassed = message
        showErrorCalled = true
    }
    
    func setSceneTitle(_ text: String) {
        valorDoTituloPassado = text
        setarTituloDaCenaFoiChamado = true
    }
    
    func setLoginPlaceholder(_ text: String) {
        valorDoPlaceholderLoginPassado = text
        setarPlaceholderLoginFoiChamado = true
    }
    
    func setPasswordPlaceholder(_ text: String) {
        valorDoPlaceholderSenhaPassado = text
        setarPlaceholderSenhaFoiChamado = true
    }
    
    func setPrimaryActionTitle(_ text: String) {
        valorTituloBotaoPassado = text
        setarTituloAcaoPrimarioFoiChamado = true
    }
    
}

private class LoginServiceInputSpy: LoginServiceInput {
    var output: LoginServiceOutput?
    
    var valorDeEmailPassado: String?
    var valorDePasswordPassado: String?
    var validarLoginChamado: Bool?
    
    func validateLogin(email: String, password: String) {
        valorDeEmailPassado = email
        valorDePasswordPassado = password
        validarLoginChamado = true
    }
}

private class LoginRouteringSpy: LoginRoutering {
    var navigateToHomeCalled: Bool?
    
    func navigateToHome() {
        navigateToHomeCalled = true
    }

}
