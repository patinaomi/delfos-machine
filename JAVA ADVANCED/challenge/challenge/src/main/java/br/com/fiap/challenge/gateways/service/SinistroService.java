package br.com.fiap.challenge.gateways.service;

import br.com.fiap.challenge.domains.Sinistro;

import java.util.List;

public interface SinistroService {

    Sinistro criarSinistro(Sinistro sinistro);
    Sinistro buscarSinistroPorId(Long id);
    List<Sinistro> buscarTodosSinistros();
    Sinistro atualizarSinistro(Long id, Sinistro sinistro);
    void deletarSinistro(Long id);

}
