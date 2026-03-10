package com.sena.test.Iservice.IinventoryService;

import java.util.List;
import com.sena.test.entity.inventory.Category;

public interface ICategoryService {

    List<Category> findAll();

    Category findById(int id);

    Category save(Category category);

    Category update(int id, Category category);

    void delete(int id);
}
