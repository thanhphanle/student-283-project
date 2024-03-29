package com.onlinestore.model;

// Generated Dec 5, 2014 12:05:32 AM by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Price generated by hbm2java
 */
@Entity
@Table(name = "price", schema = "public")
public class Price implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2389137693349367234L;
	private int id;
	private Double price;
	private Date createDate;
	private Date writeDate;
	private Boolean active;
	private Set<Product> products = new HashSet<Product>(0);

	public Price() {
	}

	public Price(int id) {
		this.id = id;
	}

	public Price(int id, Double price, Date createDate, Date writeDate,
			Boolean active, Set<Product> products) {
		this.id = id;
		this.price = price;
		this.createDate = createDate;
		this.writeDate = writeDate;
		this.active = active;
		this.products = products;
	}

	@Id
	@Column(name = "id", unique = true, nullable = false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Column(name = "price", precision = 17, scale = 17)
	public Double getPrice() {
		return this.price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "create_date", length = 29)
	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "write_date", length = 29)
	public Date getWriteDate() {
		return this.writeDate;
	}

	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}

	@Column(name = "active")
	public Boolean getActive() {
		return this.active;
	}

	public void setActive(Boolean active) {
		this.active = active;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "price")
	public Set<Product> getProducts() {
		return this.products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

}
