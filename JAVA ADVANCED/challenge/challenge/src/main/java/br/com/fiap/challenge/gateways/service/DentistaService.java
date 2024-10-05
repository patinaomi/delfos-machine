package br.com.fiap.challenge.gateways.service;

import br.com.fiap.challenge.domains.Dentista;

import java.util.List;

public interface DentistaService {

    Dentista criarDentista(Dentista dentista);
    Dentista buscarDentistaPorId(Long id);
    List<Dentista> buscarTodosDentistas();
    Dentista atualizarDentista(Long id, Dentista dentista);
    void deletarDentista(Long id);
}
