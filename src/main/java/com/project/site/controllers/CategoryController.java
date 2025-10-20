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

import com.project.site.entities.Category;
import com.project.site.repositories.CategoryRepository;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/categories")
public class CategoryController {
   @Autowired
   private CategoryRepository categoryRepository;
   
   @GetMapping
   public String listCategories(Model model) {
       List<Category> categories = categoryRepository.findAll();
       model.addAttribute("categories", categories);
       return "categories/list";
   }
   @GetMapping("/new")
   public String showAddForm(Model model) {
       model.addAttribute("category", new Category());
       return "categories/add-form";  // ← Alterado para add-form
   }
   @PostMapping("/save")
   public String saveCategory(@Valid Category category,
                             BindingResult result,
                             Model model) {
      
       if (result.hasErrors()) {
           return "categories/add-form"; 
       }
      
       try {
           categoryRepository.save(category);
           return "redirect:/categories?success=true";
          
       } catch (DataIntegrityViolationException e) {
           model.addAttribute("error", "Já existe uma categoria com este nome!");
           return "categories/add-form";  
       }
   }
   @GetMapping("/edit/{id}")
   public String showEditForm(@PathVariable Long id, Model model) {
       Category category = categoryRepository.findById(id)
           .orElseThrow(() -> new IllegalArgumentException("Categoria inválida: " + id));
      
       model.addAttribute("category", category);
       return "categories/edit-form";  
   }
   @PostMapping("/update/{id}")
   public String updateCategory(@PathVariable Long id,
                               @Valid Category category,
                               BindingResult result,
                               Model model) {
      
       if (result.hasErrors()) {
           return "categories/edit-form";  
       }
      
       try {
           category.setId(id);
           categoryRepository.save(category);
           return "redirect:/categories?updateSuccess=true";
          
       } catch (DataIntegrityViolationException e) {
           model.addAttribute("error", "Já existe uma categoria com este nome!");
           model.addAttribute("category", category);
           return "categories/edit-form";  // ← Volta para edit-form
       }
   }
   @GetMapping("/delete/{id}")
   public String deleteCategory(@PathVariable Long id) {
       if (categoryRepository.existsById(id)) {
           categoryRepository.deleteById(id);
           return "redirect:/categories?deleteSuccess=true";
       }
       return "redirect:/categories?error=notFound";
   }
   @GetMapping("/search")
   public String searchCategories(@RequestParam(name = "nome", required = false) String nome,
                                 Model model) {
      
       List<Category> categories;
      
       if (nome != null && !nome.trim().isEmpty()) {
           categories = categoryRepository.findByNomeContaining(nome);
           model.addAttribute("termoBuscado", nome);
       } else {
           categories = categoryRepository.findAll();
       }
      
       model.addAttribute("categories", categories);
       return "categories/list";
   }
}


