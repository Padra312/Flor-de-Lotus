package com.project.site.entities;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;

@Entity
public class Category {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@Column(nullable = false, unique = true)
	private String nome;
	
	@OneToMany(mappedBy="categoria", cascade = CascadeType.ALL)
	private List<Massage> massagens = new ArrayList<>();

	public Category() {
		super();
	}

	public Category(Long id, String nome, List<Massage> massagens) {
		super();
		this.id = id;
		this.nome = nome;
		this.massagens = massagens;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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
	
	

}
