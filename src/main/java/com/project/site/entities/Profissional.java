package com.project.site.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class Profissional {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idProfissional;
	@Column(nullable = false)
	private String nome;
	@Column(nullable = false)
	private String telefone;
	
	public Profissional() {
		super();
	}
	public Profissional(Long idProfissional, String nome, String telefone) {
		super();
		this.idProfissional = idProfissional;
		this.nome = nome;
		this.telefone = telefone;
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
	public String getTelefone() {
		return telefone;
	}
	public void setTelefone(String telefone) {
		this.telefone = telefone;
	}
	public void setId(Long id) {
		// TODO Auto-generated method stub
		
	}
	
}
