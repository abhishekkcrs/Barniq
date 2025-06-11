package com.sizzle.products.sizzle_productlist.config;

import co.elastic.clients.elasticsearch.ElasticsearchClient;
import co.elastic.clients.elasticsearch.indices.CreateIndexRequest;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.FileNotFoundException;
import java.io.IOException;

@Component
@RequiredArgsConstructor
public class ElasticIndexCreator {

    private final ElasticsearchClient elasticsearchClient;

    private static final Logger log = LoggerFactory.getLogger(ElasticIndexCreator.class);

    @PostConstruct
    public void createProductIndex() throws IOException {
        boolean exists = elasticsearchClient.indices().exists(e -> e.index("grocery")).value();
        if (!exists) {
            elasticsearchClient.indices().create(CreateIndexRequest.of(c -> {
                        try {
                            return c
                                    .index("grocery")
                                    .withJson(new ClassPathResource("static/product_mapping.json").getInputStream());

                        } catch (Exception e) {
                            log.error(e.toString());
                            return null;
                        }
                    }
            ));
        }
    }
}
