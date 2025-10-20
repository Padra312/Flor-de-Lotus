package com.project.site.repositories;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.project.site.entities.Massage;


@Repository
public interface MassageRepository extends JpaRepository<Massage, Long> {
    List<Massage> findByDescricaoContainingIgnoreCase(String descricao);
    List<Massage> findByProfissionalIdProfissional(Long idProfissional);
    List<Massage> findByDia(LocalDate dia);
    List<Massage> findByHora(LocalTime hora);
}
