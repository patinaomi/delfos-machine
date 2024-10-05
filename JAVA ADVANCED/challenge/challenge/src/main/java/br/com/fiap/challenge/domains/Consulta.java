package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.jetbrains.annotations.NotNull;

import java.util.Date;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Entity
@Table(name = "consulta")
public class Consulta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_consulta", nullable = false)
    private Long idConsulta;

    @ManyToOne
    @JoinColumn(name = "id_cliente", nullable = false)
    private Cliente cliente;

    @ManyToOne
    @JoinColumn(name = "id_clinica", nullable = false)
    private Clinica clinica;

    @ManyToOne
    @JoinColumn(name = "id_dentista", nullable = false)
    private Dentista dentista;

    @Column(name = "tipo_servico", length = 100, nullable = false)
    private String tipoServico;

    @Column(name = "data_consulta", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataConsulta;

    @Column(name = "status_consulta", length = 1)
    private char statusConsulta;

    @Column(name = "observacoes", length = 250)
    private String observacoes;

    @Column(name = "sintomas", length = 250)
    private String sintomas;

    @Column(name = "tratamento_recomendado", length = 250)
    private String tratamentoRecomendado;

    @Column(name = "custo")
    private double custo;

    @Column(name = "prescricao", length = 250)
    private String prescricao;

    @Temporal(TemporalType.DATE)
    @Column(name = "data_retorno")
    private Date dataRetorno;

}
