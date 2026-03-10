package com.sena.test.IRepository.IBillRepository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.sena.test.entity.bill.BillDetail;

public interface BillDetailRepository extends JpaRepository<BillDetail, Integer> {

    
}
