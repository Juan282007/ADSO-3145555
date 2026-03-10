package com.sena.test.entity.bill;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.Setter;
import com.sena.test.entity.inventory.Product;



@Getter
@Setter
@Entity(name = "bill_details")
public class BillDetail {

    
     @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_bill_detail")
    private int id; 

    @Column(name = "quantity")
    private int quantity; 

    @Column(name = "price")
    private double price; 

    @Column(name = "subtotal")
    private double subtotal;

    @ManyToOne
    @JoinColumn(name = "id_product")
    private Product product; 

    @ManyToOne
    @JoinColumn(name = "id_bill", nullable = false)
    private Bill bill;

}
