package com.onlinestore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onlinestore.dao.OsUserDao;
import com.onlinestore.model.OsUser;
import com.onlinestore.service.OsUserService;

@Service("osUserService")
@Transactional
public class OsUserServiceImpl implements OsUserService {

	@Autowired
	private OsUserDao userDao;
	
	public Integer createOsUser(OsUser osUser) {
		return (Integer) userDao.create(osUser);		
	}

	public List<OsUser> getOsUsers() {
		return userDao.getAll();
	}

	public OsUser getOsUser(Integer id) {
		return userDao.get(id);
	}

	public void updateOsUser(OsUser osUser) {
		userDao.update(osUser);
	}

	public void deleteOsUser(Integer id) {
		userDao.deleteById(id);
	}

	@Override
	public boolean isAdminUser(Integer id) {
		return userDao.isAdminUser(id);
	}

}
