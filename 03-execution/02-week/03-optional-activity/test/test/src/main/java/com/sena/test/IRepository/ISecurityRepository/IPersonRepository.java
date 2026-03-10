package com.sena.test.IRepository.ISecurityRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.entity.security.Person;

public interface IPersonRepository extends JpaRepository<Person, Integer> {

}
