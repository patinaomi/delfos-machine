package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.service.DentistaService;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/dentistas")
@RequiredArgsConstructor
@Validated
public class DentistaController {
    private final DentistaService dentistaService;
}
