package com.sizzle.user.sizzle_order.controllers;


import com.sizzle.user.sizzle_order.DTO.CartItemRequest;
import com.sizzle.user.sizzle_order.DTO.CartItemResponse;
import com.sizzle.user.sizzle_order.service.CartService;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/cart")
public class CartController {

    private final CartService cartService;

    public CartController(CartService cartService) {
        this.cartService = cartService;
    }

    @GetMapping
    public List<CartItemResponse> getCart(Authentication authentication) {
        Long userId = extractUserId(authentication);
        return cartService.getCartItems(userId);
    }

    @PostMapping
    public void addToCart(Authentication authentication, @RequestBody CartItemRequest request) {
        Long userId = extractUserId(authentication);
        cartService.addOrUpdateCartItem(userId, request);
    }

    @PutMapping
    public void updateQuantity(Authentication authentication, @RequestBody CartItemRequest request) {
        Long userId = extractUserId(authentication);
        cartService.updateCartItemQuantity(userId, request);
    }

    @DeleteMapping("/{productId}")
    public void removeFromCart(Authentication authentication, @PathVariable Long productId) {
        Long userId = extractUserId(authentication);
        cartService.removeCartItem(userId, productId);
    }

    private Long extractUserId(Authentication authentication) {
        // Assuming your Principal holds a UUID string (adapt as needed)
        Object principal = authentication.getPrincipal();
        if (principal instanceof String) {
            String userId= principal.toString();
            Long longUserId = Long.parseLong(userId);
        }
        throw new IllegalStateException("Invalid authentication principal");
    }
}
