package com.onlinestore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onlinestore.dao.OsOrderDao;
import com.onlinestore.model.OsOrder;
import com.onlinestore.service.OsOrderService;

@Service("osOrderService")
@Transactional
public class OsOrderServiceImpl implements OsOrderService {

	
	private OsOrderDao orderDao;
	
	public void createOsOrder(OsOrder osOrder) {
		orderDao.create(osOrder);		
	}

	public List<OsOrder> getOsOrders() {
		return orderDao.getAll();
	}

	public OsOrder getOsOrder(Long id) {
		return orderDao.get(id);
	}

	public void updateOsOrder(OsOrder osOrder) {
		orderDao.update(osOrder);
	}

	public void deleteOsOrder(Long id) {
		orderDao.deleteById(id);
	}

}
