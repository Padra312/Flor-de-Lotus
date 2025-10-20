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
   @GetMapping("/index")
   public String homePage(Model model) {
       List<Massage> massagens = massageRepository.findAll();
       model.addAttribute("massagens", massagens);
       return "index"; 
   }
   
   @GetMapping("/about")
   public String about() {
       return "about"; 
   }
   
   @GetMapping("/service")
   public String service() {
       return "service"; 
   }
   
   @GetMapping("/location")
   public String location() {
       return "location"; 
   }
   
   @GetMapping("/session_details")
   public String session_details() {
       return "session_details"; 
   }
}
