package com.onlinestore.model;

// Generated Dec 2, 2014 6:41:20 PM by Hibernate Tools 3.4.0.CR1

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Config generated by hbm2java
 */
@Entity
@Table(name = "config", schema = "public")
public class Config implements java.io.Serializable {

	private int id;
	private String name;
	private String dataType;
	private String value;
	private Date createDate;
	private Date writeDate;
	private Boolean active;

	public Config() {
	}

	public Config(int id) {
		this.id = id;
	}

	public Config(int id, String name, String dataType, String value,
			Date createDate, Date writeDate, Boolean active) {
		this.id = id;
		this.name = name;
		this.dataType = dataType;
		this.value = value;
		this.createDate = createDate;
		this.writeDate = writeDate;
		this.active = active;
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

	@Column(name = "name", length = 32)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "data_type", length = 32)
	public String getDataType() {
		return this.dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	@Column(name = "value", length = 32)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
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

}
