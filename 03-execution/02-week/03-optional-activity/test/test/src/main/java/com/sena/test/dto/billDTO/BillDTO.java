package com.sena.test.dto.billDTO;

import java.time.LocalDateTime;
import java.util.Set;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class BillDTO {
    
     private int id;

    private String billNumber;

    private LocalDateTime date;

    private double total;

    private String status;

    private int userId;

    private Set<BillDetailDTO> details;

   
}

