package com.project.site.handlers;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import jakarta.persistence.EntityNotFoundException;


@ControllerAdvice
public class GlobalExceptionHandler {
	@ExceptionHandler(EntityNotFoundException.class)
	public String handleEntityNotFound(EntityNotFoundException ex, Model model) {
		model.addAttribute("error", "Recurso não encontrado: " + ex.getMessage());

		return "error/404";
	}
	@ExceptionHandler(IllegalArgumentException.class)
	public String handleIllegalArgument(IllegalArgumentException ex, Model model) {
		model.addAttribute("error", "Dados inválidos: " + ex.getMessage());

		return "error/400";
	}
	@ExceptionHandler(Exception.class)
	public String handleGenericException(Exception ex, Model model) {
		model.addAttribute("error", "Erro interno: " + ex.getMessage());
		return "error/500";
	}
}
