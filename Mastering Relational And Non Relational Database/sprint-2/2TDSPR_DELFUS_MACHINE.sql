-- Deletar tabelas caso já existam
DROP TABLE T_Rotina_Cuidado CASCADE CONSTRAINTS;
DROP TABLE T_Login CASCADE CONSTRAINTS;
DROP TABLE T_Usuario CASCADE CONSTRAINTS;
DROP TABLE T_Preferencia_Atendimento CASCADE CONSTRAINTS;
DROP TABLE T_Tipo_Atendimento CASCADE CONSTRAINTS;
DROP TABLE T_Perfil CASCADE CONSTRAINTS;
DROP TABLE T_Endereco_Preferencia CASCADE CONSTRAINTS;
DROP TABLE T_Cadastro_Medico CASCADE CONSTRAINTS;
DROP TABLE T_Especialidade CASCADE CONSTRAINTS;
DROP TABLE T_Cadastro_Clinica CASCADE CONSTRAINTS;
DROP TABLE T_Horario CASCADE CONSTRAINTS;
DROP TABLE T_Dia_Semana CASCADE CONSTRAINTS;
DROP TABLE T_Cadastro_Cliente CASCADE CONSTRAINTS;
DROP TABLE T_Endereco_Cadastro CASCADE CONSTRAINTS;
DROP TABLE T_Estado CASCADE CONSTRAINTS;
DROP TABLE T_Genero CASCADE CONSTRAINTS;
DROP TABLE T_Recompensa CASCADE CONSTRAINTS;
DROP TABLE T_Medico_Sugerido CASCADE CONSTRAINTS;
DROP TABLE T_Agendamento CASCADE CONSTRAINTS;
DROP TABLE T_Status CASCADE CONSTRAINTS;
DROP TABLE T_Notificacao CASCADE CONSTRAINTS;
DROP TABLE T_Consulta CASCADE CONSTRAINTS;
DROP TABLE T_Tarefa CASCADE CONSTRAINTS;
DROP TABLE T_Programa_Beneficio CASCADE CONSTRAINTS;
DROP TABLE Reagendamento CASCADE CONSTRAINTS;
DROP TABLE T_Recusa CASCADE CONSTRAINTS;
DROP TABLE T_Cancelamento CASCADE CONSTRAINTS;
DROP TABLE T_Historico_Avaliacao CASCADE CONSTRAINTS;
DROP TABLE T_Pesquisa CASCADE CONSTRAINTS;

-- Criação das tabelas

-- 1. Tabela de Gênero
CREATE TABLE T_Genero (
    id_gen INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_gen VARCHAR2(50) NOT NULL
);

-- 2. Tabela de Estado
CREATE TABLE T_Estado (
    id_est INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sigla_est VARCHAR2(2) NOT NULL
);

-- 3. Tabela de Dia da Semana
CREATE TABLE T_Dia_Semana (
    id_dia_semana INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_dia_semana VARCHAR2(50) NOT NULL
);

-- 4. Tabela de Turno de Atendimento
CREATE TABLE T_Turno_Atendimento (
    id_turno_atend INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_turno_atend VARCHAR2(50) NOT NULL -- manhã, tarde, noite
);

-- 5. Tabela de Tipo de Atendimento
CREATE TABLE T_Tipo_Atendimento (
    id_tipo_atendimento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_tipo_atendimento VARCHAR2(50) NOT NULL -- presencial, remoto
);

-- 6. Tabela de Sistema de Recompensas
CREATE TABLE T_Recompensa (
    id_recompensa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pts_acumulados INTEGER NOT NULL,
    desc_recompensa VARCHAR2(255) NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL
);

-- 7. Tabela de Endereço Preferência
CREATE TABLE T_Endereco_Preferencia (
    id_end_pref INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_cadastro TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP,
    cep VARCHAR2(10) NOT NULL,
    numero VARCHAR2(10) NOT NULL,
    rua VARCHAR2(255) NOT NULL,
    bairro VARCHAR2(100) NOT NULL,
    complemento VARCHAR2(255),
    cidade VARCHAR2(100) NOT NULL,
    id_cliente_fk INTEGER NOT NULL,
    id_estado_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_preferencia FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_estado_preferencia FOREIGN KEY (id_estado_fk) REFERENCES T_Estado(id_est)
);

-- 8. Tabela de Especialidade
CREATE TABLE T_Especialidade (
    id_esp INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_esp VARCHAR2(100) NOT NULL
);

-- 9. Tabela de Preferência de Atendimento
CREATE TABLE T_Preferencia_Atendimento (
    id_pref_atend INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_dia_semana_fk INTEGER,
    id_turno_atend_fk INTEGER,
    id_tipo_atend_fk INTEGER,
    id_cliente_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_preferencia_atendimento FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_turno_atendimento FOREIGN KEY (id_turno_atend_fk) REFERENCES T_Turno_Atendimento(id_turno_atend),
    CONSTRAINT fk_tipo_atendimento FOREIGN KEY (id_tipo_atend_fk) REFERENCES T_Tipo_Atendimento(id_tipo_atendimento),
    CONSTRAINT fk_dia_semana_atendimento FOREIGN KEY (id_dia_semana_fk) REFERENCES T_Dia_Semana(id_dia_semana)
);

-- 10. Tabela de Cliente
CREATE TABLE T_Cliente (
    id_clie INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL, 
    sobrenome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, 
    cpf VARCHAR2(20) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL, 
    data_criacao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP,
    id_endereco_fk INTEGER NOT NULL, 
    id_genero_fk INTEGER NOT NULL,
    id_recompensa_fk INTEGER NOT NULL,
    id_pref_atend_fk INTEGER NOT NULL,
    CONSTRAINT fk_endereco FOREIGN KEY (id_endereco_fk) REFERENCES T_Endereco_Preferencia(id_end_pref),
    CONSTRAINT fk_genero FOREIGN KEY (id_genero_fk) REFERENCES T_Genero(id_gen),
    CONSTRAINT fk_recompensa FOREIGN KEY (id_recompensa_fk) REFERENCES T_Recompensa(id_recompensa),
    CONSTRAINT fk_pref_atendimento FOREIGN KEY (id_pref_atend_fk) REFERENCES T_Preferencia_Atendimento(id_pref_atend)
);

-- 11. Tabela de Clínica
CREATE TABLE T_Clinica (
    id_clinica INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    telefone VARCHAR2(35) NOT NULL,
    cnpj VARCHAR2(20) NOT NULL,
    data_criacao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP,
    id_endereco_fk INTEGER NOT NULL,
    CONSTRAINT fk_endereco_clinica FOREIGN KEY (id_endereco_fk) REFERENCES T_Endereco_Preferencia(id_end_pref)
);

-- 12. Tabela de Médico
CREATE TABLE T_Medico (
    id_med INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    data_criacao TIMESTAMP NOT NULL,
    data_atualizacao TIMESTAMP,
    id_clinica_fk INTEGER,
    id_especialidade_fk INTEGER NOT NULL,
    id_genero_fk INTEGER NOT NULL,
    CONSTRAINT fk_clinica_medico FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_especialidade_medico FOREIGN KEY (id_especialidade_fk) REFERENCES T_Especialidade(id_esp),
    CONSTRAINT fk_genero_medico FOREIGN KEY (id_genero_fk) REFERENCES T_Genero(id_gen)
);

-- 13. Tabela de Login
CREATE TABLE T_Login (
    id_login INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_login TIMESTAMP NOT NULL,
    tipo_login VARCHAR2(1) NOT NULL, -- 0 ou 1 (booleano)
    id_usuario_fk INTEGER NOT NULL,
    CONSTRAINT fk_usuario_login FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_user)
);

-- 14. Tabela de Rotina de Cuidados
CREATE TABLE T_Rotina_Cuidado (
    id_rotina_cuidados INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    frequencia_escovacao VARCHAR2(50) NOT NULL,
    frequencia_fio_dental VARCHAR2(50) NOT NULL,
    frequencia_enxaguante VARCHAR2(50) NOT NULL,
    limpeza_profissional VARCHAR2(50) NOT NULL, -- 3 meses, 6 meses, 1 vez ao ano
    id_cliente_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_rotina_cuidado FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie)
);

-- 15. Tabela de Status
CREATE TABLE T_Status (
    id_status INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    desc_status VARCHAR2(50) NOT NULL -- pendente, aceito, recusado, etc.
);

-- 16. Tabela de Médico Sugerido
CREATE TABLE T_Medico_Sugerido (
    id_sugestao INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_consulta TIMESTAMP NOT NULL,
    data_envio TIMESTAMP NOT NULL,
    data_alteracao TIMESTAMP NOT NULL,
    id_status_fk INTEGER NOT NULL,
    id_cliente_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_sugestao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_sugestao FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_status_sugestao FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 17. Tabela de Agendamento
CREATE TABLE T_Agendamento (
    id_agendamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_sugerida TIMESTAMP NOT NULL,
    data_resposta TIMESTAMP,
    id_cliente_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    id_clinica_fk INTEGER NOT NULL,
    id_status_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_agendamento FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_agendamento FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_clinica_agendamento FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_status_agendamento FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 18. Tabela de Notificações
CREATE TABLE T_Notificacao (
    id_notificacao INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_envio TIMESTAMP NOT NULL,
    id_cliente_fk INTEGER NOT NULL,
    id_status_fk INTEGER NOT NULL,
    id_tipo_notificacao_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_notificacao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_status_notificacao FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 19. Tabela de Consulta
CREATE TABLE T_Consulta (
    id_consulta INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_consulta TIMESTAMP NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    status NUMBER(1) NOT NULL, -- 0 ou 1
    id_cliente_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_consulta FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_consulta FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med)
);

-- 20. Tabela de Tarefas
CREATE TABLE T_Tarefa (
    id_tarefa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descricao VARCHAR2(255) NOT NULL,
    pontuacao NUMBER(5) NOT NULL
);

-- 21. Tabela de Programa de Benefício
CREATE TABLE T_Programa_Beneficio (
    id_beneficio INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,
    condicao_aplicacao VARCHAR2(255) NOT NULL,
    status_beneficio NUMBER(1) NOT NULL, -- 0 ou 1
    id_tarefa_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    CONSTRAINT fk_tarefa_beneficio FOREIGN KEY (id_tarefa_fk) REFERENCES T_Tarefa(id_tarefa),
    CONSTRAINT fk_medico_beneficio FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med)
);

-- 22. Tabela de Reagendamento
CREATE TABLE Reagendamento (
    id_reagendamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_agendamento INTEGER NOT NULL,
    data_anterior TIMESTAMP NOT NULL,
    horario_anterior VARCHAR2(50) NOT NULL,
    nova_data TIMESTAMP NOT NULL,
    novo_horario VARCHAR2(50) NOT NULL,
    id_status_fk INTEGER NOT NULL,
    data_criacao TIMESTAMP NOT NULL,
    id_clinica_fk INTEGER NOT NULL,
    id_cliente_fk INTEGER NOT NULL,
    CONSTRAINT fk_agendamento_reagendamento FOREIGN KEY (id_agendamento) REFERENCES T_Agendamento(id_agendamento),
    CONSTRAINT fk_status_reagendamento FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status),
    CONSTRAINT fk_clinica_reagendamento FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_cliente_reagendamento FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie)
);

-- 23. Tabela de Recusa
CREATE TABLE T_Recusa (
    id_recusa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_agendamento INTEGER NOT NULL,
    motivo_recusa VARCHAR2(255) NOT NULL,
    data_recusa TIMESTAMP NOT NULL,
    CONSTRAINT fk_agendamento_recusa FOREIGN KEY (id_agendamento) REFERENCES T_Agendamento(id_agendamento)
);

-- 24. Tabela de Cancelamento de Consulta
CREATE TABLE T_Cancelamento (
    id_cancelamento INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_agendamento INTEGER NOT NULL,
    id_status_fk INTEGER NOT NULL,
    id_pessoa_solicitante VARCHAR2(50) NOT NULL, -- clinica, médico ou cliente
    desc_motivo_solicitacao VARCHAR2(255) NOT NULL, -- motivo do cancelamento
    data_cancelamento TIMESTAMP NOT NULL,
    CONSTRAINT fk_agendamento_cancelamento FOREIGN KEY (id_agendamento) REFERENCES T_Agendamento(id_agendamento),
    CONSTRAINT fk_status_cancelamento FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 25. Tabela de Histórico de Avaliações
CREATE TABLE T_Historico_Avaliacao (
    id_avaliacao INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    nota_medico INTEGER NOT NULL,
    id_clinica_fk INTEGER NOT NULL,
    nota_clinica INTEGER NOT NULL,
    media_nota DECIMAL(3, 2) NOT NULL,
    CONSTRAINT fk_cliente_avaliacao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_avaliacao FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_clinica_avaliacao FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica)
);

-- 26. Tabela de Pesquisa de Satisfação
CREATE TABLE T_Pesquisa (
    id_pesquisa INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_consulta_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    nota_medico INTEGER NOT NULL,
    id_clinica_fk INTEGER NOT NULL,
    nota_clinica INTEGER NOT NULL, -- 0 a 5
    comentarios VARCHAR2(500),
    data_pesquisa TIMESTAMP NOT NULL,
    CONSTRAINT fk_cliente_pesquisa FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_consulta_pesquisa FOREIGN KEY (id_consulta_fk) REFERENCES T_Consulta(id_consulta),
    CONSTRAINT fk_medico_pesquisa FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_clinica_pesquisa FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica)
);
