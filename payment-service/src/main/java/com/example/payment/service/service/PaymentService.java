package com.example.payment.service.service;

import com.example.payment.service.entity.Payment;
import com.example.payment.service.repository.PaymentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class PaymentService {

  private final PaymentRepository repo;

  public Payment create(Payment obj) {
    return repo.save(obj);
  }

  public List<Payment> getAll() {
    return repo.findAll();
  }
}
