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

import com.project.site.entities.Profissional;
import com.project.site.repositories.ProfissionalRepository;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/profissionais")
public class ProfissionalController {
   @Autowired
   private ProfissionalRepository profissionalRepository;
   
   @GetMapping
   public String listProfissionais(Model model) {
       List<Profissional> profissionais = profissionalRepository.findAll();
       model.addAttribute("profissionais", profissionais);
       return "profissionais/list";
   }
   @GetMapping("/new")
   public String showAddForm(Model model) {
       model.addAttribute("profissional", new Profissional());
       return "profissionais/add-form";  // ← Alterado para add-form
   }
   @PostMapping("/save")
   public String saveProfissional(@Valid Profissional profissional,
                             BindingResult result,
                             Model model) {
      
       if (result.hasErrors()) {
           return "profissionais/add-form"; 
       }
      
       try {
    	   profissionalRepository.save(profissional);
           return "redirect:/profissionais?success=true";
          
       } catch (DataIntegrityViolationException e) {
           model.addAttribute("error", "Já existe uma Profissional com este nome!");
           return "profissionais/add-form";  
       }
   }
   @GetMapping("/edit/{id}")
   public String showEditForm(@PathVariable Long id, Model model) {
	   Profissional profissional = profissionalRepository.findById(id)
           .orElseThrow(() -> new IllegalArgumentException("Profissional inválida: " + id));
      
       model.addAttribute("profissional", profissional);
       return "profissionais/edit-form";  
   }
   @PostMapping("/update/{id}")
   public String updateProfissional(@PathVariable Long id, @Valid Profissional profissional, BindingResult result, Model model) {
      
       if (result.hasErrors()) {
           return "profissionais/edit-form";  
       }
      
       try {
    	   profissional.setId(id);
    	   profissionalRepository.save(profissional);
           return "redirect:/profissionais?updateSuccess=true";
          
       } catch (DataIntegrityViolationException e) {
           model.addAttribute("error", "Já existe uma Profissional com este nome!");
           model.addAttribute("profissional", profissional);
           return "profissionais/edit-form";  // ← Volta para edit-form
       }
   }
   @GetMapping("/delete/{id}")
   public String deleteProfissional(@PathVariable Long id) {
       if (profissionalRepository.existsById(id)) {
    	   profissionalRepository.deleteById(id);
           return "redirect:/profissionais?deleteSuccess=true";
       }
       return "redirect:/profissionais?error=notFound";
   }
   @GetMapping("/search")
   public String searchProfissionais(@RequestParam(name = "nome", required = false) String nome,
                                 Model model) {
      
       List<Profissional> profissionais;
      
       if (nome != null && !nome.trim().isEmpty()) {
    	   profissionais = profissionalRepository.findByNomeContaining(nome);
           model.addAttribute("termoBuscado", nome);
       } else {
    	   profissionais = profissionalRepository.findAll();
       }
      
       model.addAttribute("profissionais", profissionais);
       return "profissionais/list";
   }
}

