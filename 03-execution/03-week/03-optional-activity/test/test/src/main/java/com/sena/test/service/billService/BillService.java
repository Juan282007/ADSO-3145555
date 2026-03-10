package com.sena.test.service.billService;

import com.sena.test.Iservice.IBillService.IBillService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sena.test.entity.bill.Bill;
import com.sena.test.IRepository.IBillRepository.BillRepository;

@Service
public class BillService implements IBillService {

    @Autowired
    private BillRepository billRepository;

    @Override
    public List<Bill> findAll() {
        return billRepository.findAll();
    }

    @Override
    public Bill findById(int id) {
        return billRepository.findById(id).orElse(null);
    }

    @Override
    public Bill save(Bill bill) {
        return billRepository.save(bill);
    }

    @Override
    public Bill update(int id, Bill bill) {

        Bill existingBill = billRepository.findById(id).orElse(null);

        if (existingBill != null) {
            existingBill.setBillNumber(bill.getBillNumber());
            existingBill.setDate(bill.getDate());
            existingBill.setTotal(bill.getTotal());
            existingBill.setStatus(bill.getStatus());
            existingBill.setUser(bill.getUser());

            return billRepository.save(existingBill);
        }

        return null;
    }

    @Override
    public void delete(int id) {
        billRepository.deleteById(id);
    }
}
