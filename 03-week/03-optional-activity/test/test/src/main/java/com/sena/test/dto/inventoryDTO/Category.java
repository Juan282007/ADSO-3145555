package com.sena.test.dto.inventoryDTO;


import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class Category {

    private int productId;
    private int quantity;
    private double price;
    private double subtotal;
}
