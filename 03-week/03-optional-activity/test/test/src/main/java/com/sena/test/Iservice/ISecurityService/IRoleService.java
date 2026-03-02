package com.sena.test.Iservice.ISecurityService;

import java.util.List;
import com.sena.test.entity.security.Role;

public interface IRoleService {

    List<Role> findAll();

    Role findById(int id);

    Role save(Role role);

    Role update(int id, Role role);

    void delete(int id);
}
