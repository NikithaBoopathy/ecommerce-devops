package com.example.user.service.service;

import com.example.user.service.entity.User;
import com.example.user.service.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

  private final UserRepository repo;

  public User create(User obj) {
    return repo.save(obj);
  }

  public List<User> getAll() {
    return repo.findAll();
  }
}
