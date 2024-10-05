package br.com.fiap.challenge.service;

import br.com.fiap.challenge.domains.Feedback;

import java.util.List;

public interface FeedbackService {
    Feedback criarFeedback(Feedback feedback);
    Feedback buscarFeedbackPorId(Long id);
    List<Feedback> buscarTodosFeedbacks();
    Feedback atualizarFeedback(Long id, Feedback feedback);
    void deletarFeedback(Long id);
}
