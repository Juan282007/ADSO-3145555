package com.sena.test.IRepository.ISecurityRepository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.entity.security.Role;

public interface IRoleRepository extends JpaRepository<Role, Integer> {

}
