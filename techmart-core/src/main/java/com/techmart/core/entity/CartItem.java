package com.techmart.core.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "cart_line_item", uniqueConstraints = {
        @UniqueConstraint(name = "unique_cart_product", columnNames = {"cart_id", "product_id"})
})
@Getter
@Setter
@NoArgsConstructor
public class CartItem implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cart_id", nullable = false)
    private ShoppingCart shoppingCart;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    @Column(nullable = false)
    private Integer quantity = 1;

    @Column(name = "added_at", nullable = false, updatable = false)
    private LocalDateTime addedAt = LocalDateTime.now();
}