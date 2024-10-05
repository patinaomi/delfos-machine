package br.com.fiap.challenge.domains;

import jakarta.persistence.*;
import lombok.*;
import org.jetbrains.annotations.NotNull;

@AllArgsConstructor
@NoArgsConstructor
@Data
@Builder
@Entity
@Table(name = "consulta")
public class Consulta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_consulta")
    private Long idConsulta;

    @NotNull
    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "id_cliente", nullable = false)
    private Cliente cliente;

    @NotNull
    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id_cliente", nullable = false)
    private Clinica clinica;

    @NotNull
    @ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "id_cliente", nullable = false)
    private Clinica clinica;

    @Size(max = 100)
    @Column(name = "email_usuario", length = 100, unique = true, nullable = false)
    @NotNull
    @Email
    private String emailUsuario;

    @Column(name = "telefone_usuario", length = 15)
    private String telefoneUsuario;

    private


}
