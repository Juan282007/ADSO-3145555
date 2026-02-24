package com.sena.test.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.entity.Role;

public interface RoleRepository extends JpaRepository<Role, Integer> {

}
