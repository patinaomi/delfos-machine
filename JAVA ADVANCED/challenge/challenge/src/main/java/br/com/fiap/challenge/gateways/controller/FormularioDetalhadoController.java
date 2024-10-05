package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.service.FormularioDetalhadoService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/formularios")
@RequiredArgsConstructor
@Validated
public class FormularioDetalhadoController {
    private final FormularioDetalhadoService formularioDetalhadoService;
}
