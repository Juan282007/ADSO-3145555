package com.sena.test.controller.billController;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.sena.test.entity.bill.Bill;
import com.sena.test.service.billService.BillService;

@RestController
@RequestMapping("/bills")
public class BillController {

    @Autowired
    private BillService billService;

    @GetMapping
    public List<Bill> findAll() {
        return billService.findAll();
    }

    @GetMapping("/{id}")
    public Bill findById(@PathVariable int id) {
        return billService.findById(id);
    }

    @PostMapping
    public Bill save(@RequestBody Bill bill) {
        return billService.save(bill);
    }

    @PutMapping("/{id}")
    public Bill update(@PathVariable int id, @RequestBody Bill bill) {
        return billService.update(id, bill);
    }

    @DeleteMapping("/{id}")
    public String delete(@PathVariable int id) {
        billService.delete(id);
        return "Bill borrado exitosamente.";
    }
}
