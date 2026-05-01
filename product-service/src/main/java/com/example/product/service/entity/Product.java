package com.example.product.service.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "products") 
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
private String productName;
    private Double price;
    private Integer quantity;
}
