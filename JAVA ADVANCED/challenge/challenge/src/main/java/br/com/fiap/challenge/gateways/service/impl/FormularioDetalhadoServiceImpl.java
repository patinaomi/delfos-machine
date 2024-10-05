package br.com.fiap.challenge.gateways.service.impl;

import br.com.fiap.challenge.domains.FormularioDetalhado;
import br.com.fiap.challenge.gateways.repository.FormularioDetalhadoRepository;
import br.com.fiap.challenge.gateways.service.FormularioDetalhadoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FormularioDetalhadoServiceImpl implements FormularioDetalhadoService {

    private final FormularioDetalhadoRepository formularioDetalhadoRepository;

    @Override
    public FormularioDetalhado criarFormularioDetalhado(FormularioDetalhado formulario) {
        return formularioDetalhadoRepository.save(formulario);
    }

    @Override
    public FormularioDetalhado buscarFormularioDetalhadoPorId(Long id) {
        return formularioDetalhadoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Formulário Detalhado não encontrado"));
    }

    @Override
    public List<FormularioDetalhado> buscarTodosFormulariosDetalhados() {
        return formularioDetalhadoRepository.findAll();
    }

    @Override
    public FormularioDetalhado atualizarFormularioDetalhado(Long id, FormularioDetalhado formulario) {
        if (formularioDetalhadoRepository.existsById(id)) {
            formulario.setIdFormulario(id); // Define o ID para garantir a atualização correta
            return formularioDetalhadoRepository.save(formulario);
        } else {
            throw new RuntimeException("Formulário Detalhado não encontrado");
        }
    }

    @Override
    public void deletarFormularioDetalhado(Long id) {
        if (formularioDetalhadoRepository.existsById(id)) {
            formularioDetalhadoRepository.deleteById(id);
        } else {
            throw new RuntimeException("Formulário Detalhado não encontrado");
        }
    }
}
