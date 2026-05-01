package com.example.order.service.controller;

import com.example.order.service.entity.Order;
import com.example.order.service.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
@RequiredArgsConstructor
public class OrderController {

  private final OrderService service;

  @PostMapping
  public Order create(@RequestBody Order obj) {
    return service.create(obj);
  }

  @GetMapping
  public List<Order> getAll() {
    return service.getAll();
  }
}
