package com.sena.test.service;

import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

import com.sena.test.Repository.RoleRepository;
import com.sena.test.dto.RoleDTO;
import com.sena.test.entity.Role;

@Service
public class RoleService {

    private final RoleRepository repository;

    public RoleService(RoleRepository repository) {
        this.repository = repository;
    }

    // Guardar
    public RoleDTO save(RoleDTO dto) {

        if (dto.getName() == null || dto.getName().isEmpty()) {
            throw new RuntimeException("El nombre del rol es obligatorio");
        }

        Role role = new Role();
        role.setName(dto.getName());
        role.setDescription(dto.getDescription());

        Role saved = repository.save(role);

        return convertToDTO(saved);
    }

    // Listar todos
    public List<RoleDTO> findAll() {
        return repository.findAll()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    // Buscar por id
    public RoleDTO findById(Integer id) {
        Role role = repository.findById(id).orElse(null);

        if (role == null) {
            return null;
        }

        return convertToDTO(role);
    }

    public RoleDTO update(Integer id, RoleDTO dto) {

    Role role = repository.findById(id).orElse(null);

    if (role == null) {
        return null;
    }

    role.setName(dto.getName());
    role.setDescription(dto.getDescription());

    Role updated = repository.save(role);

    return convertToDTO(updated);
}

    // Eliminar
    public void delete(Integer id) {
        repository.deleteById(id);
    }

    // Convertidor Entity → DTO
    private RoleDTO convertToDTO(Role role) {
        RoleDTO dto = new RoleDTO();
        dto.setId(role.getId());
        dto.setName(role.getName());
        dto.setDescription(role.getDescription());
        return dto;
    }
}