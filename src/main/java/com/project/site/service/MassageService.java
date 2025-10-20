package com.project.site.service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.site.entities.Massage;
import com.project.site.repositories.MassageRepository;

@Service
public class MassageService {

    private final MassageRepository massageRepository;

    @Autowired
    public MassageService(MassageRepository massageRepository) {
        this.massageRepository = massageRepository;
    }

    public List<Massage> buscar(String cliente, Long profissionalId, LocalDate dia, LocalTime hora) {
        if (cliente != null && !cliente.isEmpty()) {
            return massageRepository.findByDescricaoContainingIgnoreCase(cliente);
        }
        if (profissionalId != null) {
            return massageRepository.findByProfissionalIdProfissional(profissionalId);
        }
        if (dia != null) {
            return massageRepository.findByDia(dia);
        }
        if (hora != null) {
            return massageRepository.findByHora(hora);
        }
        return massageRepository.findAll();
    }
}
