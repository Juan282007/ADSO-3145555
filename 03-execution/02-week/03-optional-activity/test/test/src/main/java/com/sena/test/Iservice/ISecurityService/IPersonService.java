package com.sena.test.Iservice.ISecurityService;

import java.util.List;
import com.sena.test.entity.security.Person;

public interface IPersonService {

    List<Person> findAll();

    Person findById(int id);

    Person save(Person person);

    Person update(int id, Person person);

    void delete(int id);
}
