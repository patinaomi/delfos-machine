
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
Avaliação 
Preco_Medio 
```

**Consulta** (Ato do cliente agendar) 
```bash
  ID_Consulta (chave primária) 
  ID_Cliente (chave estrangeira) 
  ID_Clínica (chave estrangeira) 
  dentista_id (ID do dentista responsável) 
  Tipo_Serviço 
  data_consulta (Data da consulta) 
  hora_consulta (Hora da consulta) 
  tipo_consulta (Tipo de consulta: preventiva, tratamento, emergência) 
  local_consulta (Local da consulta) 
  status_consulta (Status da consulta: agendada, realizada, cancelada) 
  observacoes (Observações sobre a consulta) 
  sintomas (Sintomas apresentados pelo usuário) 
  tratamento_recomendado (Tratamento recomendado após a consulta) 
  custo (Custo da consulta) 
  forma_pagamento (Forma de pagamento: cartão, dinheiro, convênio) 
  prescricao (Prescrição dada após a consulta) 
  data_retorno (Data para retorno, se aplicável) 
```

**Sinistro** (Tratativa do processo interno) 
```bash
  ID_Sinistro (chave primária) 
  Nome 
  Descricao
  status_sinistro (Status do sinistro: pendente, aprovado, negado) 
  Descricao_status (Se negado por exemplo, precisa mostrar o motivo) 
  valor_sinistro (Valor do sinistro) 
  Data_abertura 
  data_resolucao (Data de resolução do sinistro) 
  documentacao (Se necessario) 
```

**Feedback** – Precisamos pensar que um precisa para médico, outra para consulta, consultório e App. 
```bash
  ID_Feedback (chave primária) 
  ID_Cliente (chave estrangeira) 
  ID_Clínica (chave estrangeira) 
  Avaliação 
  Comentário 
```

**Formulário Detalhado**
```bash
  formulario_id (chave primária) 
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
  ID_Agenda (chave primária) 
  ID_Cliente (chave estrangeira) 
  ID_Consulta (chave estrangeira) 
  Data_Consulta 
  Hora_Consulta 
  Status_Consulta 
  Observacoes 
```

**Notificacoes**
```bash
ID_Notificacao (chave primária) 
ID_Cliente (chave estrangeira) 
Tipo_Notificacao 
Mensagem 
Data_Envio 
Status_Notificacao 
```

