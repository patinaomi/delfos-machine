

-- Nome dos Integrantes: 
-- Claudio Silva Bispo RM553472
-- Patricia Naomi Yamagishi RM552981

-- Deletar tabelas caso já existam

DROP TABLE Notificacao CASCADE CONSTRAINTS;
DROP TABLE Agenda CASCADE CONSTRAINTS;
DROP TABLE Formulario_Detalhado CASCADE CONSTRAINTS;
DROP TABLE Feedback CASCADE CONSTRAINTS;
DROP TABLE Sinistro CASCADE CONSTRAINTS;
DROP TABLE Consulta CASCADE CONSTRAINTS;
DROP TABLE Dentista CASCADE CONSTRAINTS;
DROP TABLE Especialidade CASCADE CONSTRAINTS;
DROP TABLE Clinica CASCADE CONSTRAINTS;
DROP TABLE Cliente CASCADE CONSTRAINTS;
DROP TABLE Estado_Civil CASCADE CONSTRAINTS;
DROP TABLE Tipo_Notificacao CASCADE CONSTRAINTS;

-- Criação das Tabelas

-- Tabela Cliente 
CREATE TABLE Cliente ( 
    id_cliente INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL, 
    sobrenome VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) CONSTRAINT email_unique UNIQUE NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, 
    data_nasc DATE NOT NULL, 
    endereco VARCHAR2(255) NOT NULL
); 

-- Tabela Clínica 
CREATE TABLE Clinica ( 
    id_clinica INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL, 
    endereco VARCHAR2(255) NOT NULL, 
    telefone VARCHAR2(15) NOT NULL, 
    avaliacao DECIMAL(2, 1) NOT NULL,
    preco_medio DECIMAL(10, 2) NOT NULL
); 

-- Tabela Especialidade
CREATE TABLE Especialidade (
    id_especialidade INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL
);

-- Tabela Dentista
CREATE TABLE Dentista (
    id_dentista INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    nome VARCHAR2(100) NOT NULL,
    sobrenome VARCHAR2(100) NOT NULL,
    telefone VARCHAR2(15) NOT NULL,
    id_clinica INTEGER NOT NULL,
    id_especialidade INTEGER NOT NULL,
    avaliacao DECIMAL(2, 1) NOT NULL,
    
    CONSTRAINT fk_dentista_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_dentista_especialidade FOREIGN KEY (id_especialidade) REFERENCES Especialidade(id_especialidade)
);

-- Tabela Consulta 
CREATE TABLE Consulta ( 
    id_consulta INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL, 
    id_clinica INTEGER NOT NULL, 
    id_dentista INTEGER NOT NULL,
    tipo_servico VARCHAR2(100) NOT NULL,
    data_consulta TIMESTAMP NOT NULL, 
    status_consulta CHAR(1), -- 'S' ou 'N'
    observacoes VARCHAR2(250), 
    sintomas VARCHAR2(250), 
    tratamento_recomendado VARCHAR2(250), 
    custo DECIMAL(10, 2),
    prescricao VARCHAR2(250), 
    data_retorno DATE,
    
    CONSTRAINT fk_consulta_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_consulta_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_consulta_dentista FOREIGN KEY (id_dentista) REFERENCES Dentista(id_dentista)
);
 
-- Tabela Sinistro
CREATE TABLE Sinistro (
    id_sinistro INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_consulta INTEGER NOT NULL, 
    nome VARCHAR2(100) NOT NULL,
    descricao VARCHAR2(250),
    status_sinistro CHAR(1), -- 'S' ou 'N'
    descricao_status VARCHAR2(250),
    valor_sinistro DECIMAL(10, 2),
    data_abertura DATE NOT NULL,
    data_resolucao DATE,
    documentacao VARCHAR2(250),
    
    CONSTRAINT fk_sinistro_consulta FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);

-- Tabela Feedback
CREATE TABLE Feedback (
    id_feedback INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_dentista INTEGER NOT NULL,
    id_clinica INTEGER NOT NULL,
    avaliacao DECIMAL(2, 1) NOT NULL,
    comentario VARCHAR2(250),
    
    CONSTRAINT fk_feedback_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_feedback_clinica FOREIGN KEY (id_clinica) REFERENCES Clinica(id_clinica),
    CONSTRAINT fk_feedback_dentista FOREIGN KEY (id_dentista) REFERENCES Dentista(id_dentista)
);
  
-- Tabela Estado Civil
CREATE TABLE Estado_Civil (
    id_estado_civil INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(50) NOT NULL
);

-- Tabela Formulário Detalhado
CREATE TABLE Formulario_Detalhado (
    id_formulario INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_estado_civil INTEGER NOT NULL,
    historico_familiar VARCHAR2(250),
    profissao VARCHAR2(100),
    renda_mensal DECIMAL(10, 2),
    historico_medico VARCHAR2(250),
    alergia VARCHAR2(250),
    condicao_preexistente VARCHAR2(250),
    uso_medicamento VARCHAR2(250),
    familiar_com_doencas_dentarias VARCHAR2(255),
    participacao_em_programas_preventivos CHAR(1), -- 'Y' ou 'N'
    contato_emergencial VARCHAR2(250),
    pesquisa_satisfacao CHAR(1), -- 'Y' ou 'N'
    data_ultima_atualizacao DATE,
    frequencia_consulta_periodica CHAR(1), -- 'Y' ou 'N'
    sinalizacao_de_risco VARCHAR2(250),
    historico_de_viagem VARCHAR2(250),
    historico_de_mudancas_de_endereco VARCHAR2(250),
    preferencia_de_contato VARCHAR2(50),

    CONSTRAINT fk_formulario_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_formulario_estado_civil FOREIGN KEY (id_estado_civil) REFERENCES Estado_Civil(id_estado_civil)
);

-- Tabela Tipo Notificação
CREATE TABLE Tipo_Notificacao (
    id_tipo_notificacao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    descricao VARCHAR2(40) NOT NULL
);

-- Tabela Agenda
CREATE TABLE Agenda (
    id_agenda INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_consulta INTEGER NOT NULL,
    status_consulta CHAR(1),
    observacoes VARCHAR2(250),

    CONSTRAINT fk_agenda_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_agenda_consulta FOREIGN KEY (id_consulta) REFERENCES Consulta(id_consulta)
);

-- Tabela Notificações
CREATE TABLE Notificacao (
    id_notificacao INTEGER GENERATED ALWAYS AS IDENTITY(START WITH 1 INCREMENT BY 1) NOT NULL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_tipo_notificacao INTEGER NOT NULL,
    mensagem VARCHAR2(250),
    data_envio DATE,

    CONSTRAINT fk_notificacao_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    CONSTRAINT fk_notificacao_tipo FOREIGN KEY (id_tipo_notificacao) REFERENCES Tipo_Notificacao(id_tipo_notificacao)
);


// Funções de Validação de Entrada de Dados

-- 1. Função para Validar Email
-- Importante para sabermos se o e-mail consta nas regras básicas, com dominio por exemplo, ter o @, e seguir a conversão de .com ou .com.br
/*
Cenários de testes

Email sem @: Deve ser inválido.
Email sem domínio: Deve ser inválido (ex: usuario@).
Email sem nome de usuário: Deve ser inválido (ex: @dominio.com).
Email com caracteres inválidos: Deve ser inválido (ex: usuário!@dominio.com).
Email válido: Deve ser válido (ex: usuario@dominio.com).
Verificar se o email já existe na tabela Cliente.
*/

select * from Cliente;

CREATE OR REPLACE FUNCTION validar_email(p_email IN VARCHAR2) RETURN BOOLEAN IS
    v_count INTEGER;
BEGIN
    -- Verificar se o email contém o símbolo '@'
    IF INSTR(p_email, '@') = 0 THEN
        RETURN FALSE; -- Email inválido, não contém '@'
    END IF;

    -- Verificar se o email tem um domínio após '@'
    IF LENGTH(SUBSTR(p_email, INSTR(p_email, '@') + 1)) = 0 THEN
        RETURN FALSE; -- Email inválido, sem domínio
    END IF;

    -- Verificar se o domínio contém um ponto '.'
    IF INSTR(SUBSTR(p_email, INSTR(p_email, '@') + 1), '.') = 0 THEN
        RETURN FALSE; -- Email inválido, domínio sem ponto
    END IF;

    -- Verificar se o email tem um nome de usuário antes de '@'
    IF LENGTH(SUBSTR(p_email, 1, INSTR(p_email, '@') - 1)) = 0 THEN
        RETURN FALSE; -- Email inválido, sem nome de usuário
    END IF;

    -- Verificar se o email contém caracteres inválidos
    IF REGEXP_LIKE(p_email, '[^a-zA-Z0-9@._-]') THEN
        RETURN FALSE; -- Email inválido, contém caracteres inválidos
    END IF;

    -- Verificar se o email já existe na tabela Cliente
    SELECT COUNT(*)
    INTO v_count
    FROM Cliente
    WHERE email = p_email;

    IF v_count > 0 THEN
        RETURN FALSE; -- Email já existe
    ELSE
        RETURN TRUE; -- Email válido
    END IF;
END;

-- Testar a função com input

CREATE OR REPLACE PROCEDURE solicitar_e_validar_email IS
    v_email VARCHAR2(100);
    v_result BOOLEAN;
BEGIN
    -- Solicitar ao usuário que insira um email
    DBMS_OUTPUT.PUT_LINE('Por favor, insira um email:');
    v_email := '&email'; -- Variável de substituição para entrada do usuário

    -- Chamar a função de validação de email
    v_result := validar_email(v_email);

    -- Exibir o email digitado e o resultado da validação
    DBMS_OUTPUT.PUT_LINE('Email digitado: ' || v_email);
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Resultado: Email válido.');
    ELSE
        -- Verificar se o email já existe na base de dados
        DECLARE
            v_count INTEGER;
        BEGIN
            SELECT COUNT(*)
            INTO v_count
            FROM Cliente
            WHERE email = v_email;

            IF v_count > 0 THEN
                DBMS_OUTPUT.PUT_LINE('Resultado: Email inválido. O email já existe na base de dados.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Resultado: Email inválido.');
            END IF;
        END;
    END IF;
END;

-- Execute este comando para verificar o resultado
EXEC solicitar_e_validar_email;

-- Procedure para avaliar minha tabela com a validação de e-mail

CREATE OR REPLACE PROCEDURE avaliar_base_de_dados IS
    v_email VARCHAR2(100);
    CURSOR c_emails IS
        SELECT email FROM Cliente;
BEGIN
    -- Verificar se os emails seguem as regras de validação
    DBMS_OUTPUT.PUT_LINE('Verificando formato dos emails...');
    FOR r_email IN c_emails LOOP
        v_email := r_email.email;

        -- Verificar se o email contém o símbolo '@'
        IF INSTR(v_email, '@') = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Email inválido (sem @): ' || v_email);
        -- Verificar se o email tem um domínio após '@'
        ELSIF LENGTH(SUBSTR(v_email, INSTR(v_email, '@') + 1)) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Email inválido (sem domínio): ' || v_email);
        -- Verificar se o domínio contém um ponto '.'
        ELSIF INSTR(SUBSTR(v_email, INSTR(v_email, '@') + 1), '.') = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Email inválido (domínio sem ponto): ' || v_email);
        -- Verificar se o email tem um nome de usuário antes de '@'
        ELSIF LENGTH(SUBSTR(v_email, 1, INSTR(v_email, '@') - 1)) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Email inválido (sem nome de usuário): ' || v_email);
        -- Verificar se o email contém caracteres inválidos
        ELSIF REGEXP_LIKE(v_email, '[^a-zA-Z0-9@._-]') THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Email inválido (caracteres inválidos): ' || v_email);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Email válido: ' || v_email);
        END IF;
    END LOOP;

END;


// Inserts Cliente

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Alice', 'Silva', 'alice.silva@example.com', '11987654321', TO_DATE('1990-01-15', 'YYYY-MM-DD'), 'Rua das Flores, 123');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Bruno', 'Santos', 'example.com', '11976543210', TO_DATE('1985-03-20', 'YYYY-MM-DD'), 'Avenida Central, 456');

INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco) VALUES
('Carlos', 'Oliveira', 'carlos.oliveira', '11965432109', TO_DATE('1992-07-11', 'YYYY-MM-DD'), 'Rua dos Lírios, 789');

select * from Cliente;

-- Verifique o resultado
EXEC avaliar_base_de_dados;


-- Função para avaliar Data de Nascimento

CREATE OR REPLACE FUNCTION validar_data_nasc(p_data_nasc IN DATE) RETURN BOOLEAN IS
BEGIN
    -- Verificar se a data de nascimento é no futuro
    IF p_data_nasc > SYSDATE THEN
        RETURN FALSE; -- Data de nascimento no futuro
    END IF;

    -- Verificar se o usuário tem pelo menos 18 anos
    IF MONTHS_BETWEEN(SYSDATE, p_data_nasc) < 18 * 12 THEN
        RETURN FALSE; -- Usuário tem menos de 18 anos
    END IF;

    RETURN TRUE; -- Data de nascimento válida
END;

-- Procedimento para solicitar Data de Nascimento e Validar os dados

CREATE OR REPLACE PROCEDURE solicitar_e_validar_data_nasc IS
    v_data_nasc DATE;
    v_result BOOLEAN;
BEGIN
    -- Solicitar ao usuário que insira uma data de nascimento no formato brasileiro
    DBMS_OUTPUT.PUT_LINE('Por favor, insira uma data de nascimento (DD/MM/YYYY):');
    v_data_nasc := TO_DATE('&data_nasc', 'DD/MM/YYYY'); -- Variável de substituição para entrada do usuário

    -- Chamar a função de validação de data de nascimento
    v_result := validar_data_nasc(v_data_nasc);

    -- Exibir a data de nascimento digitada e o resultado da validação
    DBMS_OUTPUT.PUT_LINE('Data de nascimento digitada: ' || TO_CHAR(v_data_nasc, 'DD/MM/YYYY'));
    IF v_result THEN
        DBMS_OUTPUT.PUT_LINE('Resultado: Data de nascimento válida.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Resultado: Data de nascimento inválida.');
    END IF;
END;


-- Procedimento para avaliar Datas de Nascimento na tabela
CREATE OR REPLACE PROCEDURE avaliar_datas_nasc IS
    v_data_nasc DATE;
    CURSOR c_datas_nasc IS
        SELECT data_nasc FROM Cliente;
BEGIN
    -- Verificar se as datas de nascimento seguem as regras de validação
    DBMS_OUTPUT.PUT_LINE('Verificando datas de nascimento...');
    FOR r_data_nasc IN c_datas_nasc LOOP
        v_data_nasc := r_data_nasc.data_nasc;

        -- Chamar a função de validação de data de nascimento
        IF validar_data_nasc(v_data_nasc) THEN
            DBMS_OUTPUT.PUT_LINE('Data de nascimento válida: ' || TO_CHAR(v_data_nasc, 'DD-MON-YYYY'));
        ELSE
            DBMS_OUTPUT.PUT_LINE('Erro: Data de nascimento inválida: ' || TO_CHAR(v_data_nasc, 'DD-MON-YYYY'));
        END IF;
    END LOOP;

END;

-- Executar o processo de input
EXEC solicitar_e_validar_data_nasc;

-- Executar o processo na tabela para validar os dados
EXEC avaliar_datas_nasc;


// Procedures para Operações CRUD

-- Procedure para INSERT na Tabela Cliente

CREATE OR REPLACE PROCEDURE inserir_cliente(
    p_nome IN VARCHAR2,
    p_sobrenome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_telefone IN VARCHAR2,
    p_data_nasc IN DATE,
    p_endereco IN VARCHAR2
) IS
BEGIN
    -- Validar email
    IF NOT validar_email(p_email) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email inválido ou já existente.');
    END IF;

    -- Validar data de nascimento
    IF NOT validar_data_nasc(p_data_nasc) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Data de nascimento inválida.');
    END IF;

    -- Inserir cliente
    INSERT INTO Cliente (nome, sobrenome, email, telefone, data_nasc, endereco)
    VALUES (p_nome, p_sobrenome, p_email, p_telefone, p_data_nasc, p_endereco);

    DBMS_OUTPUT.PUT_LINE('Cliente inserido com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao inserir cliente: ' || SQLERRM);
END;

-- Testar
EXEC inserir_cliente('Claudio', 'Bispo', 'claudio@example.com', '123456789', TO_DATE('1993-05-10', 'YYYY-MM-DD'), 'Rua Aurea da Gama');

select * from Cliente;

-- Procedure para UPDATE na Tabela Cliente

CREATE OR REPLACE PROCEDURE atualizar_cliente(
    p_id_cliente IN INTEGER,
    p_nome IN VARCHAR2,
    p_sobrenome IN VARCHAR2,
    p_email IN VARCHAR2,
    p_telefone IN VARCHAR2,
    p_data_nasc IN DATE,
    p_endereco IN VARCHAR2
) IS
BEGIN
    -- Validar email
    IF NOT validar_email(p_email) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email inválido ou já existente.');
    END IF;

    -- Validar data de nascimento
    IF NOT validar_data_nasc(p_data_nasc) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Data de nascimento inválida.');
    END IF;

    -- Atualizar cliente
    UPDATE Cliente
    SET nome = p_nome,
        sobrenome = p_sobrenome,
        email = p_email,
        telefone = p_telefone,
        data_nasc = p_data_nasc,
        endereco = p_endereco
    WHERE id_cliente = p_id_cliente;

    DBMS_OUTPUT.PUT_LINE('Cliente atualizado com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar cliente: ' || SQLERRM);
END;

-- Testar o Update na tabela Cliente

select * from Cliente;

EXEC atualizar_cliente(1, 'Nome Atualizado', 'Sobrenome Atualizado', 'email_atualizado@example.com', '987654321', TO_DATE('01/01/1990', 'DD/MM/YYYY'), 'Endereço Atualizado');

select * from Cliente;

-- Procedure para DELETE na Tabela Cliente

CREATE OR REPLACE PROCEDURE deletar_cliente(
    p_id_cliente IN INTEGER
) IS
BEGIN
    -- Deletar cliente
    DELETE FROM Cliente
    WHERE id_cliente = p_id_cliente;

    DBMS_OUTPUT.PUT_LINE('Cliente deletado com sucesso.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao deletar cliente: ' || SQLERRM);
END;

-- Testar o Delete na tabela Cliente

EXEC deletar_cliente(1);
select * from Cliente;

