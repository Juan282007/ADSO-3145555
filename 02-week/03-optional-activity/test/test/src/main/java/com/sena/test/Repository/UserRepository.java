package com.sena.test.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.sena.test.entity.User;

public interface UserRepository extends JpaRepository<User, Integer> {

}
 