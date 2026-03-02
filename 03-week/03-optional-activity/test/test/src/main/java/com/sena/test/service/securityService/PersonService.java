package com.sena.test.service.securityService; // Paquete donde se encuentra la lógica de negocio (capa Service)

import java.util.List; // Permite usar listas
import java.util.stream.Collectors; // Permite convertir listas usando streams

import org.springframework.beans.factory.annotation.Autowired; // Permite inyectar dependencias automáticamente
import org.springframework.stereotype.Service; // Indica que esta clase es un servicio de Spring

import com.sena.test.IRepository.ISecurityRepository.IPersonRepository;
import com.sena.test.dto.securityDTO.PersonDTO;
import com.sena.test.entity.security.Person;

@Service // Marca esta clase como componente de lógica de negocio
public class PersonService {

    @Autowired // Inyecta automáticamente el repositorio
    private IPersonRepository personRepository; // Permite hacer operaciones CRUD en la tabla Person

    // Guardar
    public PersonDTO save(PersonDTO dto) { // Método para guardar una persona usando DTO

        if (dto.getName() == null || dto.getName().isEmpty()) { 
            throw new RuntimeException("El nombre es obligatorio"); // Validación básica
        }

        Person person = new Person(); // Se crea una nueva entidad

        person.setName(dto.getName()); // Se asigna el nombre del DTO a la entidad
        person.setLastname(dto.getLastname()); // Se asigna el apellido
        person.setAge(dto.getAge()); // Se asigna la edad
        person.setDocumentNumber(dto.getDocumentNumber()); // Se asigna el número de documento

        Person saved = personRepository.save(person); 
        // Guarda la entidad en la base de datos y devuelve el objeto persistido

        return convertToDTO(saved); 
        // Convierte la entidad guardada nuevamente a DTO para devolverla al controller
    }

    // Listar todos
    public List<PersonDTO> findAll() { // Devuelve todas las personas
        return personRepository.findAll() // Obtiene todas las entidades de la BD
                .stream() // Convierte la lista en stream, Un Stream permite transformar, filtrar y procesar datos de forma elegante.
                .map(this::convertToDTO) // Convierte cada entidad en DTO
                .collect(Collectors.toList()); // Devuelve una lista de DTO
    }

    // Buscar por id
    public PersonDTO findById(Integer id) { // Busca una persona por su ID
        Person person = personRepository.findById(id).orElse(null);
        // Busca por ID, si no existe devuelve null

        if (person == null) {
            return null; // Si no existe la persona, retorna null
        }

        return convertToDTO(person); // Convierte la entidad encontrada a DTO
    }

    // Actualizar
    public PersonDTO update(Integer id, PersonDTO dto) {

        Person person = personRepository.findById(id).orElse(null);
        // Busca la persona que se quiere actualizar

        if (person == null) {
            return null; // Si no existe, no se puede actualizar
        }

        person.setName(dto.getName()); // Actualiza el nombre
        person.setLastname(dto.getLastname()); // Actualiza el apellido
        person.setAge(dto.getAge()); // Actualiza la edad
        person.setDocumentNumber(dto.getDocumentNumber()); // Actualiza el documento

        Person updated = personRepository.save(person);
        // Guarda los cambios en la base de datos

        return convertToDTO(updated); 
        // Devuelve la persona actualizada convertida a DTO
    }

    // Eliminar
    public void delete(Integer id) { 
        personRepository.deleteById(id); 
        // Elimina la persona por su ID
    }

    // Convertidor privado Entity → DTO
    private PersonDTO convertToDTO(Person person) {
        PersonDTO dto = new PersonDTO(); // Crea un nuevo DTO

        dto.setId(person.getId()); // Copia el ID
        dto.setName(person.getName()); // Copia el nombre
        dto.setLastname(person.getLastname()); // Copia el apellido
        dto.setAge(person.getAge()); // Copia la edad
        dto.setDocumentNumber(person.getDocumentNumber()); // Copia el documento

        return dto; // Devuelve el DTO listo para enviar al controller
    }
}