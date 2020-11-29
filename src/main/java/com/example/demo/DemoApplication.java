package com.example.demo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import java.util.stream.Stream;

@Slf4j
@SpringBootApplication
public class DemoApplication {

  public static void main(String[] args) {
    SpringApplication.run(DemoApplication.class, args);
  }

  /* @Bean
  CommandLineRunner initDatabase(CustomerRepository repository) {

    return args -> {
      Stream.of(
              Customer.builder().firstName("Mozammal").lastName("Hossain").build(),
              Customer.builder().firstName("Javed").lastName("Amin").build())
          .forEach(repository::save);
    };
  }*/
}
