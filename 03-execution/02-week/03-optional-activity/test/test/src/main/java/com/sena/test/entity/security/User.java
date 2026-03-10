package com.sena.test.entity.security;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.OneToOne;
import lombok.Getter;
import lombok.Setter;
import java.util.Set;

import jakarta.persistence.ManyToMany;

@Getter
@Setter

@Entity(name="users")

public class User {
	//anotación bean para id de la entidad
	@Id
	//anotación para autoincremental
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	//indicar que el campo es una columna
	@Column(name="id_user")
	private int id;
	
	@Column(name="username", length = 50)
	private String username;

	@Column(name="email", length = 50)
	private String email;

	@Column(name="password", length = 50)
	private String password;
	
	@OneToOne
	@JoinColumn(name="id_person")//name="nombre llave primaria"
	private Person person;

@ManyToMany
@JoinTable(
    name = "user_roles", // Nombre de la tabla intermedia que relaciona User y Role
    joinColumns = @JoinColumn(name = "id_user"), // Clave foránea que apunta a User
    inverseJoinColumns = @JoinColumn(name = "id_role") // Clave foránea que apunta a Role
)
private Set<Role> roles;


}
 