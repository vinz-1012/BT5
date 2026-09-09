package com.example.demo.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "users")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, columnDefinition = "nvarchar(50)")
    private String username;

    @Column(nullable = false, columnDefinition = "nvarchar(255)")
    private String password;

    @Column(nullable = false, unique = true, columnDefinition = "nvarchar(100)")
    private String email;

    @Column(columnDefinition = "nvarchar(100)")
    private String fullName;

    @Column(length = 20)
    private String role;  // e.g. ADMIN, USER
}
