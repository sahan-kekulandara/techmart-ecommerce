package com.techmart.ejb.service;

import com.techmart.api.service.OrderService;
import com.techmart.core.dto.OrderDTO;
import com.techmart.core.dto.ShoppingCartDTO;
import com.techmart.core.dto.UserDTO;
import com.techmart.core.entity.Order;
import com.techmart.core.entity.OrderItem;
import com.techmart.core.entity.Product;
import com.techmart.core.entity.User;
import com.techmart.core.entity.UserAddress;
import com.techmart.core.enums.OrderStatus;
import com.techmart.core.mapper.OrderMapper;
import com.techmart.ejb.repository.*;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Stateless
public class OrderServiceBean implements OrderService {

    @Inject
    private OrderRepository orderRepository;

    @Inject
    private CartRepository cartRepository;
    @Inject
    private UserRepository userRepository;

    @Inject
    private UserAddressRepository userAddressRepository;

    @Inject
    private ProductRepository productRepository;

    @Inject
    private OrderMapper orderMapper;

    @Override
    public String processPaymentSuccess(ShoppingCartDTO cart, UserDTO userDto, String stripeSessionId, Long addressId) {
        // 1. Generate unique system order tracking identifier
        String orderId = "TM-" + System.currentTimeMillis() + "-" + userDto.getId();

        // 2. Fetch managed persistent entities safely through the OrderRepository boundary
        User managedUser = userRepository.findById(userDto.getId());
        UserAddress managedAddress = userAddressRepository.findByUserAddress(addressId);

        // 3. Initialize parent Order state context attributes
        Order order = new Order();
        order.setId(orderId);
        order.setUser(managedUser);
        order.setTotalAmount(cart.getTotalCartPrice());
        order.setStatus(OrderStatus.PAID);
        order.setStripeSessionId(stripeSessionId);
        order.setShippingAddress(managedAddress);
        order.setCreatedAt(LocalDateTime.now());

        // 4. Map volatile active ShoppingCart items into permanent historical OrderItems
        List<OrderItem> orderItems = new ArrayList<>();
        cart.getItems().forEach(cartItem -> {
            OrderItem item = new OrderItem();
            item.setOrder(order);

            // Lookup structural hardware item components through the repository
            Product product = productRepository.findById(cartItem.getProductId());
            item.setProduct(product);
            item.setQuantity(cartItem.getQuantity());

            // CRITICAL ENTERPRISE STEP: Freeze retail price to protect historical invoices
            item.setPriceAtPurchase(product.getPrice());

            orderItems.add(item);
        });

        // Bind mapped sub-item arrays back into the aggregate root container
        order.setItems(orderItems);

        // 5. Persist aggregate order data tree to relational records
        orderRepository.save(order);

        // 6. Purge volatile items from the active tray by delegating straight to the CartRepository
        cartRepository.clearCartItems(cart.getId());

        return orderId;
    }

    @Override
    public List<OrderDTO> getCustomerOrderHistory(Long userId) {
        if (userId == null) {
            throw new IllegalArgumentException("User context identity must be provided.");
        }
        List<Order> ordersByUserId = orderRepository.findOrdersByUserId(userId);
        return orderRepository.findOrdersByUserId(userId).stream()
                .map(orderMapper::toDTO)
                .collect(Collectors.toList());
    }
}