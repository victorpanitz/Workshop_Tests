# Workshop_Tests
Projeto desenvolvido durante a facilitação de um workshop de testes, aonde foi implementada a estrutura de um módulo realizando TDD na camada de apresentação.

 *Para relembrar o flow da criação dos testes :*
 
 #### 1º - Describes
 Descrever o comportamento da camada de apresentação
 
 #### 2º - Implementar
 Adicionar 
```Swift 
it("então ...") {
    expect(camada.variavelObservada) == valor_esperado
}
```
  Vai quebrar tudo! Após isto, é só atender o que está acusando ao não buildar.
  A cada vez que é atendido, nascerá um novo erro de build, até o momento que o build seja
  succeeded e seja possível fazer o teste passar.
 
 #### 3º - Make it green!
 
 Para fazer passar, deve-se criar os Spy's. Eles apenas implementam a interface de cada camada (```view```, ```router```, ```service```) acessada pelos delegates. 
 
 O Spy é sempre da camada de fora, a camada que está sendo testada (neste caso, Presenter), utiliza-se a classe concreta. 
 
 Quando houver a implementação dos testes do service por exemplo, a camada concreta será a do service e haverá um spy do Output que no caso é o Presenter (que implementa ```LoginServiceOutput```, logo existiria no teste do service um LoginServiceOutputSpy).
 
 ###### Enjoy testing
