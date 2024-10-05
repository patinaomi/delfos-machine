package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.service.FeedbackService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/feedbacks")
@RequiredArgsConstructor
@Validated
public class FeedbackController {
    private final FeedbackService feedbackService;
}
