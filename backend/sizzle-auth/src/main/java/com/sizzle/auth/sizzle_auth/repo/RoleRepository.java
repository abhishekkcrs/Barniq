package com.sizzle.auth.sizzle_auth.repo;

import com.sizzle.auth.sizzle_auth.DTO.RoleEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface RoleRepository extends JpaRepository<RoleEntity, Long> {

    Optional<RoleEntity> findByRoleName(String roleName);

}
