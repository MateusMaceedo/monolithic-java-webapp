package com.aws.devessentials.service;

import com.aws.devessentials.dao.ProductDao;
import com.aws.devessentials.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLException;
import java.util.List;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    public List<Product> getAllProducts() {
        try {
            return this.productDao.getAllProducts();
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            throw new RuntimeException("Application ran into problems while loading the products");
        }
    }

    public void addProduct(final Product product) {
        try {
            this.productDao.addProduct(product);
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            throw new RuntimeException("Application ran into problems while adding a new product");
        }
    }
}
