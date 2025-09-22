package com.project.site.controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.project.site.dto.BuscarUsersDTO;
import com.project.site.dto.UsersDTO;
import com.project.site.entities.User;
import com.project.site.repositories.UserRepository;

import ch.qos.logback.core.model.Model;


@RestController
@RequestMapping("/users")
public class UserController {
   @Autowired
   private UserRepository repository;
   
   // LISTAR
   @GetMapping("/buscar")
   public List<BuscarUsersDTO> listUsers() {
	   
      return repository.findAll().stream().map(u -> new BuscarUsersDTO(u.getId(), u.getNome(), u.getEmail())).toList();
   }
   // FORMULÁRIO DE CRIAÇÃO
   @GetMapping("/new")
   public String showAddForm(User user) {
       return "users/add-form";
   }
   // SALVAR (COM VALIDAÇÃO)
   @PostMapping("/save")
   public ResponseEntity saveUser(@RequestBody User user) {
	   
	  repository.save(user); 
	   
	  return ResponseEntity.ok().build();
	   
   }
   // EDITAR
   @GetMapping("/edit/{id}")
   public ResponseEntity showEditForm(@PathVariable Long id, Model model) {
       User user = repository.findById(id)
           .orElseThrow(() -> new IllegalArgumentException("ID inválido: " + id));
       model.addAttribute("user", user);
       return "users/edit-form";
   }
   // ATUALIZAR
   @PutMapping("/update/{id}")
   @Transactional
   public ResponseEntity updateUser(@PathVariable Long id,@RequestBody UsersDTO user) {
	   
	   Optional<User> idcheck = repository.findById(id);
	   if(idcheck.isEmpty()) {
		   return ResponseEntity.badRequest().build(); 
	   }
          User userUpdate = idcheck.get();
          
          if(user.email() != null && !user.email().isBlank()) {
        	  userUpdate.setEmail(user.email());
          }
          
          if(user.nome() != null && !user.nome().isBlank()) {
        	  userUpdate.setNome(user.nome());
          }
		   
		   repository.save(userUpdate);
		   return ResponseEntity.ok().build();
		   
   }
   // EXCLUIR
   @DeleteMapping("/delete/{id}")
   public ResponseEntity deleteUser(@PathVariable Long id) {
       repository.deleteById(id);
       return ResponseEntity.ok().build();
   }

   
   
}
