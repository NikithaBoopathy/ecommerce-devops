package com.example.payment.service.controller;

import com.example.payment.service.entity.Payment;
import com.example.payment.service.service.PaymentService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/payments")
@RequiredArgsConstructor
public class PaymentController {

  private final PaymentService service;

  @PostMapping
  public Payment create(@RequestBody Payment obj) {
    return service.create(obj);
  }

  @GetMapping
  public List<Payment> getAll() {
    return service.getAll();
  }
}
