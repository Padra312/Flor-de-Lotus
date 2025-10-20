package com.project.site.entities;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class Profissional {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @JsonIgnore
    private Long idProfissional;

    @Column(nullable = false)
    private String nome;


    @OneToMany(mappedBy = "profissional", cascade = CascadeType.ALL)
    private List<Massage> massagens = new ArrayList<>();

    public Profissional() {
        super();
    }

    public Profissional(Long idProfissional, String nome) {
        super();
        this.idProfissional = idProfissional;
        this.nome = nome;
    }

    public Long getIdProfissional() {
        return idProfissional;
    }

    public void setIdProfissional(Long idProfissional) {
        this.idProfissional = idProfissional;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }


    public List<Massage> getMassagens() {
        return massagens;
    }

    public void setMassagens(List<Massage> massagens) {
        this.massagens = massagens;
    }

	
	public void setId(Long id) {
		// TODO Auto-generated method stub	
 }
}
