package br.com.fiap.challenge.gateways.service;

import br.com.fiap.challenge.domains.Cliente;

import java.util.List;

public interface ClienteService {
    Cliente criarCliente(Cliente cliente);
    Cliente buscarClientePorId(Long id);
    List<Cliente> buscarTodosClientes();
    Cliente atualizarCliente(Long id, Cliente cliente);
    void deletarCliente(Long id);
}
