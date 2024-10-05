package br.com.fiap.challenge.gateways.service.impl;

import br.com.fiap.challenge.domains.Dentista;
import br.com.fiap.challenge.gateways.repository.DentistaRepository;
import br.com.fiap.challenge.gateways.service.DentistaService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DentistaServiceImpl implements DentistaService {

    private final DentistaRepository dentistaRepository;

    @Override
    public Dentista criarDentista(Dentista dentista) {
        return dentistaRepository.save(dentista);
    }

    @Override
    public Dentista buscarDentistaPorId(Long id) {
        return dentistaRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Dentista não encontrado"));
    }

    @Override
    public List<Dentista> buscarTodosDentistas() {
        return dentistaRepository.findAll();
    }

    @Override
    public Dentista atualizarDentista(Long id, Dentista dentista) {
        if (dentistaRepository.existsById(id)) {
            dentista.setIdDentista(id);
            return dentistaRepository.save(dentista);
        } else {
            throw new RuntimeException("Dentista não encontrado");
        }
    }

    @Override
    public void deletarDentista(Long id) {
        if (dentistaRepository.existsById(id)) {
            dentistaRepository.deleteById(id);
        } else {
            throw new RuntimeException("Dentista não encontrado");
        }
    }
}
