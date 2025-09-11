package com.project.site.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.project.site.entities.Massage;
import com.project.site.repositories.MassageRepository;

@Controller
public class HomeController {
   @Autowired
   private MassageRepository massageRepository;
   @GetMapping("/")
   public String homePage(Model model) {
       List<Massage> massagens = massageRepository.findAll();
       model.addAttribute("massagens", massagens);
       return "index"; // Retorna index.html
   }
}
