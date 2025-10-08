package com.project.site.controllers;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.site.entities.Category;
import com.project.site.entities.Massage;
import com.project.site.entities.Profissional;
import com.project.site.repositories.CategoryRepository;
import com.project.site.repositories.MassageRepository;
import com.project.site.repositories.ProfissionalRepository;
import com.project.site.service.MassageService;

import jakarta.validation.Valid;
@Controller
@RequestMapping("/massagens")
public class MassageController {
   @Autowired
   private MassageRepository repository;
   
   private MassageService massageService;
   
   @Autowired
   private ProfissionalRepository profissionalRepository;
  
   @Autowired
   private CategoryRepository categoryRepository;
   

   public MassageController(MassageService massageService, ProfissionalRepository profissionalRepository) {
       this.massageService = massageService;
       this.profissionalRepository = profissionalRepository;
   }
   @GetMapping
   public String listMassagens(Model model) {
       List<Massage> massagens = repository.findAll();
       model.addAttribute("profissionais", profissionalRepository.findAll());
       model.addAttribute("massagens", massagens);

       return "massagens/list";
   }
  
   @GetMapping("/buscar")
   public String buscar(
       @RequestParam(required = false) String cliente,
       @RequestParam(required = false) Long profissional,
       @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate dia,
       @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime hora,
       Model model) {

       List<Massage> resultados = massageService.buscar(cliente, profissional, dia, hora);
       model.addAttribute("massagens", resultados);
       model.addAttribute("profissionais", profissionalRepository.findAll());
       return "massagens/list";
   }

   
   @GetMapping("/new")
   public String showAddForm(Model model) {
       List<Category> categories = categoryRepository.findAll();
       List<Profissional> profissionais = profissionalRepository.findAll();
      
       model.addAttribute("massage", new Massage());
       model.addAttribute("categories", categories); // ⬅️ NOVO: Adiciona categorias ao modelo
       model.addAttribute("profissional", new Profissional());
       model.addAttribute("profissionais", profissionais);
       return "massagens/add-form";
   }
   @PostMapping("/save")
   public String saveMassage(@Valid @ModelAttribute Massage massage, BindingResult result, Model model) {
      

       if (result.hasErrors()) {
           model.addAttribute("categories", categoryRepository.findAll());
           return "massagens/add-form";
       }
      
       try {
           repository.save(massage);
           return "redirect:/massagens?success=true";
          
       } catch (DataIntegrityViolationException e) {
           model.addAttribute("error", "Erro ao salvar massagem. Verifique os dados.");
           model.addAttribute("categories", categoryRepository.findAll());
           return "massagens/add-form";
       }
   }
   @GetMapping("/edit/{id}")
   public String showEditForm(@PathVariable Long id, Model model) {
	   Massage massage = repository.findById(id)
               .orElseThrow(() -> new IllegalArgumentException("ID inválido:" + id));
      
       List<Category> categories = categoryRepository.findAll();
      
       model.addAttribute("massage", massage);
       model.addAttribute("categories", categories); 
       model.addAttribute("profissionais", profissionalRepository.findAll());
       return "massagens/edit-form";
   }
   @PostMapping("/update/{id}")
   public String updateMassage(@PathVariable Long id, @Valid @ModelAttribute Massage massage,
                              BindingResult result, Model model) {
      
       if (result.hasErrors()) {
           model.addAttribute("categories", categoryRepository.findAll());
           return "massagens/edit-form";
       }
      
       try {
    	   massage.setIdMassagem(id);
           repository.save(massage);
           return "redirect:/massagens?updateSuccess=true";
          
       } catch (DataIntegrityViolationException e) {
           model.addAttribute("error", "Erro ao atualizar massagem. Verifique os dados.");
           model.addAttribute("categories", categoryRepository.findAll());
           return "massagens/edit-form";
       }
   }
   @GetMapping("/delete/{id}")
   public String deleteMassage(@PathVariable Long id) {
       repository.deleteById(id);
       return "redirect:/massagens?deleteSuccess=true";
   }
}
