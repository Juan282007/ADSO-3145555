package com.sena.test.IRepository.IinventoryRepository;


import org.springframework.data.jpa.repository.JpaRepository;
import com.sena.test.entity.inventory.Category;

public interface CategoryRepository extends JpaRepository<Category, Integer>                    
{

    
}
