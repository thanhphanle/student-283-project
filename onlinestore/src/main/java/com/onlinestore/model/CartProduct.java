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
 * CartProduct generated by hbm2java
 */
@Entity
@Table(name = "cart_product", schema = "public")
public class CartProduct implements java.io.Serializable {

	private int id;
	private Cart cart;
	private Product product;

	public CartProduct() {
	}

	public CartProduct(int id) {
		this.id = id;
	}

	public CartProduct(int id, Cart cart, Product product) {
		this.id = id;
		this.cart = cart;
		this.product = product;
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
	@JoinColumn(name = "cart_id")
	public Cart getCart() {
		return this.cart;
	}

	public void setCart(Cart cart) {
		this.cart = cart;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "product_id")
	public Product getProduct() {
		return this.product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

}