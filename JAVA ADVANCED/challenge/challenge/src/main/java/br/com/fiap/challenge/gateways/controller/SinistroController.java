package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.service.SinistroService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/sinistros")
@RequiredArgsConstructor
@Validated
public class SinistroController {
    private final SinistroService sinistroService;

}
