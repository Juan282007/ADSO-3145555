package com.sena.test.entity.security;

import jakarta.persistence.*;

import java.util.Set;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

@Entity(name="roles")
public class Role {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_role")
    private int id;

    @Column(name="name", length = 50)
    private String name;

    @Column(name="description", length = 100)
    private String description;

@ManyToMany(mappedBy = "roles") // Relación Muchos a Muchos con la entidad User. 
                                // "mappedBy = roles" indica que esta entidad NO es la dueña 
                                // de la relación; el control está en el atributo "roles" 
                                // dentro de la clase User.

private Set<User> users;        // Colección de usuarios que tienen este rol.
                                // Set se usa para evitar duplicados.
                                // "users" representa todos los usuarios asociados a este rol.
}
