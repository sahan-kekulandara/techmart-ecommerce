package com.techmart.core.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.io.Serializable;

@Entity
@Table(name = "user_address")
@Getter
@Setter
@NoArgsConstructor
public class UserAddress implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "address_line1", nullable = false, length = 150)
    private String addressLine1;

    @Column(name = "address_line2", length = 150)
    private String addressLine2;

    @Column(nullable = false, length = 50)
    private String city;

    @Column(name = "postal_code", nullable = false, length = 20)
    private String postalCode;


    @Column(name = "is_shipping", nullable = false)
    private Boolean isShipping = true;

    @Column(name = "is_billing", nullable = false)
    private Boolean isBilling = false;
}
