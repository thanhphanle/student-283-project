package com.onlinestore.model;

// Generated Dec 2, 2014 6:41:20 PM by Hibernate Tools 3.4.0.CR1

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * CategoryProduct generated by hbm2java
 */
@Entity
@Table(name = "category_product", schema = "public")
public class CategoryProduct implements java.io.Serializable {

	private int id;
	private Product product;
	private Category category;

	public CategoryProduct() {
	}

	public CategoryProduct(int id) {
		this.id = id;
	}

	public CategoryProduct(int id, Product product, Category category) {
		this.id = id;
		this.product = product;
		this.category = category;
	}

	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue(strategy=IDENTITY)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "product_id")
	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "category_id")
	public Category getCategory() {
		return this.category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

}
