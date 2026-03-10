package com.sena.test.controller.securityController; // Paquete donde están los controladores (capa que recibe las peticiones HTTP)

import org.springframework.web.bind.annotation.*; // Permite usar anotaciones REST como @GetMapping, @PostMapping, etc.
import java.util.List; // Permite trabajar con listas

import com.sena.test.dto.securityDTO.PersonDTO;
import com.sena.test.service.securityService.PersonService;

@RestController // Indica que esta clase es un controlador REST (devuelve JSON automáticamente)
@RequestMapping("/persons") // Ruta base para todos los endpoints → http://localhost:8080/persons
public class PersonController {

    private final PersonService service; 
    // Referencia al servicio que contiene la lógica del CRUD

    public PersonController(PersonService service) {
        this.service = service; 
        // Inyección por constructor (forma recomendada en Spring)
    }

    @PostMapping // Maneja peticiones HTTP POST → Crear
    public PersonDTO save(@RequestBody PersonDTO dto) {
        // @RequestBody convierte el JSON recibido en un objeto PersonDTO
        return service.save(dto); 
        // Llama al servicio para guardar y devuelve el resultado en JSON
    }

    @GetMapping // Maneja peticiones HTTP GET → Listar todos
    public List<PersonDTO> findAll() {
        return service.findAll(); 
        // Devuelve una lista de personas en formato JSON
    }

    @GetMapping("/{id}") // Maneja GET con parámetro en la URL → Buscar por id
    public PersonDTO findById(@PathVariable Integer id) {
        // @PathVariable captura el valor que viene en la URL
        // Ejemplo: /persons/1 → id = 1
        return service.findById(id); 
        // Llama al servicio para buscar la persona
    }

    @PutMapping("/{id}") // Maneja HTTP PUT → Actualizar
    public PersonDTO update(@PathVariable Integer id, @RequestBody PersonDTO personDTO) {
        // Recibe el ID desde la URL
        // Recibe los nuevos datos desde el body en formato JSON
        return service.update(id, personDTO); 
        // Llama al servicio para actualizar
    }

    @DeleteMapping("/{id}") // Maneja HTTP DELETE → Eliminar
    public void delete(@PathVariable Integer id) {
        service.delete(id); 
        // Elimina la persona por su ID
    }
}