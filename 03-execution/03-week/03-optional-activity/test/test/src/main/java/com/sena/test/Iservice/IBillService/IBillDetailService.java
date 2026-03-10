package com.sena.test.Iservice.IBillService;

import java.util.List;
import com.sena.test.entity.bill.BillDetail;

public interface IBillDetailService {

    List<BillDetail> findAll();

    BillDetail findById(int id);

    BillDetail save(BillDetail detail);

    BillDetail update(int id, BillDetail detail);

    void delete(int id);
}
