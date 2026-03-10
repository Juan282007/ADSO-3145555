package com.sena.test.service.billService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.sena.test.entity.bill.BillDetail;
import com.sena.test.IRepository.IBillRepository.BillDetailRepository;
import com.sena.test.Iservice.IBillService.IBillDetailService;

@Service
public class BillDetailService implements IBillDetailService {

    private final BillDetailRepository billDetailRepository;

    public BillDetailService(BillDetailRepository billDetailRepository) {
        this.billDetailRepository = billDetailRepository;
    }

    @Override
    public List<BillDetail> findAll() {
        return billDetailRepository.findAll();
    }

    @Override
    public BillDetail findById(int id) {
        return billDetailRepository.findById(id).orElse(null);
    }

    @Override
    public BillDetail save(BillDetail detail) {

        //Calcular subtotal automáticamente
        detail.setSubtotal(detail.getQuantity() * detail.getPrice());

        return billDetailRepository.save(detail);
    }

    @Override
    public BillDetail update(int id, BillDetail detail) {

        BillDetail existing = billDetailRepository.findById(id).orElse(null);

        if (existing != null) {
            existing.setQuantity(detail.getQuantity());
            existing.setPrice(detail.getPrice());
            existing.setSubtotal(detail.getQuantity() * detail.getPrice());
            existing.setProduct(detail.getProduct());
            existing.setBill(detail.getBill());

            return billDetailRepository.save(existing);
        }

        return null;
    }

    @Override
    public void delete(int id) {
        billDetailRepository.deleteById(id);
    }
}