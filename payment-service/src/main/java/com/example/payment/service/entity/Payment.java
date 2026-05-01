package com.example.payment.service.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "payments") 
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Payment {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private Long orderId;
    private Double amount;
    private String paymentStatus;
}
