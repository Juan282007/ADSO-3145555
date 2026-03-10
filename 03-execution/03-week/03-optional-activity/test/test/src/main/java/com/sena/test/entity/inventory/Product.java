package com.sena.test.entity.inventory;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Entity(name = "products")
public class Product {
    
    @Id

    @GeneratedValue(strategy = GenerationType.IDENTITY)

    @Column(name="id_product")
    private int id;

    @Column(name="name", length = 50)
    private String name;

    @Column(name="description", length = 100)
    private String description;

    @Column(name="price", nullable = false)
    private double price;

    @Column(name="stock", nullable = false)
    private int stock;

 @ManyToOne
    @JoinColumn(name = "id_category", nullable = false)
    private Category category;

}
