package com.sizzle.user.sizzle_user.repository;

import com.sizzle.user.sizzle_user.entites.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<RoleEntity, Long> {

    Optional<RoleEntity> findByRoleName(String roleName);

}
