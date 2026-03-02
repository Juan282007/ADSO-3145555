package com.sena.test.dto.billDTO;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BillDetailDTO {
    
       private int id;

    private int productId;

    private int quantity;

    private double price;

    private double subtotal;

    private int billId;

}

