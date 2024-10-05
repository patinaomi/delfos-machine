package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.service.ClienteService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/clientes")
@RequiredArgsConstructor
@Validated
public class ClienteController {
    private final ClienteService clienteService;
}
