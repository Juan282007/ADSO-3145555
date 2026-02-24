package com.sena.test.dto; 
// Paquete donde se encuentran los DTO (Data Transfer Object)
// Los DTO se usan para enviar y recibir datos sin exponer la entidad directamente

import lombok.Getter; // Genera automáticamente los métodos get()
import lombok.Setter; // Genera automáticamente los métodos set()

@Getter // Lombok crea todos los getters (getId, getName, etc.)
@Setter // Lombok crea todos los setters (setId, setName, etc.)
public class PersonDTO {

    private Integer id; 
    // Identificador de la persona
    // Se usa para buscar, actualizar o devolver el registro

    private String name; 
    // Nombre de la persona
    // Se envía desde el cliente y se guarda en la base de datos

    private String lastname; 
    // Apellido de la persona

    private int age; 
    // Edad de la persona
    // Es tipo primitivo (no acepta null)

    private String documentNumber; 
    // Número de documento (cédula, identificación, etc.)
}