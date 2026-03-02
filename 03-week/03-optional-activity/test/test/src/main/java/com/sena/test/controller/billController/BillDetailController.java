package com.sena.test.controller.billController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.sena.test.entity.bill.BillDetail;
import com.sena.test.service.billService.BillDetailService;

@RestController
@RequestMapping("/bill-details")

public class BillDetailController {

    @Autowired
    private BillDetailService billDetailService;

    @GetMapping
    public List<BillDetail> findAll() {
        return billDetailService.findAll();
    }

    @GetMapping("/{id}")
    public BillDetail findById(@PathVariable int id) {
        return billDetailService.findById(id);
    }

    @PostMapping
    public BillDetail save(@RequestBody BillDetail detail) {
        return billDetailService.save(detail);
    }

    @PutMapping("/{id}")
    public BillDetail update(@PathVariable int id, @RequestBody BillDetail detail) {
        return billDetailService.update(id, detail);
    }

    @DeleteMapping("/{id}")
    public String delete(@PathVariable int id) {
        billDetailService.delete(id);
        return "Detalles de Bill borrados exitosamente";
    }
}
