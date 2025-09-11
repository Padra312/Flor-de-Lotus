package com.project.site.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.site.entities.Massage;


	public interface MassageRepository extends JpaRepository<Massage,Long> {
		 List<Massage> findByDescricaoContaining(String descricao);
		  

		   List<Massage> findByCategoriaId(Long categoriaId);
		   List<Massage> findByCategoriaNome(String categoriaNome);
		  

		   List<Massage> findByCategoriaIsNull();
		

}
