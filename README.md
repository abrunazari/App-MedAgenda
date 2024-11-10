# App MedAgenda - App de Agendamento para Consultas Médicas

Este é um aplicativo de agendamento de consultas médicas, com funcionalidades voltadas para facilitar o processo de marcação de consultas entre pacientes e profissionais de saúde. Foi desenvolvido para dispositivos mobile.

## Requisitos

- **Flutter**: Flutter 3.16.8
- **SDK do Android**: targetSdkVersion — 33
- **SDK do Flutter Environment** '>=3.2.5 <4.0.0'

## Comandos Principais

Para configurar e rodar o projeto, utilize os comandos:

```bash
# Instalar dependências
flutter pub get

# Rodar o app
flutter run
```

## Estrutura de Pastas

O projeto está organizado com base na arquitetura Clean Architecture, seguindo uma divisão clara entre camadas para facilitar a manutenção e escalabilidade.

### Glossário de Componentes

- **UI (Interface de Usuário)**: Contém a estrutura visual do aplicativo e as interações do usuário. Essa camada é dividida em:

  - **Views**: Arquivos responsáveis por renderizar as telas e seus componentes. Cada view é focada em uma função específica, como exibir as informações de uma consulta.
  - **Controllers**: Usados para gerenciar o estado da interface e a lógica de interação com o usuário. Utilizamos GetX para injetar esses controllers nas views, aplicando o princípio de responsabilidade única para manter a UI organizada e modular.

- **Domain (Lógica de Negócios)**: Implementa a lógica central do sistema, independente da interface e da camada de dados. Inclui:

  - **UseCases**: Cada tarefa específica, como criar ou editar uma consulta, é implementada em uma classe de caso de uso. Um _UseCase_ define a lógica de negócio e interage com os repositórios da camada de dados.
  - **Entidades**: Representações de objetos do domínio, como uma consulta ou um profissional de saúde, contendo apenas as propriedades essenciais e regras de negócio.
  - **Repositórios**: No Domain, os repositórios são contratos que definem métodos e operações essenciais, mas sem implementação direta.

- **Data (Camada de Dados)**: Responsável por acessar e manipular os dados através de repositórios e conectar-se com APIs externas ou bancos de dados. Inclui:

  - **Repositórios**: Interfaces que definem métodos para acessar dados. A implementação desses repositórios está separada para permitir mudanças na fonte de dados (por exemplo, de uma API REST para GraphQL) sem afetar o restante da aplicação.
  - **DataSource**: Implementa as chamadas reais à API e outras interações com dados externos. Esse componente é a principal conexão com o backend, gerando uma camada de abstração para garantir que os _UseCases_ e a UI não sejam afetados por mudanças frequentes na estrutura dos dados.

- **Bindings**: No GetX, as bindings garantem que as dependências, como controllers e serviços, sejam injetadas automaticamente antes de uma página ser exibida. Esse processo facilita a injeção de dependências e promove a escalabilidade do código.
