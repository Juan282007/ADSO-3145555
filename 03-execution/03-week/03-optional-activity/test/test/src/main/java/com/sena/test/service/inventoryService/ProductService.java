package com.sena.test.service.inventoryService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sena.test.entity.inventory.Product;
import com.sena.test.IRepository.IinventoryRepository.ProductRepository;
import com.sena.test.Iservice.IinventoryService.IProductService;

@Service
public class ProductService implements IProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public Product findById(int id) {
        return productRepository.findById(id).orElse(null);
    }

    @Override
    public Product save(Product product) {
        return productRepository.save(product);
    }

    @Override
    public Product update(int id, Product product) {

        Product existing = productRepository.findById(id).orElse(null);

        if (existing != null) {
            existing.setName(product.getName());
            existing.setDescription(product.getDescription());
            existing.setCategory(product.getCategory());
            existing.setPrice(product.getPrice());
            existing.setStock(product.getStock());

            return productRepository.save(existing);
        }

        return null;
    }

    @Override
    public void delete(int id) {
        productRepository.deleteById(id);
    }
}