# MarvelCharacters

Aplicação iOS que consome dados da API da Marvel, apresentando dos personagens com seus respectivos quadrinhos e séries.

## Passo a passo de como rodar o projeto

Uma vez que clonar o repositório, basta executar o comando do Cocoapods para instalar os pods (dependências).

Abra o terminal e use o seguinte comando para instalar as dependências:

```
cd [path_da_aplicação]/MarvelCharacters/
pod install
```

## Passo a passo de como testar a aplicação

Para rodar os testes da aplicação serár necessário executá-los diretamente pelo xcode. Ainda não foi configurado nenhum tipo de automatização. Posteriormente pode ser configurado o fastlane para facilitar a execução dos mesmos. 


## Arquitetura

Foi utilizado a arquitetura VIPER. Sendo o VIPER uma forma de usar a Clean Architecture, ele sugere como fazer as interações entre as camadas propostas por Uncle Bob.

VIPER é um acronimo formado pelas seguintes palavras
View — Telas
Interactor — Regras de negócio à nível de aplicação
Presenter — Transformam dados para serem apresentados ou encaminhados para o interactor.
Entity — Value objects ou lógicas reaproveitáveis
Router — Cuida do fluxo de telas

### Frameworks
	
- pod 'Alamofire'
- pod 'AlamofireImage'

## Conclusão

Durante uma semana de desenvolvimento, foi possível aplicar todo o conceito da arquitetura VIPER. Foi possível observar que o tempo de desenvolvimento aumenta consideravelmente se comparado ao método MVC convencional, porém, em contra partida, a grande separação de responsabilidades nos dá maior possibilidade de testes unitários, o que no médio e longo prazo acaba suprindo o tempo superior investido no desenvolvimento.

Durante os testes finais encontrei alguns pontos de melhoria e ajustes necessários, farei o cadastro dos mesmos nas issues para que fique registrado e possamos acompanhar a resolução dos mesmos.


