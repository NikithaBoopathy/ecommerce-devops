package com.example.order.service.service;

import com.example.order.service.entity.Order;
import com.example.order.service.repository.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

  private final OrderRepository repo;

  public Order create(Order obj) {
    return repo.save(obj);
  }

  public List<Order> getAll() {
    return repo.findAll();
  }
}
