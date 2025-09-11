package com.project.site.controllers;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.site.entities.User;
import com.project.site.repositories.UserRepository;

import jakarta.validation.Valid;
@Controller
@RequestMapping("/users")
public class UserController {
   @Autowired
   private UserRepository repository;
   // LISTAR
   @GetMapping
   public String listUsers(Model model) {
       model.addAttribute("users", repository.findAll());
       return "users/list";
   }
   // FORMULÁRIO DE CRIAÇÃO
   @GetMapping("/new")
   public String showAddForm(User user) {
       return "users/add-form";
   }
   // SALVAR (COM VALIDAÇÃO)
   @PostMapping("/save")
   public String saveUser(@Valid User user, BindingResult result, Model model) {
      
       if (result.hasErrors()) {
           return "users/add-form";
       }
      
       try {
           repository.save(user);
           return "redirect:/users";
          
       } catch (DataIntegrityViolationException e) {
           // CAPTURA O ERRO DE EMAIL DUPLICADO
           model.addAttribute("error", "Este email já está cadastrado! Use outro email.");
           return "users/add-form";
       } catch (Exception e) {
           // CAPTURA OUTROS ERROS INESPERADOS
           model.addAttribute("error", "Erro inesperado: " + e.getMessage());
           return "users/add-form";
       }
   }
   // EDITAR
   @GetMapping("/edit/{id}")
   public String showEditForm(@PathVariable Long id, Model model) {
       User user = repository.findById(id)
           .orElseThrow(() -> new IllegalArgumentException("ID inválido: " + id));
       model.addAttribute("user", user);
       return "users/edit-form";
   }
   // ATUALIZAR
   @PostMapping("/update/{id}")
   public String updateUser(@PathVariable Long id, @Valid User user,
                           BindingResult result, Model model) {
      
       if (result.hasErrors()) {
           return "users/edit-form";
       }
      
       try {
           user.setId(id);
           repository.save(user);
           return "redirect:/users";
          
       } catch (DataIntegrityViolationException e) {
           model.addAttribute("error", "Este email já está cadastrado! Use outro email.");
           model.addAttribute("user", user);
           return "users/edit-form";
       }
   }
   // EXCLUIR
   @GetMapping("/delete/{id}")
   public String deleteUser(@PathVariable Long id) {
       repository.deleteById(id);
       return "redirect:/users";
   }
   @GetMapping("/buscar")
	public String searchClientes(@RequestParam(name = "nome", required = false) String nome, Model model) {

		List<User> users;

		if (nome != null && !nome.trim().isEmpty()) {

			users = repository.findByNomeContaining(nome);
			model.addAttribute("termoBuscado", nome);
		} else {
			users = repository.findAll();
		}

		model.addAttribute("users", users);
		return "users/list";
	}
   
   
}
