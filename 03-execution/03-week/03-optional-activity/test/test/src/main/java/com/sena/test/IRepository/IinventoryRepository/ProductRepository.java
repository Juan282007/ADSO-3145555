package com.sena.test.IRepository.IinventoryRepository;


import org.springframework.data.jpa.repository.JpaRepository;
import com.sena.test.entity.inventory.Product;

public interface ProductRepository extends JpaRepository<Product, Integer> {
    
}