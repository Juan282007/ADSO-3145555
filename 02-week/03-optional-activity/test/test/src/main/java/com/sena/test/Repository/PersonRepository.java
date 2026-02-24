package com.sena.test.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.entity.Person;

/**
 * Repositorio para la entidad Person.
 *
 * Esta interfaz extiende JpaRepository, lo que permite
 * acceder automáticamente a los métodos CRUD sin necesidad
 * de implementarlos manualmente.
 *
 * Significa:
 * - Person → Es la entidad que manejará este repositorio.
 * - Integer → Es el tipo de dato de la clave primaria (id).
**/

public interface PersonRepository extends JpaRepository<Person, Integer> {

}
