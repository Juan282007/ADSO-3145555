package com.sena.test.entity; 
// Paquete donde están las entidades (clases que representan tablas en la base de datos)

import jakarta.persistence.Column; 
// Permite mapear atributos como columnas en la base de datos

import jakarta.persistence.Entity; 
// Indica que esta clase es una entidad JPA (se convierte en una tabla)

import jakarta.persistence.GeneratedValue; 
// Permite configurar cómo se genera el ID automáticamente

import jakarta.persistence.GenerationType; 
// Define la estrategia de generación del ID

import jakarta.persistence.Id; 
// Marca el campo como clave primaria (Primary Key)

import lombok.Getter; 
// Genera automáticamente todos los métodos get()

import lombok.Setter; 
// Genera automáticamente todos los métodos set()

@Getter // Lombok genera los getters automáticamente
@Setter // Lombok genera los setters automáticamente
@Entity(name="persons") 
// Indica que esta clase representa una tabla llamada "persons" en la base de datos
public class Person {

    // Anotación que indica que este campo es la clave primaria
	@Id
	
	// Indica que el ID será autoincremental en la base de datos
	// IDENTITY significa que la base de datos genera el valor automáticamente
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	// Define la columna en la base de datos
	@Column(name="id_person") 
	private int id;
	// Columna id_person en la tabla persons
	// Es la clave primaria
	// Es autoincremental

	@Column(name="name", length = 50)
	// name → nombre de la columna en la base de datos
	// length = 50 → máximo 50 caracteres
	private String name;
    // Guarda el nombre de la persona

    @Column(name="lastname", length = 30)
    // lastname → nombre de la columna
    // length = 30 → máximo 30 caracteres
    private String lastname;
    // Guarda el apellido

    @Column(name="age")
    // age → nombre de la columna
    // No tiene length porque es número
    private int age;
    // Guarda la edad de la persona

    @Column(name="document_number", length = 20)
    // document_number → nombre de la columna en la BD
    // length = 20 → máximo 20 caracteres
    private String documentNumber;
    // Guarda el número de documento
}
