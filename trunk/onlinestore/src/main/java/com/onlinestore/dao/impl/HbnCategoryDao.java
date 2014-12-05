package com.onlinestore.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;






import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import com.onlinestore.dao.AbstractHbnDao;
import com.onlinestore.dao.CategoryDao;
import com.onlinestore.model.Category;
import com.onlinestore.model.Product;

@Repository
public class HbnCategoryDao extends AbstractHbnDao<Category> implements
		CategoryDao {
	
	@Override
	public List<Category> getSubCategory(Integer parent) {
		// TODO Auto-generated method stub
		String sql = "from Category where parentId=:Id";
		Query query = getSession().createQuery(sql);
		query.setParameter("Id", parent);
		return query.list();
	}

	@Override
	public boolean findCategoryWithName(String name) {
		// TODO Auto-generated method stub
		String sql ="from Category where name=:name";
		Query query = getSession().createQuery(sql);
		query.setParameter("name", name);
		
		if(query.list().size() > 0)
			return true;
		return false;
	}
	@Override
	public List<Product> getProductOfCategory(Integer idCategory) {
		// TODO Auto-generated method stub
		String sql = "select p from Product p, CategoryProduct cp where cp.category.id =:Id and cp.product.id = p.id";
		Query query = getSession().createQuery(sql);
		query.setParameter("Id", idCategory);
		System.out.print(query.list().size());
		return query.list();
		
	}
	
}