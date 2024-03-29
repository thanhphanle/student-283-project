package com.onlinestore.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.onlinestore.dao.ConfigDao;
import com.onlinestore.model.Config;
import com.onlinestore.service.ConfigService;

@Service("configService")
@Transactional
public class ConfigServiceImpl implements ConfigService{

	@Autowired
	private ConfigDao configDao;
	
	public Integer createConfig(Config config) {
		return (Integer) configDao.create(config);		
	}

	public List<Config> getConfigs() {
		return configDao.getAll();
	}

	public Config getConfig(Integer id) {
		return configDao.get(id);
	}

	public void updateConfig(Config config) {
		configDao.update(config);		
	}

	public void deleteConfig(Integer id) {
		configDao.deleteById(id);
	}
	
}
