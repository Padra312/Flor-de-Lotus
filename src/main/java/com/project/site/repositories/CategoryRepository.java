package com.project.site.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.site.entities.Category;

public interface CategoryRepository extends JpaRepository<Category, Long>{
	 Optional<Category> findByNome(String nome);
	   List<Category> findByNomeContaining(String nome);
	}



