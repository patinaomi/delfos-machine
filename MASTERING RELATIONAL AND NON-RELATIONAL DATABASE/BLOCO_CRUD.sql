1. UPDATE
DECLARE
    v_id_cliente NUMBER := 1;
    v_novo_telefone VARCHAR2(15) := '987654321';
BEGIN
    UPDATE CLIENTE
    SET Telefone = v_novo_telefone
    WHERE ID_Cliente = v_id_cliente;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Telefone atualizado com sucesso para o cliente ID ' || v_id_cliente);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum cliente encontrado com o ID ' || v_id_cliente);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao atualizar: ' || SQLERRM);
        ROLLBACK;
END;

2. DELETE

DECLARE
    v_id_endereco NUMBER := 1;
BEGIN
    DELETE FROM ENDERECO
    WHERE ID_Endereco = v_id_endereco;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Endereço excluído com sucesso, ID ' || v_id_endereco);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum endereço encontrado com o ID ' || v_id_endereco);
    END IF;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao excluir: ' || SQLERRM);
        ROLLBACK;
END;
