package com.sena.test.entity.bill;

import java.time.LocalDateTime;
import java.util.Set;

import com.sena.test.entity.security.User;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity(name = "bills")
public class Bill {
    
@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_bill")
    private int id; 

    @Column(name = "bill_number", length = 50, nullable = false)
    private String billNumber; 
    @Column(name = "date", nullable = false)
    private LocalDateTime date; 

    @Column(name = "total", nullable = false)
    private double total;

    @Column(name = "status", length = 20)
    private String status; 

    @ManyToOne
    @JoinColumn(name = "id_user")
    private User user;

    @OneToMany(mappedBy = "bill", cascade = CascadeType.ALL)
    private Set<BillDetail> details; 


}
