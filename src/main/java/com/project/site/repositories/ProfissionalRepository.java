package com.project.site.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.site.entities.Profissional;

public interface ProfissionalRepository extends JpaRepository<Profissional, Long>{
	 Optional<Profissional> findByNome(String nome);
	   List<Profissional> findByNomeContaining(String nome);
	}



