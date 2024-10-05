package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.service.ConsultaService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/consultas")
@RequiredArgsConstructor
@Validated
public class ConsultaController {
    private final ConsultaService consultaService;
}
