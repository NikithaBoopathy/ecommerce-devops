package com.example.product.service.controller;

import com.example.product.service.entity.Product;
import com.example.product.service.service.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/products")
@RequiredArgsConstructor
public class ProductController {

  private final ProductService service;

  @PostMapping
  public Product create(@RequestBody Product obj) {
    return service.create(obj);
  }

  @GetMapping
  public List<Product> getAll() {
    return service.getAll();
  }
}
