package com.techmart.core.entity;

import java.io.Serializable;

import com.techmart.core.enums.CartStatus;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

import java.time.LocalDateTime;

@Entity
@Table(name = "shopping_cart", indexes = {
        @Index(name = "idx_guest_token", columnList = "guest_token"),
        @Index(name = "idx_cart_status", columnList = "status")
})
@Getter
@Setter
@NoArgsConstructor
public class ShoppingCart implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = true)
    private User user;

    @Column(name = "guest_token", length = 255)
    private String guestToken;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private CartStatus status = CartStatus.ACTIVE;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt = LocalDateTime.now();

    @OneToMany(mappedBy = "shoppingCart", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<CartItem> items = new ArrayList<>();

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    public void addItem(CartItem item) {
        if (item != null) {
            this.items.add(item);
            item.setShoppingCart(this);
        }
    }

    public void removeItem(CartItem item) {
        if (item != null) {
            this.items.remove(item);
            item.setShoppingCart(null);
        }
    }

    public double getTotalCartPrice() {
        return this.items.stream()
                .filter(item -> item.getProduct() != null)
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();
    }
}
