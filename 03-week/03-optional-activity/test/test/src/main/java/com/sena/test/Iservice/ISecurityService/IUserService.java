package com.sena.test.Iservice.ISecurityService;

import java.util.List;
import com.sena.test.entity.security.User;

public interface IUserService {

    List<User> findAll();

    User findById(int id);

    User save(User user);

    User update(int id, User user);

    void delete(int id);
}