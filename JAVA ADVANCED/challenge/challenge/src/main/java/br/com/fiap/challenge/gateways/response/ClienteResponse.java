package br.com.fiap.challenge.gateways.response;

import lombok.Builder;

import java.util.Date;

@Builder
public record ClienteResponse(
        String nome,
        String sobrenome,
        String email,
        String telefone,
        Date dataNasc,
        String endereco
)
{
}
