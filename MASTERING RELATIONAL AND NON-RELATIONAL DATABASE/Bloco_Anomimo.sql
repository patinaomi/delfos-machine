1. Consulta com INNER JOIN
DECLARE
    CURSOR c IS
        SELECT c.Nome, COUNT(e.ID_Endereco) AS Total_Enderecos
        FROM CLIENTE c
        INNER JOIN ENDERECO e ON c.ID_Cliente = e.ID_Cliente
        GROUP BY c.Nome
        ORDER BY Total_Enderecos DESC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || x.Nome || ', Total de Endereços: ' || x.Total_Enderecos);
    END LOOP;
END;


2. Consulta com LEFT JOIN
DECLARE
    CURSOR c IS
        SELECT c.Nome, COUNT(e.ID_Endereco) AS Total_Enderecos
        FROM CLIENTE c
        LEFT JOIN ENDERECO e ON c.ID_Cliente = e.ID_Cliente
        GROUP BY c.Nome
        ORDER BY Total_Enderecos ASC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cliente: ' || x.Nome || ', Total de Endereços: ' || NVL(x.Total_Enderecos, 0));
    END LOOP;
END;

3. Consulta com RIGHT JOIN
DECLARE
    CURSOR c IS
        SELECT e.Cidade, COUNT(c.ID_Cliente) AS Total_Clientes
        FROM ENDERECO e
        RIGHT JOIN CLIENTE c ON c.ID_Cliente = e.ID_Cliente
        GROUP BY e.Cidade
        ORDER BY Total_Clientes DESC;
BEGIN
    FOR x IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Cidade: ' || NVL(x.Cidade, 'Sem Cidade') || ', Total de Clientes: ' || x.Total_Clientes);
    END LOOP;
END;

