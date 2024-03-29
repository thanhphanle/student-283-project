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
 * UserGroup generated by hbm2java
 */
@Entity
@Table(name = "user_group", schema = "public")
public class UserGroup implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1408770505639210786L;
	private int id;
	private String name;
	private Date createDate;
	private Date writeDate;
	private Boolean active;
	private Set<OsUser> osUsers = new HashSet<OsUser>(0);

	public UserGroup() {
	}

	public UserGroup(int id) {
		this.id = id;
	}

	public UserGroup(int id, String name, Date createDate, Date writeDate,
			Boolean active, Set<OsUser> osUsers) {
		this.id = id;
		this.name = name;
		this.createDate = createDate;
		this.writeDate = writeDate;
		this.active = active;
		this.osUsers = osUsers;
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

	@Column(name = "name", length = 32)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
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

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "userGroup")
	public Set<OsUser> getOsUsers() {
		return this.osUsers;
	}

	public void setOsUsers(Set<OsUser> osUsers) {
		this.osUsers = osUsers;
	}

}
