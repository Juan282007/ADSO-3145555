package com.sena.test.service;

import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

import com.sena.test.Repository.UserRepository;
import com.sena.test.dto.UserDTO;
import com.sena.test.entity.User;

@Service
public class UserService {

    private final UserRepository repository;

    public UserService(UserRepository repository) {
        this.repository = repository;
    }

    // Guardar
    public UserDTO save(UserDTO dto) {

        User user = new User();
        user.setUsername(dto.getUsername());
        user.setEmail(dto.getEmail());

        User saved = repository.save(user);

        return convertToDTO(saved);
    }

    // Listar todos
    public List<UserDTO> findAll() {
        return repository.findAll()
                .stream()
                .map(this::convertToDTO)
                .collect(Collectors.toList());
    }

    // Buscar por id
    public UserDTO findById(Integer id) {
        return repository.findById(id)
                .map(this::convertToDTO)
                .orElse(null);
    }

    public UserDTO update(Integer id, UserDTO dto) {

    User user = repository.findById(id).orElse(null);

    if (user == null) {
        return null;
    }

    user.setUsername(dto.getUsername());
    user.setEmail(dto.getEmail());

    User updated = repository.save(user);

    return convertToDTO(updated);
}

    // Eliminar
    public void delete(Integer id) {
        repository.deleteById(id);
    }

    // Convertidor Entity → DTO
    private UserDTO convertToDTO(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        return dto;
    }
}