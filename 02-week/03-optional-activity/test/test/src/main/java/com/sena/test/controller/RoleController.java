package com.sena.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.sena.test.dto.RoleDTO;
import com.sena.test.service.RoleService;

@RestController
@RequestMapping("/roles")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @PostMapping
    public RoleDTO save(@RequestBody RoleDTO roleDTO) {
        return roleService.save(roleDTO);
    }

    @GetMapping
    public List<RoleDTO> findAll() {
        return roleService.findAll();
    }

    @GetMapping("/{id}")
    public RoleDTO findById(@PathVariable Integer id) {
        return roleService.findById(id);
    }

    @PutMapping("/{id}")
    public RoleDTO update(@PathVariable Integer id, @RequestBody RoleDTO roleDTO) {
    return roleService.update(id, roleDTO);
}

    @DeleteMapping("/{id}")
    public void delete(@PathVariable Integer id) {
        roleService.delete(id);
    }
}
