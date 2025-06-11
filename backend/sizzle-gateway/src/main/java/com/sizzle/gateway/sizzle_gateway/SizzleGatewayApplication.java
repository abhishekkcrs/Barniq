package com.sizzle.gateway.sizzle_gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

@SpringBootApplication
@EnableDiscoveryClient
public class SizzleGatewayApplication {

	public static void main(String[] args) {
		SpringApplication.run(SizzleGatewayApplication.class, args);
	}

}
