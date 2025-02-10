# Lista de Tarefas - Flutter

Este projeto é uma aplicação Flutter que gerencia uma lista de tarefas, consultando um servidor ASP .NET Core Web API. A aplicação permite adicionar, editar, remover e visualizar tarefas.

## Estrutura do Projeto

O projeto está organizado seguindo a estrutura de camadas, separando as responsabilidades em diferentes pastas:

- **lib/core**: Contém configurações e utilitários comuns.
- **lib/data**: Lida com a obtenção e manipulação de dados, incluindo fontes de dados remotas e locais.
- **lib/domain**: Contém as entidades e interfaces de repositório.
- **lib/presentation**: Gerencia a interface do usuário e a lógica de apresentação.
- **lib/services**: Contém os serviços para operações CRUD.
- **test**: Contém testes unitários, de widget e snapshot.

## Pacotes Utilizados

- **equatable**: ^2.0.7 - Para comparar objetos de forma mais eficiente.
- **http**: ^1.3.0 - Para fazer requisições HTTP.
- **provider**: ^6.1.2 - Para gerenciamento de estado.
- **intl**: ^0.20.2 - Para internacionalização e formatação de datas.
- **dartz**: ^0.10.1 - Para programação funcional e tratamento de erros.

### Pacotes para Testes

- **mockito**: ^5.4.5 - Para criar mocks em testes.
- **build_runner**: ^2.4.14 - Para gerar código automaticamente.
- **coverage**: ^1.11.1 - Para análise de cobertura de testes.

## Testes

O projeto inclui exemplos de testes unitários, de widget e snapshot para garantir a qualidade do código.

### Testes Unitários

Os testes unitários estão localizados na pasta `test/domain` e `test/presentation/view`.

### Testes de Widget

Os testes de widget verificam a interface do usuário e estão localizados na pasta `test/presentation/view`.

### Testes Snapshot

Os testes snapshot são usados para garantir que a UI não mude inadvertidamente. Eles estão localizados na pasta `test/presentation/view/golden`.

## Como Executar

1. Clone o repositório.
2. Execute `flutter pub get` para instalar as dependências.
3. Execute `flutter run` para iniciar a aplicação.

## Como Executar os Testes

1. Para rodar todos os testes, execute `flutter test`.
2. Para gerar um relatório de cobertura, execute `flutter test --coverage` e então `genhtml coverage/lcov.info -o coverage/html`.