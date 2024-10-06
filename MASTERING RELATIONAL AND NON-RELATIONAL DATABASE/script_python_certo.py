import pandas as pd
import oracledb

# Minhas credenciais
credencial_banco = {
    'dsn': 'oracle.fiap.com.br:1521/orcl',
    'usuario': 'rm552981',
    'senha': '240794'
}


# Função para conectar ao banco de dados
def conectar(usuario, senha, dsn):
    try:
        conexao = oracledb.connect(user=usuario, password=senha, dsn=dsn, mode=oracledb.DEFAULT_AUTH)
        print("Conexão com o banco de dados Oracle estabelecida com sucesso.")
        return conexao
    except oracledb.DatabaseError as e:
        print(f"Erro ao conectar ao banco de dados: {e}")
        return None


# Função para manipular a tabela
def manipular_tabela(conexao, nome_tabela, query_criacao, query_inserir, dados):
    cursor = conexao.cursor()

    try:
        # Verificar se a tabela existe e excluí-la se necessário
        cursor.execute(f"""
            BEGIN
                EXECUTE IMMEDIATE 'DROP TABLE {nome_tabela} CASCADE CONSTRAINTS';
            EXCEPTION
                WHEN OTHERS THEN
                    IF SQLCODE != -942 THEN 
                        RAISE;
                    END IF;
            END;
        """)
        print(f"Tabela '{nome_tabela}' excluída, se existia.")

        # Criar a nova tabela
        cursor.execute(query_criacao)
        print(f"Tabela '{nome_tabela}' criada com sucesso!")

        # Executar a inserção
        for registro in dados:
            cursor.execute(query_inserir, registro)

        # Commit das alterações
        conexao.commit()
        print("Dados inseridos com sucesso.")

    except oracledb.DatabaseError as e:
        print(f"Erro ao manipular a tabela: {e}")
        conexao.rollback()  # Desfazer alterações em caso de erro

    finally:
        # Fechar o cursor
        cursor.close()


# Função para consultar dados
def consultar_dados(cursor, nome_tabela):
    cursor.execute(f"SELECT * FROM {nome_tabela}")
    resultados = cursor.fetchall()

    if resultados:
        print(f"\nResultados da tabela {nome_tabela}:")
        for row in resultados:
            if nome_tabela == "CLIENTE":
                print(f"ID Cliente: {row[0]}")
                print(f"Nome: {row[1]}")
                print(f"Email: {row[2]}")
                print(f"Telefone: {row[3]}")
                print(f"Data de Nascimento: {row[4]}")
                print(f"Endereço: {row[5]}\n")
            elif nome_tabela == "ENDERECO":
                print(f"ID Endereço: {row[0]}")
                print(f"ID Cliente: {row[1]}")
                print(f"Cidade: {row[2]}")
                print(f"Rua: {row[3]}\n")
    else:
        print(f"Nenhum resultado encontrado na tabela {nome_tabela}.")


# Menu principal
def menu(conexao):
    while True:
        print("\nMenu:")
        print("1. Criar e inserir dados na tabela CLIENTE")
        print("2. Criar e inserir dados na tabela ENDERECO")
        print("3. Consultar dados da tabela CLIENTE")
        print("4. Consultar dados da tabela ENDERECO")
        print("5. Sair")

        opcao = input("Escolha uma opção: ")

        if opcao == '1':
            # Inserir os dados dos clientes
            nome_tabela = "CLIENTE"
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
            query_inserir = """
                INSERT INTO CLIENTE (Nome, Email, Telefone, Data_Nascimento, Endereco)
                VALUES (:1, :2, :3, TO_DATE(:4, 'YYYY-MM-DD'), :5)
            """
            # Dados de exemplo para 10 clientes
            dados_cliente = [
                ('Cliente 1', 'cliente1@example.com', '123456789', '1980-01-01', 'Rua A, 123'),
                ('Cliente 2', 'cliente2@example.com', '123456780', '1981-02-02', 'Rua B, 234'),
                ('Cliente 3', 'cliente3@example.com', '123456771', '1982-03-03', 'Rua C, 345'),
                ('Cliente 4', 'cliente4@example.com', '123456762', '1983-04-04', 'Rua D, 456'),
                ('Cliente 5', 'cliente5@example.com', '123456753', '1984-05-05', 'Rua E, 567'),
                ('Cliente 6', 'cliente6@example.com', '123456744', '1985-06-06', 'Rua F, 678'),
                ('Cliente 7', 'cliente7@example.com', '123456735', '1986-07-07', 'Rua G, 789'),
                ('Cliente 8', 'cliente8@example.com', '123456726', '1987-08-08', 'Rua H, 890'),
                ('Cliente 9', 'cliente9@example.com', '123456717', '1988-09-09', 'Rua I, 901'),
                ('Cliente 10', 'cliente10@example.com', '123456708', '1989-10-10', 'Rua J, 012')
            ]
            manipular_tabela(conexao, nome_tabela, query_criacao, query_inserir, dados_cliente)

        elif opcao == '2':
            # Inserir os dados do Endereço
            nome_tabela = "ENDERECO"
            query_criacao_endereco = """
                CREATE TABLE ENDERECO (
                    ID_Endereco NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
                    ID_Cliente NUMBER,
                    Cidade VARCHAR2(100),
                    Rua VARCHAR2(255),
                    FOREIGN KEY (ID_Cliente) REFERENCES CLIENTE(ID_Cliente)
                )
            """
            query_inserir_endereco = """
                INSERT INTO ENDERECO (ID_Cliente, Cidade, Rua)
                VALUES (:1, :2, :3)
            """
            # Obter os IDs dos clientes inseridos
            cursor = conexao.cursor()
            cursor.execute("SELECT ID_Cliente FROM CLIENTE")
            cliente_ids = cursor.fetchall()

            # Dados de exemplo para 10 endereços
            dados_endereco = [
                (cliente_ids[0][0], 'São Paulo', 'Rua A, 123'),
                (cliente_ids[1][0], 'São Paulo', 'Rua B, 234'),
                (cliente_ids[2][0], 'Rio de Janeiro', 'Rua C, 345'),
                (cliente_ids[3][0], 'Belo Horizonte', 'Rua D, 456'),
                (cliente_ids[4][0], 'Curitiba', 'Rua E, 567'),
                (cliente_ids[5][0], 'Fortaleza', 'Rua F, 678'),
                (cliente_ids[6][0], 'Salvador', 'Rua G, 789'),
                (cliente_ids[7][0], 'Recife', 'Rua H, 890'),
                (cliente_ids[8][0], 'Porto Alegre', 'Rua I, 901'),
                (cliente_ids[9][0], 'Manaus', 'Rua J, 012')
            ]
            manipular_tabela(conexao, nome_tabela, query_criacao_endereco, query_inserir_endereco, dados_endereco)

        elif opcao == '3':
            # Consultar dados da tabela CLIENTE
            cursor = conexao.cursor()
            consultar_dados(cursor, "CLIENTE")

        elif opcao == '4':
            # Consultar dados da tabela ENDERECO
            cursor = conexao.cursor()
            consultar_dados(cursor, "ENDERECO")

        elif opcao == '5':
            print("Saindo do programa.")
            break

        else:
            print("Opção inválida. Por favor, escolha novamente.")


# Executando o menu
conexao = conectar(credencial_banco['usuario'], credencial_banco['senha'], credencial_banco['dsn'])
if conexao:
    menu(conexao)
    # Fechar a conexão ao final
    conexao.close()
