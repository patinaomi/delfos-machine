#--------------------( Importações necessárias )--------------------#

import pandas as pd
import cx_Oracle

# Minhas credenciais
credencial_banco = {
    'dsn': 'oracle.fiap.com.br:1521/orcl',  
    'usuario': 'rm553472',              
    'senha': '100593'                 
}

# Função para conectar ao banco de dados
def conectar(usuario, senha, dsn):
    try:
        conexao = cx_Oracle.connect(user=usuario, password=senha, dsn=dsn)
        print("Conexão com o banco de dados Oracle estabelecida com sucesso.")
        return conexao
    except cx_Oracle.DatabaseError as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None

usuario = credencial_banco.get('usuario')
senha = credencial_banco.get('senha')
dsn = credencial_banco.get('dsn')

conexao = conectar(usuario, senha, dsn)

def manipular_tabela(conexao, nome_tabela, query_criacao, query_inserir, dados):
    cursor = conexao.cursor()
    
    # Verificar se a tabela existe e excluí-la se necessário
    cursor.execute("""
        BEGIN
            EXECUTE IMMEDIATE :1;
        EXCEPTION
            WHEN OTHERS THEN
                IF SQLCODE != -942 THEN 
                    RAISE;
                END IF;
        END;
    """, (f'DROP TABLE {nome_tabela}',))  # Usando o nome da tabela passado como parâmetro
    print(f"Tabela '{nome_tabela}' excluída, se existia.")

    # Criar a nova tabela
    cursor.execute(query_criacao)
    print(f"Tabela '{nome_tabela}' criada com sucesso!")

    # Executar a inserção
    cursor.execute(query_inserir, dados)

    # Commit das alterações
    conexao.commit()
    print("Dados inseridos com sucesso.")

    # Fechar o cursor
    cursor.close()

# Inserir os dados dos clientes

# Nome da tabela
nome_tabela = "CLIENTE"

# Pode fazer para cada tabela
query_criacao = """
    CREATE TABLE CLIENTE ( 
        ID_Cliente NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
        Nome VARCHAR2(100) NOT NULL, 
        Email VARCHAR2(100) NOT NULL, 
        Telefone VARCHAR2(15), 
        Data_Nascimento DATE, 
        Endereco VARCHAR2(255) 
    )
"""

# os dados que precisam ser inseridos, como vamos ter várias tabelas, precisa ser diferente as colunas
query_inserir = """
    INSERT INTO CLIENTE (Nome, Email, Telefone, Data_Nascimento, Endereco)
    VALUES (:1, :2, :3, TO_DATE(:4, 'YYYY-MM-DD'), :5)
"""

# Informar os dados que serão inseridos
dados = ('Produtor 1', 'produtor1@example.com', '123456789', '2024-09-05', 'Rua A, 123')

# Chamar a função
manipular_tabela(conexao, nome_tabela, query_criacao, query_inserir, dados)

# Inserir os dados do Endereço

# Nome da tabela
nome_tabela = "ENDERECO"

query_criacao = """
    CREATE TABLE ENDERECO (
        ID_Endereco NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        ID_Cliente NUMBER,
        Cidade VARCHAR2(100),
        Rua VARCHAR2(255),
        FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
    )
"""

query_inserir = """
    INSERT INTO ENDERECO (ID_Cliente, Cidade, Rua)
    VALUES (:1, :2, :3)
"""

dados = (1, 'São Paulo', 'Rua A, 123')

manipular_tabela(conexao, nome_tabela, query_criacao, query_inserir, dados)


# Analisar a tabela CLIENTE
cursor = conexao.cursor()
cursor.execute("SELECT * FROM CLIENTE")
resultados = cursor.fetchall()

# Analisar a tabela ENDERECO

cursor = conexao.cursor()
cursor.execute("SELECT * FROM ENDERECO")
resultados = cursor.fetchall()
