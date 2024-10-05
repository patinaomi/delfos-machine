package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "sinistro")
public class Sinistro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sinistro", nullable = false)
    private Long idSinistro;

    @ManyToOne
    @JoinColumn(name = "id_consulta", nullable = false)
    private Consulta consulta;

    @Column(name = "nome", length = 100, nullable = false)
    private String nome;

    @Column(name = "descricao")
    private String descricao;

    @Column(name = "status_sinistro", length = 1)
    private char statusSinistro;

    @Column(name = "descricao_status", length = 250)
    private String descricaoStatus;

    @Column(name = "valor_sinistro")
    private Double valorSinistro;

    @Temporal(TemporalType.DATE)
    @Column(name = "data_abertura")
    private Date dataAbertura;

    @Temporal(TemporalType.DATE)
    @Column(name = "data_resolucao")
    private Date dataResolucao;

    @Column(name = "documentacao", length = 250)
    private String documentacao;
}
