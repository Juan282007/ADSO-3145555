package com.sena.test.Iservice.IBillService;

import java.util.List;
import com.sena.test.entity.bill.Bill;

public interface IBillService {

    List<Bill> findAll();

    Bill findById(int id);

    Bill save(Bill bill);

    Bill update(int id, Bill bill);

    void delete(int id);
}