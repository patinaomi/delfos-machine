package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Consulta;

import java.util.List;

public interface ConsultaService {
    Consulta criarConsulta(Consulta consulta);
    Consulta buscarConsultaPorId(Long id);
    List<Consulta> buscarTodasConsultas();
    Consulta atualizarConsulta(Long id, Consulta consulta);
    void deletarConsulta(Long id);
}
