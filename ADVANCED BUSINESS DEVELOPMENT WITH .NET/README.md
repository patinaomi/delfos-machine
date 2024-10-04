# Projeto Backend Challenge Odontoprev

## Visão Geral

Este projeto é uma API para gerenciamento de  clientes, clínicas, consultas, feedback e outros recursos relacionados a um sistema odontológico. A API é construída usando ASP.NET Core e MongoDB para armazenamento de dados.

## Nosso objetivo
Desenvolver uma aplicação móvel, gerenciada em Java, e uma aplicação web, gerenciada em ASP.NET, com o objetivo de sugerir consultas para novos e antigos clientes utilizando inteligência artificial (IA). As sugestões de consultas serão baseadas na localidade preferida do cliente, nas avaliações de feedback das clínicas/especialistas e nos custos mais baixos. Com essa combinação, os clientes poderão realizar suas consultas de rotina de forma contínua, promovendo um ciclo de alta qualidade. Ao mesmo tempo, as clínicas e especialistas manterão um fluxo constante de clientes em suas carteiras.

# Link com vídeo do prótotipo da nossa aplicação

1. Será interessante para você entender melhor nossa aplicação, iniciando pelo Mobile.
2. Logo iremos criar o prótotipo da nossa aplicação na web. Será enviada na segunda sprint.

## Tecnologias Utilizadas
- ASP.NET Core
- MongoDB, não vamos usar o Oracle ainda, pois não é necessário.
- C#
- React para aplicação front-end

## Estrutura do Diretório

Nosso projeto será gerenciada com base nas interfaces, mantendo a regra do clean code.


## Descrição das Classes e Interfaces

### Models

- **Agenda**: Representa uma agenda de consultas.
- **Cadastro**: Representa o cadastro completo de um usuário.
- **Cliente**: Contém informações chave do cliente. Vai ser isolada de cadastro, pois com essa classe, vamos fazer as autenticações e que será responsável por mostrar os dados dos clientes. Difente do Cadastro que só tem o objetivo de trazer informações do formulário de cadastro. Separamos as responsábilidades para uma melgor gestão da nossa aplicação.
- **Clinica**: Representa uma clínica odontológica.
- **Consulta**: Representa uma consulta odontológica.
- **Dentista**: Representa um dentista.
- **EstadoCivil**: Representa o estado civil de um cliente.
- **Feedback**: Representa o feedback de um cliente para clinica, dentista e consulta.
- **FormularioDetalhado**: Contém informações detalhadas do cliente que vai nos auxuliar a treinar o modelo da IA. Aqui será diferente de cadastro pois lá no cadastrado teremos informações básicas para trazer o cliente para nossa empresa e este formulário para alimentar nosso modelo de inteligência.
- **Notificacoes**: Representa notificações enviadas aos clientes para avisar sobre as consultas que foram programadas, das pesquisas que ele precisa preencher e avisos gerais.
- **Sinistro**: Representa um sinistro relacionado a uma consulta. Diferente da consulta, aqui trata do processo de análise pela seguradora.
- **TipoNotificacao**: Representa os tipos de notificações.
- **UserDatabaseSettings**: Contém as configurações do banco de dados.

### Services

- **AgendaService**: Gerencia operações CRUD para `Agenda`.
- **CadastroService**: Gerencia operações CRUD para `Cadastro`.
- **ClienteService**: Gerencia operações CRUD para `Cliente`.
- **ClinicaService**: Gerencia operações CRUD para `Clinica`.
- **ConsultaService**: Gerencia operações CRUD para `Consulta`.
- **DentistaService**: Gerencia operações CRUD para `Dentista`.
- **EstadoCivilService**: Gerencia operações CRUD para `EstadoCivil`.
- **FeedbackService**: Gerencia operações CRUD para `Feedback`.
- **FormularioDetalhadoService**: Gerencia operações CRUD para `FormularioDetalhado`.
- **NotificacoesService**: Gerencia operações CRUD para `Notificacoes`.
- **SinistroService**: Gerencia operações CRUD para `Sinistro`.
- **TipoNotificacaoService**: Gerencia operações CRUD para `TipoNotificacao`.

### Interfaces

- **IAgendaService**: Define métodos para `AgendaService`.
- **ICadastroService**: Define métodos para `CadastroService`.
- **IClienteService**: Define métodos para `ClienteService`.
- **IClinicaService**: Define métodos para `ClinicaService`.
- **IConsultaService**: Define métodos para `ConsultaService`.
- **IDentistaService**: Define métodos para `DentistaService`.
- **IEstadoCivilService**: Define métodos para `EstadoCivilService`.
- **IFeedbackService**: Define métodos para `FeedbackService`.
- **IFormularioDetalhadoService**: Define métodos para `FormularioDetalhadoService`.
- **INotificacoesService**: Define métodos para `NotificacoesService`.
- **ISinistroService**: Define métodos para `SinistroService`.
- **ITipoNotificacaoService**: Define métodos para `TipoNotificacaoService`.

### Controllers

- **AgendaController**: Gerencia requisições HTTP para `Agenda`.
- **CadastroController**: Gerencia requisições HTTP para `Cadastro`.
- **ClienteController**: Gerencia requisições HTTP para `Cliente`.
- **ClinicaController**: Gerencia requisições HTTP para `Clinica`.
- **ConsultaController**: Gerencia requisições HTTP para `Consulta`.
- **DentistaController**: Gerencia requisições HTTP para `Dentista`.
- **EstadoCivilController**: Gerencia requisições HTTP para `EstadoCivil`.
- **FeedbackController**: Gerencia requisições HTTP para `Feedback`.
- **FormularioDetalhadoController**: Gerencia requisições HTTP para `FormularioDetalhado`.
- **NotificacoesController**: Gerencia requisições HTTP para `Notificacoes`.
- **SinistroController**: Gerencia requisições HTTP para `Sinistro`.
- **TipoNotificacaoController**: Gerencia requisições HTTP para `TipoNotificacao`.

## Configuração e Execução

### Pré-requisitos

- .NET SDK
- MongoDB

### Configuração

1. Clone o repositório:
   ```sh
   git clone https://github.com/seu-usuario/project-backend-challenge-odontoprev.git
   cd project-backend-challenge-odontoprev

## Execução

1. Restaure as dependências:
    $   dotnet restore

2. Compile e execute a aplicação:
    $   dotnet run

3. Acesse o Swagger UI para testar a API:
    $   http://localhost:3001/swagger

