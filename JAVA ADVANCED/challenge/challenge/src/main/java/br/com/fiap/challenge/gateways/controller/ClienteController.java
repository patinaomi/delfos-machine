package br.com.fiap.challenge.gateways.controller;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.gateways.request.ClienteRequest;
import br.com.fiap.challenge.gateways.response.ClienteResponse;
import br.com.fiap.challenge.service.ClienteService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/clientes", produces = "application/json")
@RequiredArgsConstructor
@Tag(name = "cliente", description = "Operações relacionadas a clientes")
public class ClienteController {

    private final ClienteService clienteService;

    @Operation(
            summary = "Cria um novo cliente",
            description = "Cria um novo cliente com base nos dados informados"
    )
    @ApiResponses(value = {
            @ApiResponse(responseCode = "201", description = "Cliente criado com sucesso",
                    content = @Content(mediaType = "application/json", schema = @Schema(implementation = ClienteResponse.class))),
            @ApiResponse(responseCode = "400", description = "Requisição inválida", content = @Content),
            @ApiResponse(responseCode = "500", description = "Erro interno no servidor", content = @Content)
    })
    @PostMapping("/criar")
    public ResponseEntity<ClienteResponse> criar(@Valid @RequestBody ClienteRequest clienteRequest) {
        System.out.println(clienteRequest); // Adicione logs para depuração
        Cliente cliente = Cliente.builder()
                .nome(clienteRequest.getNome())
                .sobrenome(clienteRequest.getSobrenome())
                .email(clienteRequest.getEmail())
                .telefone(clienteRequest.getTelefone())
                .dataNasc(clienteRequest.getDataNasc())
                .endereco(clienteRequest.getEndereco())
                .build();

        Cliente clienteSalvo = clienteService.criar(cliente);

        ClienteResponse clienteResponse = ClienteResponse.builder()
                .nome(clienteSalvo.getNome())
                .sobrenome(clienteSalvo.getSobrenome())
                .email(clienteSalvo.getEmail())
                .telefone(clienteSalvo.getTelefone())
                .dataNasc(clienteSalvo.getDataNasc())
                .endereco(clienteSalvo.getEndereco())
                .build();

        return ResponseEntity.status(HttpStatus.CREATED).body(clienteResponse);
    }
}
