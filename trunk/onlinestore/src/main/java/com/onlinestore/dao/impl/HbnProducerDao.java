package com.onlinestore.dao.impl;

import org.springframework.stereotype.Repository;

import com.onlinestore.dao.AbstractHbnDao;
import com.onlinestore.dao.ProducerDao;
import com.onlinestore.model.Producer;

@Repository
public class HbnProducerDao extends AbstractHbnDao<Producer> implements ProducerDao{

}