
# Projeto

# Nossa solução

## Prevenir é CUIDAR: Cliente SEGURO, Parceiro RENTÁVEL.

Essa frase reflete o foco na prevenção para garantir a saúde do cliente, ao mesmo tempo em que destaca o impacto 
positivo nos parceiros (clínicas), trazendo mais eficiência e redução de custos. cliente na rua, é um cliente seguro e com saúde.
Falamos na rua, pois queremos atender 100% da carteira de cliente, para que todos façam consultas preventivas, evitando e previnindo 
consultas emegências, que podem acarretar altos custos.

## Objetivo

Nosso objetivo é reduzir os altos custos de sinistros, sem evitar consultas, mas sim prevenindo consultas de valores elevados e fora do comum. 
Ao incentivar consultas preventivas, economizaremos recursos e diminuiremos a necessidade de atendimentos emergenciais.
Nosso modelo vai sugerir consultas ao cliente com base em suas preferências de atendimento, como local, data, horário, 
com especialistas que possuem qualidade acima de nota 4 e com custos baixos. Iremos treinar a IA para procurar o cliente primeiro, 
ao invés de esperar que ele nos procure com problemas maiores.

Por exemplo, se uma pessoa realiza limpezas e radiografias ósseas a cada 5 ou 6 meses, pode evitar extrações devido a cuidados bucais 
inadequados, que podem custar cerca de dois mil reais. Em nosso cenário, esse valor é extremamente alto. É mais vantajoso cobrir uma consulta de 200 reais, que representa apenas 10% do custo de um procedimento emergencial.
Além disso, vamos atender as clínicas e parceiros, levando mais clientes e aumentando sua carteira.

## Etapas do projeto

Será necessário implementar seis fases no nosso projeto, para que possamos atender a demanda da OdontoPrev

**Coletar Dados do Cliente**
Utilizar o formulário de cadastro para coletar informações como localização preferida pelo cliente, avaliações de satisfação das clinicas e médicos, além dos valores de consultas com preco acessível. Na solução apresentada, se tiver qualidade, mostra que mesmo com custo baixo, a consulta pode atender a necessidade do cliente.

***O que será feito - Oracle***
Essas informações já estão no banco de dados, para coletar elas, usaremos a bilioteca do Oracle para conectar no banco e criar um dataframe.

```bash
  import pandas as pd
  import oracledb
  
  # Minhas credenciais
  credencial_banco = {
      'dsn': 'oracle.fiap.com.br:1521/orcl',
      'usuario': 'rm553472',
      'senha': ''
  }
```

***O que será feito - Pandas***
Processar Dados com Pandas: Utilizar a biblioteca Pandas para organizar e analisar os dados dos clientes.




***O que será feito - Pandas***
Treinar Modelo com PyTorch: Utilizar PyTorch para treinar um modelo de IA que sugira consultas preventivas com base nos dados do cliente.
Classificação com Scikit-Learn: Utilizar Scikit-Learn para classificar as clínicas e especialistas com base nas avaliações de satisfação.
Visualização com Matplotlib: Utilizar Matplotlib para criar gráficos que mostrem os custos e economias das consultas sugeridas.
API com Flask: Criar uma API com Flask para fornecer as sugestões de consultas ao aplicativo.
