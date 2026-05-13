package com.thotran.fooddelivery.service.imp;

import com.thotran.fooddelivery.payload.request.OrderRequest;

public interface OrderServiceImp {
    boolean insertOrder(OrderRequest orderRequest);
}
