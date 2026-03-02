package com.sena.test.entity.inventory;

import java.util.Set;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Entity (name = "categories")

public class Category {
    
@Id

@GeneratedValue(strategy = GenerationType.IDENTITY)
	
	@Column(name="id_category") 
	private int id;
	
	@Column(name="name", length = 50)
	private String name;
    
    @Column(name="description", length = 100)
    private String description;
    
	@OneToMany(mappedBy = "category")
    private Set<Product> products;
}
