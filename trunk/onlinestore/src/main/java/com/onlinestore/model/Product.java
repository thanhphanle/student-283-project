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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Product generated by hbm2java
 */
@Entity
@Table(name = "product", schema = "public")
public class Product implements java.io.Serializable {

	private int id;
	private Price price;
	private Gallery gallery;
	private Promotion promotion;
	private Status status;
	private Producer producer;
	private String name;
	private String icon;
	private String description;
	private Date createDate;
	private Date writeDate;
	private Boolean active;
	private Set<OsOrderDetail> osOrderDetails = new HashSet<OsOrderDetail>(0);
	private Set<CartProduct> cartProducts = new HashSet<CartProduct>(0);
	private Set<CategoryProduct> categoryProducts = new HashSet<CategoryProduct>(
			0);

	public Product() {
	}

	public Product(int id) {
		this.id = id;
	}

	public Product(int id, Price price, Gallery gallery, Promotion promotion,
			Status status, Producer producer, String name, String icon,
			String description, Date createDate, Date writeDate,
			Boolean active, Set<OsOrderDetail> osOrderDetails,
			Set<CartProduct> cartProducts, Set<CategoryProduct> categoryProducts) {
		this.id = id;
		this.price = price;
		this.gallery = gallery;
		this.promotion = promotion;
		this.status = status;
		this.producer = producer;
		this.name = name;
		this.icon = icon;
		this.description = description;
		this.createDate = createDate;
		this.writeDate = writeDate;
		this.active = active;
		this.osOrderDetails = osOrderDetails;
		this.cartProducts = cartProducts;
		this.categoryProducts = categoryProducts;
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

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "price_id")
	public Price getPrice() {
		return this.price;
	}

	public void setPrice(Price price) {
		this.price = price;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "gallery_id")
	public Gallery getGallery() {
		return this.gallery;
	}

	public void setGallery(Gallery gallery) {
		this.gallery = gallery;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "promotion_id")
	public Promotion getPromotion() {
		return this.promotion;
	}

	public void setPromotion(Promotion promotion) {
		this.promotion = promotion;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "status_id")
	public Status getStatus() {
		return this.status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "producer_id")
	public Producer getProducer() {
		return this.producer;
	}

	public void setProducer(Producer producer) {
		this.producer = producer;
	}

	@Column(name = "name", length = 32)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "icon", length = 64)
	public String getIcon() {
		return this.icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@Column(name = "description", length = 256)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "product")
	public Set<OsOrderDetail> getOsOrderDetails() {
		return this.osOrderDetails;
	}

	public void setOsOrderDetails(Set<OsOrderDetail> osOrderDetails) {
		this.osOrderDetails = osOrderDetails;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "product")
	public Set<CartProduct> getCartProducts() {
		return this.cartProducts;
	}

	public void setCartProducts(Set<CartProduct> cartProducts) {
		this.cartProducts = cartProducts;
	}

	@OneToMany(fetch = FetchType.EAGER, mappedBy = "product")
	public Set<CategoryProduct> getCategoryProducts() {
		return this.categoryProducts;
	}

	public void setCategoryProducts(Set<CategoryProduct> categoryProducts) {
		this.categoryProducts = categoryProducts;
	}

}