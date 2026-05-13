package com.thotran.fooddelivery.repository;

import com.thotran.fooddelivery.entity.Roles;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepository extends JpaRepository<Roles, Integer> {
}
