package com.sena.test.service.inventoryService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sena.test.entity.inventory.Category;
import com.sena.test.IRepository.IinventoryRepository.CategoryRepository;
import com.sena.test.Iservice.IinventoryService.ICategoryService;

@Service
public class CategoryService implements ICategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    public Category findById(int id) {
        return categoryRepository.findById(id).orElse(null);
    }

    @Override
    public Category save(Category category) {
        return categoryRepository.save(category);
    }

    @Override
    public Category update(int id, Category category) {

        Category existing = categoryRepository.findById(id).orElse(null);

        if (existing != null) {
            existing.setName(category.getName());
            existing.setDescription(category.getDescription());
            return categoryRepository.save(existing);
        }

        return null;
    }

    @Override
    public void delete(int id) {
        categoryRepository.deleteById(id);
    }
}
