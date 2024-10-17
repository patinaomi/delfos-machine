-- Nome dos Integrantes: 
-- Claudio Silva Bispo RM553472
-- Patricia Naomi Yamagishi RM552981

-- Deletar tabelas caso já existam
DROP TABLE T_Rotina_Cuidado CASCADE CONSTRAINTS;
DROP TABLE T_Login CASCADE CONSTRAINTS;
DROP TABLE T_Medico CASCADE CONSTRAINTS;
DROP TABLE T_Cliente CASCADE CONSTRAINTS;
DROP TABLE T_Clinica CASCADE CONSTRAINTS;
DROP TABLE T_Usuario CASCADE CONSTRAINTS;
DROP TABLE T_Usuario_Perfil CASCADE CONSTRAINTS;
DROP TABLE T_Preferencia_Atendimento CASCADE CONSTRAINTS;
DROP TABLE T_Tipo_Atendimento CASCADE CONSTRAINTS;
DROP TABLE T_Turno_Pref_Atendimento CASCADE CONSTRAINTS;
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
DROP TABLE T_Clinica_Sugerida CASCADE CONSTRAINTS;
DROP TABLE T_Agendamento CASCADE CONSTRAINTS;
DROP TABLE T_Status CASCADE CONSTRAINTS;
DROP TABLE T_Notificacao CASCADE CONSTRAINTS;
DROP TABLE T_Preferencia_Notificacao CASCADE CONSTRAINTS;
DROP TABLE T_Consulta CASCADE CONSTRAINTS;
DROP TABLE T_Parceria CASCADE CONSTRAINTS;
DROP TABLE T_Avaliacao CASCADE CONSTRAINTS;
DROP TABLE T_Pesquisa_Satisfacao CASCADE CONSTRAINTS;
DROP TABLE T_Tarefa CASCADE CONSTRAINTS;
DROP TABLE T_Programa_Beneficio CASCADE CONSTRAINTS;

-- Criação das tabelas

-- 1. Tabela de Gênero
CREATE TABLE T_Genero (
    id_gen INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_gen VARCHAR2(50) NOT NULL
);

-- 2. Tabela de Estado
CREATE TABLE T_Estado (
    id_est INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    sigla_est VARCHAR2(2) NOT NULL
);

-- 3. Tabela de Dia da Semana
CREATE TABLE T_Dia_Semana (
    id_dia_semana INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_dia_semana VARCHAR2(50) NOT NULL
);

-- 4. Tabela de Horário
CREATE TABLE T_Horario (
    id_hor INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_hor VARCHAR2(50) NOT NULL
);

-- 5. Tabela de Turno de Preferência de Atendimento
CREATE TABLE T_Turno_Pref_Atendimento (
    id_turno_pref_atendimento INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_turno_preferencia VARCHAR2(50) NOT NULL -- manhã, tarde, noite
);

-- 6. Tabela de Tipo de Atendimento
CREATE TABLE T_Tipo_Atendimento (
    id_tipo_atendimento INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_tipo_atendimento VARCHAR2(50) NOT NULL -- presencial, remoto
);

-- 7. Tabela de Perfil
CREATE TABLE T_Perfil (
    id_perfil INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_perfil VARCHAR2(50) NOT NULL -- cliente, administrador, clínico, secretaria, auxiliar, medico
);

-- 8. Tabela de Sistema de Recompensas
CREATE TABLE T_Recompensa (
    id_recompensa INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    pontos_acumulados INTEGER NOT NULL,
    descricao_recompensa VARCHAR2(255) NOT NULL,
    data_atualizacao TIMESTAMP NOT NULL
);

-- 9. Tabela de Cadastro de Endereço
CREATE TABLE T_Endereco_Cadastro (
    id_end INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    cep_end VARCHAR2(15) NOT NULL,
    num_end VARCHAR2(10) NOT NULL,
    rua_end VARCHAR2(255) NOT NULL,
    bairro_end VARCHAR2(100) NOT NULL,
    complemento_end VARCHAR2(255),
    cidade_end VARCHAR2(100) NOT NULL,
    id_estado_fk INTEGER NOT NULL,
    CONSTRAINT fk_estado_cliente FOREIGN KEY (id_estado_fk) REFERENCES T_Estado(id_est)
);

-- 10. Tabela de Cadastro do Cliente
CREATE TABLE T_Cadastro_Cliente (
    id_cad_clie INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_cad_clie VARCHAR2(100) NOT NULL,
    sobrenome_cad_clie VARCHAR2(100) NOT NULL,
    tel_cad_clie VARCHAR2(35) NOT NULL,
    email_cad_clie VARCHAR2(100) NOT NULL,
    cpf_cad_clie VARCHAR2(20) NOT NULL UNIQUE,
    data_nasc_cad_clie DATE NOT NULL,
    data_cad_clie TIMESTAMP NOT NULL,
    id_gen_fk INTEGER NOT NULL,
    id_end_cadastro_fk INTEGER NOT NULL,
    CONSTRAINT fk_genero FOREIGN KEY (id_gen_fk) REFERENCES T_Genero(id_gen),
    CONSTRAINT fk_endereco_cadastro FOREIGN KEY (id_end_cadastro_fk) REFERENCES T_Endereco_Cadastro(id_end)
);

-- 11. Tabela de Endereço Preferência
CREATE TABLE T_Endereco_Preferencia (
    id_end_pref INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    data_cadastro_end_pref TIMESTAMP NOT NULL,
    data_atualizacao_end_pref TIMESTAMP,
    cep_end_pref VARCHAR2(10) NOT NULL,
    num_end_pref VARCHAR2(10) NOT NULL,
    rua_end_pref VARCHAR2(255) NOT NULL,
    bairro_end_pref VARCHAR2(100) NOT NULL,
    complemento_end_pref VARCHAR2(255),
    cidade_end_pref VARCHAR2(100) NOT NULL,
    id_cliente_fk INTEGER NOT NULL,
    id_estado_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_preferencia FOREIGN KEY (id_cliente_fk) REFERENCES T_Cadastro_Cliente(id_cad_clie),
    CONSTRAINT fk_estado_preferencia FOREIGN KEY (id_estado_fk) REFERENCES T_Estado(id_est)
);

-- 12. Tabela de Especialidade
CREATE TABLE T_Especialidade (
    id_esp INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_esp VARCHAR2(100) NOT NULL
);

-- 13. Tabela de Cadastro da Clínica
CREATE TABLE T_Cadastro_Clinica (
    id_cad_cli INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_cad_cli VARCHAR2(100) NOT NULL,
    tel_cad_cli VARCHAR2(35) NOT NULL,
    cnpj_cad_cli VARCHAR2(30) NOT NULL UNIQUE,
    data_cad_cli TIMESTAMP NOT NULL,
    id_endereco_cadastro_fk INTEGER NOT NULL,
    CONSTRAINT fk_endereco_clinica FOREIGN KEY (id_endereco_cadastro_fk) REFERENCES T_Endereco_Cadastro(id_end)
);

-- 14. Tabela de Cadastro do Médico
CREATE TABLE T_Cadastro_Medico (
    id_cad_med INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_cad_med VARCHAR2(100) NOT NULL,
    data_criacao_cad_med TIMESTAMP NOT NULL,
    id_clinica_fk INTEGER,
    id_especialidade_fk INTEGER NOT NULL,
    id_gen_fk INTEGER NOT NULL,
    id_end_cadastrado_fk INTEGER NOT NULL,
    CONSTRAINT fk_clinica_medico FOREIGN KEY (id_clinica_fk) REFERENCES T_Cadastro_Clinica(id_cad_cli),
    CONSTRAINT fk_especialidade_medico FOREIGN KEY (id_especialidade_fk) REFERENCES T_Especialidade(id_esp),
    CONSTRAINT fk_genero_medico FOREIGN KEY (id_gen_fk) REFERENCES T_Genero(id_gen),
    CONSTRAINT fk_end_cadastrado_medico FOREIGN KEY (id_end_cadastrado_fk) REFERENCES T_Endereco_Cadastro(id_end)
);

-- 15. Tabela de Preferência de Atendimento
CREATE TABLE T_Preferencia_Atendimento (
    id_preferencia_atendimento INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_dia_semana_fk INTEGER,
    id_turno_preferencia_atendimento_fk INTEGER,
    id_tipo_atendimento_fk INTEGER,
    CONSTRAINT fk_cliente_preferencia_atendimento FOREIGN KEY (id_cliente_fk) REFERENCES T_Cadastro_Cliente(id_cad_clie),
    CONSTRAINT fk_turno_preferencia_atendimento FOREIGN KEY (id_turno_preferencia_atendimento_fk) REFERENCES T_Turno_Pref_Atendimento(id_turno_pref_atendimento),
    CONSTRAINT fk_tipo_atendimento FOREIGN KEY (id_tipo_atendimento_fk) REFERENCES T_Tipo_Atendimento(id_tipo_atendimento),
    CONSTRAINT fk_dia_preferencia_atendimento FOREIGN KEY (id_dia_semana_fk) REFERENCES T_Dia_Semana(id_dia_semana)
);

-- 16. Tabela de Usuário Perfil
CREATE TABLE T_Usuario_Perfil (
    id_usuario_perfil INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    disp_horario_fk INTEGER,
    disp_dia_semana_fk INTEGER,
    id_perfil_fk INTEGER,
    CONSTRAINT fk_perfil FOREIGN KEY (id_perfil_fk) REFERENCES T_Perfil(id_perfil),
    CONSTRAINT fk_horario_disponibilidade FOREIGN KEY (disp_horario_fk) REFERENCES T_Horario(id_hor),
    CONSTRAINT fk_dia_semana_disponibilidade FOREIGN KEY (disp_dia_semana_fk) REFERENCES T_Dia_Semana(id_dia_semana)
);

-- 17. Tabela de Usuário
CREATE TABLE T_Usuario (
    id_user INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    login_user VARCHAR2(100) NOT NULL,
    senha_user VARCHAR2(100) NOT NULL,
    data_criacao_user TIMESTAMP NOT NULL,
    data_atualizacao_user TIMESTAMP,
    id_usuario_perfil_fk INTEGER NOT NULL,
    CONSTRAINT fk_usuario_perfil FOREIGN KEY (id_usuario_perfil_fk) REFERENCES T_Usuario_Perfil(id_usuario_perfil)
);

-- 18. Tabela de Cliente
CREATE TABLE T_Cliente (
    id_clie INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_clie VARCHAR2(100) NOT NULL, 
    sobrenome_clie VARCHAR2(100) NOT NULL,
    email_clie VARCHAR2(100) UNIQUE NOT NULL, 
    telefone_clie VARCHAR2(15) NOT NULL, 
    data_nasc_clie DATE NOT NULL, 
    data_criacao_clie TIMESTAMP NOT NULL,
    data_atualizacao_clie TIMESTAMP,
    id_end_fk INTEGER NOT NULL, 
    id_end_pref_fk INTEGER NOT NULL, 
    id_cad_clie_fk INTEGER NOT NULL,
    id_recompensa_fk INTEGER NOT NULL,
    id_preferencia_atendimento_fk INTEGER NOT NULL,
    CONSTRAINT fk_endereco FOREIGN KEY (id_end_fk) REFERENCES T_Endereco_Cadastro(id_end),
    CONSTRAINT fk_endereco_pref FOREIGN KEY (id_end_pref_fk) REFERENCES T_Endereco_Preferencia(id_end_pref),
    CONSTRAINT fk_preferencia_atendimento FOREIGN KEY (id_preferencia_atendimento_fk) REFERENCES T_Preferencia_Atendimento(id_preferencia_atendimento),
    CONSTRAINT fk_cadastro_clie FOREIGN KEY (id_cad_clie_fk) REFERENCES T_Cadastro_Cliente(id_cad_clie),
    CONSTRAINT fk_recompensa FOREIGN KEY (id_recompensa_fk) REFERENCES T_Recompensa(id_recompensa)
);

-- 19. Tabela de Clínica
CREATE TABLE T_Clinica (
    id_clinica INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_clinica VARCHAR2(100) NOT NULL,
    telefone_clinica VARCHAR2(35) NOT NULL,
    cnpj_clinica VARCHAR2(20) NOT NULL,
    data_criacao_clinica TIMESTAMP NOT NULL,
    data_atualizacao_clinica TIMESTAMP,
    id_endereco_fk INTEGER NOT NULL,
    id_disponibilidade_horario_fk INTEGER,
    id_disponibilidade_dia_fk INTEGER,
    id_usuario_fk INTEGER NOT NULL,
    CONSTRAINT fk_endereco_clinica_2 FOREIGN KEY (id_endereco_fk) REFERENCES T_Endereco_Cadastro(id_end),
    CONSTRAINT fk_horario_disponibilidade_clinica FOREIGN KEY (id_disponibilidade_horario_fk) REFERENCES T_Horario(id_hor),
    CONSTRAINT fk_dia_disponibilidade_clinica FOREIGN KEY (id_disponibilidade_dia_fk) REFERENCES T_Dia_Semana(id_dia_semana),
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_user)
);

-- 20. Tabela de Médico
CREATE TABLE T_Medico (
    id_med INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_med VARCHAR2(100) NOT NULL,
    id_clinica_fk INTEGER,
    id_usuario_fk INTEGER NOT NULL,
    id_especialidade_fk INTEGER NOT NULL,
    id_cad_med_fk INTEGER NOT NULL,
    id_gen_fk INTEGER NOT NULL,
    id_end_fk INTEGER NOT NULL,
    data_criacao_med TIMESTAMP NOT NULL,
    data_atualizacao_med TIMESTAMP,
    CONSTRAINT fk_clinica_medico_2 FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_especialidade_medico_2 FOREIGN KEY (id_especialidade_fk) REFERENCES T_Especialidade(id_esp),
    CONSTRAINT fk_usuario_medico FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_user),
    CONSTRAINT fk_cadastro_medico FOREIGN KEY (id_cad_med_fk) REFERENCES T_Cadastro_Medico(id_cad_med),
    CONSTRAINT fk_genero_medico_2 FOREIGN KEY (id_gen_fk) REFERENCES T_Genero(id_gen),
    CONSTRAINT fk_endereco_medico FOREIGN KEY (id_end_fk) REFERENCES T_Endereco_Cadastro(id_end)
);

-- 21. Tabela de Login
CREATE TABLE T_Login (
    id_login INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_usuario_fk INTEGER NOT NULL,
    data_login TIMESTAMP NOT NULL,
    tipo_login VARCHAR2(50) NOT NULL, -- sucesso ou falha
    CONSTRAINT fk_usuario_login FOREIGN KEY (id_usuario_fk) REFERENCES T_Usuario(id_user)
);

-- 22. Tabela de Rotina de Cuidados
CREATE TABLE T_Rotina_Cuidado (
    id_rotina_cuidados INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    frequencia_escovacao VARCHAR2(50) NOT NULL,
    frequencia_fio_dental VARCHAR2(50) NOT NULL,
    frequencia_enxaguante VARCHAR2(50) NOT NULL,
    limpeza_profissional VARCHAR2(50) NOT NULL, -- 3 meses, 6 meses, 1 vez ao ano
    id_cliente_fk INTEGER NOT NULL,
    CONSTRAINT fk_cliente_rotina_cuidado FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie)
);

-- 23. Tabela de Status
CREATE TABLE T_Status (
    id_status INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    desc_status VARCHAR2(50) NOT NULL -- pendente, aceito, recusado, em acionamento
);

-- 24. Tabela de Clínica Sugerida
CREATE TABLE T_Clinica_Sugerida (
    id_sugestao INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_clinica_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    id_especialidade_fk INTEGER NOT NULL,
    data_consulta TIMESTAMP NOT NULL,
    id_status_fk INTEGER NOT NULL,
    data_envio_sugestao TIMESTAMP NOT NULL,
    data_alteracao_status TIMESTAMP NOT NULL,
    CONSTRAINT fk_cliente_sugestao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_clinica_sugestao FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_medico_sugestao FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_especialidade_sugestao FOREIGN KEY (id_especialidade_fk) REFERENCES T_Especialidade(id_esp),
    CONSTRAINT fk_status_sugestao FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 25. Tabela de Agendamento
CREATE TABLE T_Agendamento (
    id_agendamento INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    id_clinica_fk INTEGER NOT NULL,
    data_sugerida TIMESTAMP NOT NULL,
    horario_sugerido VARCHAR2(50) NOT NULL,
    id_status_agendamento_fk INTEGER NOT NULL,
    data_resposta TIMESTAMP,
    hora_resposta TIMESTAMP,
    data_criacao TIMESTAMP NOT NULL,
    CONSTRAINT fk_cliente_agendamento FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_agendamento FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_clinica_agendamento FOREIGN KEY (id_clinica_fk) REFERENCES T_Clinica(id_clinica),
    CONSTRAINT fk_status_agendamento FOREIGN KEY (id_status_agendamento_fk) REFERENCES T_Status(id_status)
);

-- 26. Tabela de Notificações
CREATE TABLE T_Notificacao (
    id_notificacao INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_agendamento_fk INTEGER NOT NULL,
    id_status_fk INTEGER NOT NULL,
    data_envio TIMESTAMP NOT NULL,
    CONSTRAINT fk_cliente_notificacao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_agendamento_notificacao FOREIGN KEY (id_agendamento_fk) REFERENCES T_Agendamento(id_agendamento),
    CONSTRAINT fk_status_notificacao FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 27. Tabela de Preferências de Notificações
CREATE TABLE T_Preferencia_Notificacao (
    id_preferencia_notificacao INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_tipo_notificacao_fk INTEGER NOT NULL,
    status_preferencia VARCHAR2(50) NOT NULL, -- ativa ou desativada
    data_atualizacao TIMESTAMP NOT NULL,
    CONSTRAINT fk_cliente_preferencia_notificacao FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_tipo_notificacao FOREIGN KEY (id_tipo_notificacao_fk) REFERENCES T_Status(id_status)
);

-- 28. Tabela de Consulta
CREATE TABLE T_Consulta (
    id_consulta INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    id_status_consulta_fk INTEGER NOT NULL,
    data_consulta TIMESTAMP NOT NULL,
    valor_consulta DECIMAL(10, 2) NOT NULL,
    id_feedback_fk INTEGER,
    CONSTRAINT fk_cliente_consulta FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_medico_consulta FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_status_consulta FOREIGN KEY (id_status_consulta_fk) REFERENCES T_Status(id_status)
);

-- 29. Tabela de Parcerias
CREATE TABLE T_Parceria (
    id_parceria INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome_parceiro VARCHAR2(100) NOT NULL,
    id_tipo_parceria_fk INTEGER NOT NULL,
    descricao VARCHAR2(255),
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,
    CONSTRAINT fk_tipo_parceria FOREIGN KEY (id_tipo_parceria_fk) REFERENCES T_Status(id_status)
);

-- 30. Tabela de Tarefas
CREATE TABLE T_Tarefa (
    id_tarefa INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao_tarefa VARCHAR2(255) NOT NULL
);

-- 31. Tabela de Programa de Benefício
CREATE TABLE T_Programa_Beneficio (
    id_programa_beneficio INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_tarefa_fk INTEGER NOT NULL,
    id_medico_fk INTEGER NOT NULL,
    data_inicio TIMESTAMP NOT NULL,
    data_fim TIMESTAMP,
    condicao_aplicacao VARCHAR2(255) NOT NULL,
    id_status_fk INTEGER NOT NULL,
    CONSTRAINT fk_tarefa_beneficio FOREIGN KEY (id_tarefa_fk) REFERENCES T_Tarefa(id_tarefa),
    CONSTRAINT fk_medico_beneficio FOREIGN KEY (id_medico_fk) REFERENCES T_Medico(id_med),
    CONSTRAINT fk_status_beneficio FOREIGN KEY (id_status_fk) REFERENCES T_Status(id_status)
);

-- 32. Tabela de Avaliações
CREATE TABLE T_Avaliacao (
    id_avaliacao INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
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

-- 33. Tabela de Pesquisa de Satisfação
CREATE TABLE T_Pesquisa_Satisfacao (
    id_pesquisa INTEGER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente_fk INTEGER NOT NULL,
    id_consulta_fk INTEGER NOT NULL,
    recomendacao_medico VARCHAR2(255) NOT NULL,
    nota_medico INTEGER NOT NULL,
    recomendacao_clinica VARCHAR2(255),
    nota_clinica INTEGER,
    comentarios VARCHAR2(500),
    data_pesquisa TIMESTAMP NOT NULL,
    CONSTRAINT fk_cliente_pesquisa FOREIGN KEY (id_cliente_fk) REFERENCES T_Cliente(id_clie),
    CONSTRAINT fk_consulta_pesquisa FOREIGN KEY (id_consulta_fk) REFERENCES T_Consulta(id_consulta)
);
