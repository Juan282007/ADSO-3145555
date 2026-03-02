package com.sena.test.Iservice.IinventoryService;

import java.util.List;
import com.sena.test.entity.inventory.Product;

public interface IProductService {

    List<Product> findAll();

    Product findById(int id);

    Product save(Product product);

    Product update(int id, Product product);

    void delete(int id);
}
