package com.sena.test.IRepository.IBillRepository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.sena.test.entity.bill.Bill;

public interface BillRepository extends JpaRepository<Bill, Integer> {

    
}
