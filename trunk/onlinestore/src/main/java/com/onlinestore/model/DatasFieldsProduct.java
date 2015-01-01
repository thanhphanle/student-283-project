package com.onlinestore.model;

// Generated Dec 18, 2014 12:06:36 PM by Hibernate Tools 3.4.0.CR1

import java.io.Serializable;
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
 * DatasFieldsProduct generated by hbm2java
 */
@Entity
@Table(name = "datas_fields_product", schema = "public")
public class DatasFieldsProduct implements java.io.Serializable {

	private int id;
	private String serialData;
	private Date createDate;
	private Date writeDate;
	private Boolean active;
	private Set<Product> products = new HashSet<Product>(0);

	public DatasFieldsProduct() {
	}

	public DatasFieldsProduct(int id) {
		this.id = id;
	}

	public DatasFieldsProduct(int id, String serialData, Date createDate,
			Date writeDate, Boolean active, Set<Product> products) {
		this.id = id;
		this.serialData = serialData;
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

	@Column(name = "serial_data")
	public String getSerialData() {
		return this.serialData;
	}

	public void setSerialData(String serialData) {
		this.serialData = serialData;
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

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "datasFieldsProduct")
	public Set<Product> getProducts() {
		return this.products;
	}

	public void setProducts(Set<Product> products) {
		this.products = products;
	}

}