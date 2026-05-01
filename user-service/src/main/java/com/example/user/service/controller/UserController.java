package com.example.user.service.controller;

import com.example.user.service.entity.User;
import com.example.user.service.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
@RequiredArgsConstructor
public class UserController {

  private final UserService service;

  @PostMapping
  public User create(@RequestBody User obj) {
    return service.create(obj);
  }

  @GetMapping
  public List<User> getAll() {
    return service.getAll();
  }
}
