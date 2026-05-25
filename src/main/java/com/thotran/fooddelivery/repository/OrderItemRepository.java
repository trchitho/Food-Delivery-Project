package com.thotran.fooddelivery.repository;

import com.thotran.fooddelivery.entity.OrderItem;
import com.thotran.fooddelivery.entity.keys.KeyOrderItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderItemRepository extends JpaRepository<OrderItem, KeyOrderItem> {
}
