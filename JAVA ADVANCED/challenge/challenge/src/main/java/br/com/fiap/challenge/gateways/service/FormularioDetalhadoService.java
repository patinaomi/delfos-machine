package br.com.fiap.challenge.gateways.service;

import br.com.fiap.challenge.domains.FormularioDetalhado;

import java.util.List;

public interface FormularioDetalhadoService {

    FormularioDetalhado criarFormularioDetalhado(FormularioDetalhado formulario);
    FormularioDetalhado buscarFormularioDetalhadoPorId(Long id);
    List<FormularioDetalhado> buscarTodosFormulariosDetalhados();
    FormularioDetalhado atualizarFormularioDetalhado(Long id, FormularioDetalhado formulario);
    void deletarFormularioDetalhado(Long id);

}
