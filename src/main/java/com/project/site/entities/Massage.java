package com.project.site.entities;

import jakarta.persistence.Id;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class Massage {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long idMassagem;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "categoria_id", referencedColumnName = "id", nullable = false)
	private Category categoria;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "profissional_id", referencedColumnName = "idProfissional", nullable = false)
	private Profissional profissional;
	@Column(nullable = false)
	private String descricao;
	@Column(nullable = false)
	private double valor;
	@Column(nullable = false)
	private String imagemUrl;
	
	public Massage() {
		super();
	}

	public Massage(Long idMassagem, Category categoria, Profissional profissional, String descricao, double valor,
			String imagemUrl) {
		super();
		this.idMassagem = idMassagem;
		this.categoria = categoria;
		this.profissional = profissional;
		this.descricao = descricao;
		this.valor = valor;
		this.imagemUrl = imagemUrl;
	}

	public Long getIdMassagem() {
		return idMassagem;
	}

	public void setIdMassagem(Long idMassagem) {
		this.idMassagem = idMassagem;
	}

	public Category getCategoria() {
		return categoria;
	}

	public void setCategoria(Category categoria) {
		this.categoria = categoria;
	}

	public Profissional getProfissional() {
		return profissional;
	}

	public void setProfissional(Profissional profissional) {
		this.profissional = profissional;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public double getValor() {
		return valor;
	}

	public void setValor(double valor) {
		this.valor = valor;
	}

	public String getImagemUrl() {
		return imagemUrl;
	}

	public void setImagemUrl(String imagemUrl) {
		this.imagemUrl = imagemUrl;
	}

	
}