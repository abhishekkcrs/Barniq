package com.sizzle.products.sizzle_productlist.repo;

import com.sizzle.products.sizzle_productlist.entity.Product;
import org.springframework.data.elasticsearch.annotations.Query;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

import java.util.List;
//import org.springframework.stereotype.Repository;

//@Repository
public interface ProductRepo extends ElasticsearchRepository<Product,Long> {

    List<Product> findByNameLike(String name);

    @Query("{\"match\": {\"name\": {\"query\": \"?0\", \"fuzziness\": \"AUTO\"}}}")
    List<Product> fuzzySearchByName(String name);

}
