package br.com.fiap.challenge.gateways.request;

import br.com.fiap.challenge.domains.Cliente;
import br.com.fiap.challenge.domains.EstadoCivil;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

import java.util.Date;

@Data
public class FormularioDetalhadoRequest {

    @NotNull(message = "Cliente não pode ser nulo")
    private Cliente cliente;

    @NotNull(message = "Estado civil não pode ser nulo")
    private EstadoCivil estadoCivil;

    private String historicoFamiliar;
    private String profissao;
    private Double rendaMensal;
    private String historicoMedico;
    private String alergia;
    private String condicaoPreexistente;
    private String usoMedicamento;
    private String familiarComDoencasDentarias;
    private char participacaoEmProgramasPreventivos;
    private String contatoEmergencial;
    private char pesquisaSatisfacao;
    private Date dataUltimaAtualizacao;
    private char frequenciaConsultaPeriodica;
    private String sinalizacaoDeRisco;
    private String historicoDeViagem;
    private String historicoDeMudancasDeEndereco;
    private String preferenciaDeContato;
}
