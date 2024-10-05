package br.com.fiap.challenge.service.impl;

import br.com.fiap.challenge.domains.Consulta;
import br.com.fiap.challenge.gateways.repository.ConsultaRepository;
import br.com.fiap.challenge.service.ConsultaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ConsultaServiceImpl implements ConsultaService {

    private final ConsultaRepository consultaRepository;

    @Override
    public Consulta criarConsulta(Consulta consulta) {
        return consultaRepository.save(consulta);
    }

    @Override
    public Consulta buscarConsultaPorId(Long id) {
        return consultaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Consulta não encontrada"));
    }

    @Override
    public List<Consulta> buscarTodasConsultas() {
        return consultaRepository.findAll();
    }

    @Override
    public Consulta atualizarConsulta(Long id, Consulta consulta) {
        if (consultaRepository.existsById(id)) {
            consulta.setIdConsulta(id);
            return consultaRepository.save(consulta);
        } else {
            throw new RuntimeException("Consulta não encontrada");
        }
    }

    @Override
    public void deletarConsulta(Long id) {
        if (consultaRepository.existsById(id)) {
            consultaRepository.deleteById(id);
        } else {
            throw new RuntimeException("Consulta não encontrada");
        }
    }
}
