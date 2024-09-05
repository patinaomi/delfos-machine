
# Modelo Conceitual e Documentação 

## Entidades e Atributos 

**Cliente**
```bash
  ID_Cliente (chave primária) 
  Nome 
  Email 
  Telefone 
  Data_Nascimento 
  Endereço 
```
 
**Clinica**
```bash
ID_Clinica (chave primária) 
Nome 
Endereço 
Telefone 
Avaliacao
Preco_Medio 
```

**Consulta** (Ato do cliente agendar) 
```bash
  ID_Consulta (chave primária) 
  ID_Cliente (chave estrangeira) 
  ID_Clínica (chave estrangeira) 
  dentista_id (ID do dentista responsavel) 
  Tipo_Servico 
  data_consulta (Data da consulta) 
  hora_consulta (Hora da consulta) 
  tipo_consulta (Tipo de consulta: preventiva, tratamento, emergencia) 
  local_consulta (Local da consulta) 
  status_consulta (Status da consulta: agendada, realizada, cancelada) 
  observacoes (Observações sobre a consulta) 
  sintomas (Sintomas apresentados pelo usuario) 
  tratamento_recomendado (Tratamento recomendado apos a consulta) 
  custo (Custo da consulta) 
  forma_pagamento (Forma de pagamento: cartao, dinheiro, convenio) 
  prescricao (Prescrição dada apos a consulta) 
  data_retorno (Data para retorno, se aplicavel) 
```

**Sinistro** (Tratativa do processo interno) 
```bash
  ID_Sinistro (chave primaria) 
  Nome 
  Descricao
  status_sinistro (Status do sinistro: pendente, aprovado, negado) 
  Descricao_status (Se negado por exemplo, precisa mostrar o motivo) 
  valor_sinistro (Valor do sinistro) 
  Data_abertura 
  data_resolucao (Data de resolução do sinistro) 
  documentacao (Se necessario) 
```

**Feedback** – Precisamos pensar que um precisa para medico, outra para consulta, consultorio e App. 
```bash
  ID_Feedback (chave primaria) 
  ID_Cliente (chave estrangeira) 
  ID_Clínica (chave estrangeira) 
  Avaliacao 
  Comentario 
```

**Formulário Detalhado**
```bash
  formulario_id (chave primaria) 
  usuario_id (chave estrangeira) 
  historico_familiar 
  plano_odontologico 
  estado_civil 
  profissao 
  renda_mensal 
  tempo_residencia 
  historico_medico 
  alergias 
  condicoes_preexistentes 
  uso_medicamentos 
  familiar_com_doencas_dentarias 
  participacao_em_programas_preventivos 
  historico_de_fraude – aqui podemos avaliar por exemplo processos judiciais que tem API na internet 
  contatos_emergenciais 
  historico_de_reclamacoes 
  participacao_em_pesquisas 
  data_ultima_atualizacao 
  frequencia_consultas_periodicas 
  sinalizacao_de_risco 
  data_de_nascimento_mae 
  data_de_nascimento_pai 
  horario_preferencia_atendimento 
  Dia_semana_preferencia 
  Preferencia_consulta (presencial ou remota) 
  data_inicio_plano 
  data_fim_plano 
  atividade_fisica (sim ou não) 
```

**Agenda**
```bash
  ID_Agenda (chave primaria) 
  ID_Cliente (chave estrangeira) 
  ID_Consulta (chave estrangeira) 
  Data_Consulta 
  Hora_Consulta 
  Status_Consulta 
  Observacoes 
```

**Notificacoes**
```bash
ID_Notificacao (chave primaria) 
ID_Cliente (chave estrangeira) 
Tipo_Notificacao 
Mensagem 
Data_Envio 
Status_Notificacao 
```

# Relacionamentos 

**Cliente e Consulta**
```bash
Tipo: 1:N (Um cliente pode ter várias consultas) 
**Descrição:** Cada cliente pode agendar múltiplas consultas ao longo do tempo. 
```

**Clínica e Consulta**
```bash
Tipo: 1:N (Uma clínica pode ter várias consultas) 
**Descrição:** Cada clínica pode atender a vários clientes em diferentes consultas. 
```

**Consulta e Sinistro**
```bash
Tipo: N:1 (Várias consultas podem estar associadas a um sinistro) 
**Descrição:** Uma consulta pode gerar um sinistro (por exemplo, quando um tratamento é necessário), mas cada sinistro está associado a uma única consulta. 
```

**Cliente e Feedback**
```bash
Tipo: 1:N (Um cliente pode deixar vários feedbacks) 
**Descrição:** Cada cliente pode fornecer feedback sobre diversas clínicas, consultas e até mesmo sobre o aplicativo. 
```

**Clínica e Feedback**
```bash
Tipo: 1:N (Uma clínica pode receber vários feedbacks) 
**Descrição:** Cada clínica pode receber feedback de vários clientes. 
```

**Formulário Detalhado e Usuário**
```bash
Tipo: 1:1 (Um formulário detalhado é associado a um único usuário) 
**Descrição:** Cada usuário tem um formulário personalizado que coleta informações detalhadas sobre sua saúde e histórico. 
```

**Agenda e Cliente**
```bash
Tipo: N:1 (Muitos agendamentos podem estar associados a um único cliente) 
**Descrição:** Cada agendamento é relacionado a um cliente específico, que pode ter vários agendamentos. 
```

**Agenda e Consulta**
```bash
Tipo: N:1 (Muitos agendamentos podem estar associados a uma única consulta) 
**Descrição:** Cada agendamento está vinculado a uma consulta específica, mas uma consulta pode ser referenciada em diferentes agendamentos (como retornos). 
```

**Notificacoes e Cliente**
```bash
Tipo: N:1 (Muitas notificações podem estar associadas a um único cliente) 
**Descrição:** Cada notificação é enviada a um cliente específico, que pode receber várias notificações. 
```

## Resumo dos Relacionamentos 

Cliente (1) — (N) Consulta – JAVA ONETOMANY 
Clínica (1) — (N) Consulta ONETOMANY 
Consulta (N) — (1) Sinistro MANYTOONE 
Cliente (1) — (N) Feedback ONETOMANY 
Clínica (1) — (N) Feedback ONETOMANY 
Usuário (1) — (1) Formulário Detalhado ONETOONE 
Agenda (N) — (1) Cliente MANYTOONE
Agenda (N) — (1) Consulta MANYTOONE
Notificacoes (N) — (1) Cliente MANYTOONE

 
 

 

 

