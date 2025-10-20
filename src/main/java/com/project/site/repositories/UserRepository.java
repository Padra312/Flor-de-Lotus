package com.project.site.repositories;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.project.site.entities.User;

public interface UserRepository extends JpaRepository<User, Long> {
	  

	   Optional<User> findByEmail(String email);
	   List<User> findByNomeContaining(String nome);
	}
