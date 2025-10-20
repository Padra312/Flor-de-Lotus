package com.project.site.controllers;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.project.site.entities.Category;
import com.project.site.repositories.CategoryRepository;


@RestController
@RequestMapping("/api/massagens")
public class ApiMassageController {
  @Autowired
  private CategoryRepository categoryRepository;
  @GetMapping
  public List<Category> listarProdutos() {
      return categoryRepository.findAll();
  }
}
