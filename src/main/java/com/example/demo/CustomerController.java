package com.example.demo;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping(path = "customers")
public class CustomerController {

  private final CustomerRepository customerRepository;

  @PostMapping()
  @ResponseBody
  public Customer addCustomer(@RequestBody Customer customer) {
    return customerRepository.save(customer);
  }

  @GetMapping()
  @ResponseBody
  public List<Customer> findAllCustomers() {
    return customerRepository.findAll();
  }
}
