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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.site.entities.User;
import com.project.site.repositories.UserRepository;

import jakarta.validation.Valid;

@Controller
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserRepository repository;

    /* ===============================
       LISTAR TODOS OS USUÁRIOS
    =============================== */
    @GetMapping
    public String listUsers(Model model) {
        model.addAttribute("users", repository.findAll());
        return "users/list";
    }

    /* ===============================
       FORMULÁRIO DE CRIAÇÃO (ADMIN)
    =============================== */
    @GetMapping("/new")
    public String showAddForm(User user) {
        return "users/add-form";
    }

    /* ===============================
       SALVAR (ADMIN)
    =============================== */
    @PostMapping("/save")
    public String saveUser(@Valid User user, BindingResult result, Model model) {

        if (result.hasErrors()) {
            return "users/add-form";
        }

        try {
            repository.save(user);
            return "redirect:/users";

        } catch (DataIntegrityViolationException e) {
            model.addAttribute("error", "Este email já está cadastrado! Use outro email.");
            return "users/add-form";
        } catch (Exception e) {
            model.addAttribute("error", "Erro inesperado: " + e.getMessage());
            return "users/add-form";
        }
    }

    /* ===============================
       EDITAR USUÁRIO
    =============================== */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        User user = repository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("ID inválido: " + id));
        model.addAttribute("user", user);
        return "users/edit-form";
    }

    /* ===============================
       ATUALIZAR USUÁRIO
    =============================== */
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

    /* ===============================
       EXCLUIR USUÁRIO
    =============================== */
    @GetMapping("/delete/{id}")
    public String deleteUser(@PathVariable Long id) {
        repository.deleteById(id);
        return "redirect:/users";
    }

    /* ===============================
       BUSCAR POR NOME
    =============================== */
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

    /* ===============================
       CADASTRO DE NOVO USUÁRIO (REGISTER)
    =============================== */
    @GetMapping("/register")
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());
        return "register"; // Exibe register.html
    }

    @PostMapping("/register")
    public String processRegister(@RequestParam String nome,
                                  @RequestParam String email,
                                  @RequestParam String senha,
                                  @RequestParam String confirmarSenha,
                                  RedirectAttributes redirectAttributes) {

        if (!senha.equals(confirmarSenha)) {
            redirectAttributes.addAttribute("error", "password_mismatch");
            return "redirect:/users/register";
        }

        // Verifica se o e-mail já existe
        if (repository.findByEmail(email).isPresent()) {
            redirectAttributes.addAttribute("error", "email_exists");
            return "redirect:/users/register";
        }

        try {
            User newUser = new User();
            newUser.setNome(nome);
            newUser.setEmail(email);
            newUser.setSenha(senha); // lembre-se de criptografar depois!
            repository.save(newUser);

            redirectAttributes.addAttribute("success", true);
            return "redirect:/users/register";

        } catch (Exception e) {
            redirectAttributes.addAttribute("error", "unexpected");
            return "redirect:/users/register";
        }
    }
}
