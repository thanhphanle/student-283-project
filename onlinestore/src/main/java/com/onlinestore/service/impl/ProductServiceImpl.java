package com.onlinestore.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onlinestore.dao.ProductDao;
import com.onlinestore.model.Product;
import com.onlinestore.service.ProductService;

@Service("productService")
@Transactional
public class ProductServiceImpl implements ProductService {

	
	private ProductDao productDao;
	
	public void createProduct(Product product) {
		productDao.create(product);
	}

	public List<Product> getProducts() {
		return productDao.getAll();
	}

	public Product getProduct(Integer id) {
		return productDao.get(id);
	}

	public void updateProduct(Product product) {
		productDao.update(product);
	}

	public void deleteProduct(Integer id) {
		productDao.deleteById(id);
	}

}