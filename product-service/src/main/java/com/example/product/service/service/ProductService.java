package com.example.product.service.service;

import com.example.product.service.entity.Product;
import com.example.product.service.repository.ProductRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProductService {

  private final ProductRepository repo;

  public Product create(Product obj) {
    return repo.save(obj);
  }

  public List<Product> getAll() {
    return repo.findAll();
  }
}
