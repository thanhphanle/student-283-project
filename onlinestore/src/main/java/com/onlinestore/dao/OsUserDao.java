package com.onlinestore.dao;

import com.onlinestore.model.OsUser;

public interface OsUserDao extends Dao<OsUser>{
	OsUser getOsUser(String userName);
	
	boolean isAdminUser(Integer id);
}
