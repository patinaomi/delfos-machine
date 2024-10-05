package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.gateways.repository.ClienteRepository;
import br.com.fiap.challenge.service.ClienteService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ClienteServiceImpl implements ClienteService {

    private final ClienteRepository clienteRepository;

    @Override
    public Cliente criar(@Valid ClienteRequest cliente) {
        cliente.telefone(limparCaracteresTel(cliente.telefone()));
        return clienteRepository.save(cliente);
    }

    @Override
    public Cliente buscarPorId(Long id) {
        return clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente não encontrado"));
    }

    @Override
    public List<Cliente> buscarTodos() {
        return clienteRepository.findAll();
    }

    @Override
    public Cliente atualizar(Long id, Cliente cliente) {
        if (clienteRepository.existsById(id)) {
            cliente.setIdCliente(id);
            return clienteRepository.save(cliente);
        } else {
            throw new RuntimeException("Cliente não encontrado");
        }
    }

    @Override
    public void deletar(Long id) {
        if (clienteRepository.existsById(id)) {
            clienteRepository.deleteById(id);
        } else {
            throw new RuntimeException("Cliente não encontrado");
        }
    }

    // Aqui tudo que não for número é removido do telefone, pra que seja salvo no banco de dados apenas os números
    private String limparCaracteresTel(String telefone) {
        return telefone.replaceAll("\\D", "");
    }
}
