package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Cliente;
import jakarta.validation.Valid;

import java.util.List;

public interface ClienteService {
    Cliente criar(@Valid ClienteRequest cliente);
    Cliente buscarPorId(Long id);
    List<Cliente> buscarTodos();
    Cliente atualizar(Long id, Cliente cliente);
    void deletar(Long id);
}
