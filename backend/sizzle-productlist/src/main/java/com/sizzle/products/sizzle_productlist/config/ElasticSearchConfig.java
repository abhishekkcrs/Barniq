package com.sizzle.products.sizzle_productlist.config;

import org.apache.http.conn.ssl.TrustAllStrategy;
import org.apache.http.ssl.SSLContextBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.elasticsearch.client.ClientConfiguration;
import org.springframework.data.elasticsearch.client.elc.ElasticsearchConfiguration;
import org.springframework.data.elasticsearch.repository.config.EnableElasticsearchRepositories;

import javax.net.ssl.SSLContext;
import java.security.KeyManagementException;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;

//https://www.youtube.com/watch?v=lR21w0dBoso config file

@Configuration
@EnableElasticsearchRepositories(basePackages = "com.sizzle.products.sizzle_productlist")
public class ElasticSearchConfig extends ElasticsearchConfiguration {

    @Value("${spring.elasticsearch.username}")
    String username;

    @Value("${spring.elasticsearch.password}")
    String password;

    @Override
    public ClientConfiguration clientConfiguration() {
        try {
            return ClientConfiguration.builder()
                    .connectedToLocalhost()
                    .usingSsl(buildSSLContext())
                    .withBasicAuth(username,password)
                    .build();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
    private static SSLContext buildSSLContext() throws NoSuchAlgorithmException, KeyStoreException, KeyManagementException {
        try {
            return new SSLContextBuilder().loadTrustMaterial(null, TrustAllStrategy.INSTANCE).build();
        } catch (Exception e) {
            throw new RuntimeException();
        }
    }

}