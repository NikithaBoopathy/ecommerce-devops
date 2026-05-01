package com.example.order.service.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "orders")  
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
private Long userId;
    private Long productId;
    private Integer quantity;
}
