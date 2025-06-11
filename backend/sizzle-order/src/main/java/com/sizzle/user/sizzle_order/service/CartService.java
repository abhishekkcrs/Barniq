package com.sizzle.user.sizzle_order.service;
import com.sizzle.user.sizzle_order.DTO.CartItemRequest;
import com.sizzle.user.sizzle_order.DTO.CartItemResponse;
import com.sizzle.user.sizzle_order.entites.CartItem;
import com.sizzle.user.sizzle_order.repository.CartItemRepository;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class CartService {

    private final CartItemRepository cartItemRepository;

    public CartService(CartItemRepository cartItemRepository) {
        this.cartItemRepository = cartItemRepository;
    }

    public List<CartItemResponse> getCartItems(Long userId) {
        List<CartItem> items = cartItemRepository.findByUserId(userId);

        List<Long> productIds = items.stream().map(CartItem::getProductId).toList();
        Map<Long, CartItemResponse.ProductInfo> productInfoMap = productServiceClient.getProductInfoBatch(productIds);

        return items.stream().map(item -> CartItemResponse.builder()
                .productId(item.getProductId())
                .vendorId(item.getVendorId())
                .quantity(item.getQuantity())
                .productInfo(productInfoMap.get(item.getProductId()))
                .build()).collect(Collectors.toList());
    }

    public void addOrUpdateCartItem(Long userId, CartItemRequest request) {
        CartItem item = cartItemRepository.findByUserIdAndProductId(userId, request.getProductId())
                .map(existing -> {
                    existing.setQuantity(existing.getQuantity() + request.getQuantity());
                    return existing;
                })
                .orElse(CartItem.builder()
                        .userId(userId)
                        .productId(request.getProductId())
                        .vendorId(request.getVendorId())
                        .quantity(request.getQuantity())
                        .build());

        cartItemRepository.save(item);
    }

    public void updateCartItemQuantity(Long userId, CartItemRequest request) {
        cartItemRepository.findByUserIdAndProductId(userId, request.getProductId())
                .ifPresent(item -> {
                    item.setQuantity(request.getQuantity());
                    cartItemRepository.save(item);
                });
    }

    public void removeCartItem(Long userId, Long productId) {
        cartItemRepository.deleteByUserIdAndProductId(userId, productId);
    }
}

