package com.project.site.entities;

import jakarta.persistence.Id;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
public class Category {
	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    private Long id;
	    private String nome;
	    private String descricao;
	    private String imagemUrl;
		
	    public Category() {
			super();
		}

		public Category(Long id, String nome, String descricao, String imagemUrl) {
			super();
			this.id = id;
			this.nome = nome;
			this.descricao = descricao;
			this.imagemUrl = imagemUrl;
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

		public String getDescricao() {
			return descricao;
		}

		public void setDescricao(String descricao) {
			this.descricao = descricao;
		}

		public String getImagemUrl() {
			return imagemUrl;
		}

		public void setImagemUrl(String imagemUrl) {
			this.imagemUrl = imagemUrl;
		}
	    
	    
	    
}