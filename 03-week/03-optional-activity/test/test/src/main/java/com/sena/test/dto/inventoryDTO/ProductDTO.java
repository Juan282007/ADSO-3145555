package com.sena.test.dto.inventoryDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class ProductDTO {

    private int id;
    private String name;
    private String description;
    private int categoryId;

}