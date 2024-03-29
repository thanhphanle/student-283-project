package com.onlinestore.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Map.Entry;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.postgresql.util.Base64;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.util.SerializationUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.onlinestore.model.Category;
import com.onlinestore.model.CategoryProduct;
import com.onlinestore.model.FieldsProduct;
import com.onlinestore.model.Gallery;
import com.onlinestore.model.OsUser;
import com.onlinestore.model.Price;
import com.onlinestore.model.Producer;
import com.onlinestore.model.Product;
import com.onlinestore.model.Promotion;
import com.onlinestore.model.Status;
import com.onlinestore.service.CategoryService;
import com.onlinestore.service.FieldsProductService;
import com.onlinestore.service.impl.CategoryServiceImpl;
import com.onlinestore.service.impl.OsUserServiceImpl;
import com.onlinestore.util.Variable;

@Controller
public class CategoryController {
	
	private CategoryService getCategoryService()
	{
		ApplicationContext appCtx = 
	    		new ClassPathXmlApplicationContext("beans-service.xml");
		CategoryService categoryService = 
	    		(CategoryService)appCtx.getBean("categoryService");
	    return categoryService;
	}
	private FieldsProductService getFieldsProductService()
	{
		ApplicationContext appCtx = 
	    		new ClassPathXmlApplicationContext("beans-service.xml");
		FieldsProductService fieldsProductService = 
	    		(FieldsProductService)appCtx.getBean("fieldsProductService");
	    return fieldsProductService;
	}
	
	//load danh sach category
	@RequestMapping(value="/category", method = RequestMethod.GET)
	public void category(HttpServletRequest request,HttpServletResponse response )
	{
		
		String[] type = request.getParameterValues("type");
		String parent = request.getParameter("parent");
		int iParent = 0;
		String[] types = type[0].split(" ");
		
		if(parent.substring(0,1).equals("_"))
			iParent = Integer.parseInt(parent.substring(1,2)) - 1;
		else
			iParent = Integer.parseInt(parent);
		System.out.print(parent);
		List<HashMap> list = new ArrayList<HashMap>();
		
		for(int i=0; i <types.length; i++)
		{
			if(types[i].equals("categorys") || types[i].equals("category"))
			{
				List<Category> list_category = new ArrayList<Category>();
				list_category = getCategoryService().getSubCategory(iParent);
				if(list_category != null)
				{
					for(int j = 0; j < list_category.size(); j++)
					{
						HashMap<String, Object> meta = new HashMap<String, Object>();
						meta.put("title", list_category.get(j).getName());
						meta.put("key", list_category.get(j).getId());
						meta.put("extraClasses", "category hasmenu ");
						meta.put("lazy", true);
						list.add(meta);
					}
				}
			}
		}
		String json = new Gson().toJson(list);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//add new category vao cay thu muc
	@RequestMapping(value="/addSubCategory", method=RequestMethod.POST)
	public void addSubCategory(HttpServletRequest request, HttpServletResponse response,@ModelAttribute Category category)
	{
		Category newCate = new Category();
		HashMap<String, Object> meta = new HashMap<String, Object>();
		if(getCategoryService().findCategoryWithName(category.getName()))
		{
			meta.put("code", 0);
			meta.put("mess", "Tên thư mục đã tồn tại trên hệ thống !" );
		}
		else
		{
			newCate.setName(category.getName());
			newCate.setParentId(category.getParentId());
			getCategoryService().createCategory(newCate);
			
			meta.put("code", 1);
			meta.put("mess", "Thêm thư mục thành công");
		}
		
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	//delete category
	@RequestMapping(value = "/deleteCategory", method = RequestMethod.POST)
	public void deleteCategory(HttpServletRequest request, HttpServletResponse response)
	{
		HashMap<String, Object> meta = new HashMap<String, Object>();
		String id= request.getParameter("id");
		if(id != null)
		{
			getCategoryService().deleteCategory(Integer.parseInt(id));
			
			meta.put("code", 1);
			meta.put("mess", "Successful ddd new category");
		}
		else
			meta.put("code", 0);
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	//load danh sach product cua danh muc
	@RequestMapping(value="/loadProductOfCategory",method=RequestMethod.POST)
	public void loadCategory(HttpServletRequest request, HttpServletResponse response)
	{
		String id = request.getParameter("id");
		String page_number = request.getParameter("page_number");
		List<Product> list = new ArrayList<Product>();
		List<HashMap> listProduct = new ArrayList<HashMap>();
		list = getCategoryService().getProductOfCategory(Integer.parseInt(id),Integer.parseInt(page_number));
		int total_rows = getCategoryService().getTotalRow(Integer.parseInt(id));
		for(int i = 0; i < list.size(); i++)
		{
			HashMap<String,Object> product = new HashMap<String, Object>();
			product.put("id", list.get(i).getId());
			product.put("name", list.get(i).getName());
			product.put("description", list.get(i).getDescription());
			product.put("price", list.get(i).getPrice().getPrice());
			listProduct.add(product);
		}
		HashMap<String,Object> total_row = new HashMap<String, Object>();
		total_row.put("total_rows", total_rows);
		total_row.put("page_size",Variable.pageSize);
		listProduct.add(total_row);
		String json = new Gson().toJson(listProduct);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	//kiem tra thu muc co chua thu muc con hay ko
	@RequestMapping(value="/homeProductOfCategory",method=RequestMethod.POST)
	public void homeProductOfCategory(HttpServletRequest request, HttpServletResponse response)
	{
		String parent = request.getParameter("id");
		int iParent = 0;
		if(parent.substring(0,1).equals("_"))
			iParent = Integer.parseInt(parent.substring(1,2)) - 1;
		else
			iParent = Integer.parseInt(parent);
		List<Category> list = new ArrayList<Category>();
		HashMap meta = new HashMap();
		list = getCategoryService().getSubCategory(iParent);
		if(list.size() > 0)
		{
			meta.put("code", 1);
			meta.put("id", iParent);
		}
		else
		{
			meta.put("code", 0);
			meta.put("id", iParent);
		}
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping(value="/loadHomeProductOfCategory",method=RequestMethod.POST)
	public void loadHomeProductOfCategory(HttpServletRequest request, HttpServletResponse response)
	{
		ModelAndView view = new ModelAndView();
		String idCategory = request.getParameter("idCategory");
		String page_number = request.getParameter("page_number");
		List<Product> homeProducts = getCategoryService().getProductOfCategory(Integer.parseInt(idCategory),Integer.parseInt(page_number));
		int total_rows = getCategoryService().getTotalRow(Integer.parseInt(idCategory));
		List<HashMap<String, Object>> mapList = new ArrayList<HashMap<String, Object>>();

		request.setAttribute("message", "message");
		for (int i = 0; i < homeProducts.size(); i++) {
			HashMap<String, Object> meta = new HashMap<String, Object>();
			Product product = (Product) homeProducts.get(i);
			meta.put("id", product.getId());
			meta.put("name", product.getName());
			meta.put("icon", product.getIcon());
			meta.put("status", product.getStatus().getName());
			meta.put("price", product.getPrice().getPrice());
			meta.put("description", product.getDescription());
			mapList.add(meta);
		}
		HashMap<String, Object> paging = new HashMap<String, Object>();
		paging.put("total_rows", total_rows);
		paging.put("page_size", Variable.pageSize);
		mapList.add(paging);
		String json = new Gson().toJson(mapList);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	private boolean validateInput(Category category)
	{
		
		return true;
	}
	
	@RequestMapping(value="/addNewConfig", method = RequestMethod.POST)
	public void addNewConfig(HttpServletRequest request, HttpServletResponse response)
	{
		String groupName = request.getParameter("group_name");
		String identity = request.getParameter("identity_name");
		String fieldName = request.getParameter("field_name");
		int id = Integer.parseInt(request.getParameter("id"));
		FieldsProduct fields = getFieldsProductService().getField(id);
		HashMap<String,Object> meta = new HashMap<String,Object>();
		if(fields != null)
		{
			HashMap<String,Object> fieldsMap = new HashMap<String,Object>();
			HashMap<String,Object> fieldNew = new HashMap<String,Object>();
			byte[] data_fields = Base64.decode(fields.getSerialFields());
			fieldsMap = ( HashMap<String,Object>) SerializationUtils.deserialize(data_fields);
			fieldNew.put("field_name", "checked");
			fieldNew.put("group_name", groupName);
			fieldsMap.put(identity, fieldNew);
			
			byte[] new_data_fields = SerializationUtils.serialize(fieldsMap);
			String serial_fields = Base64.encodeBytes(new_data_fields);
			fields.setSerialFields(serial_fields);
			getFieldsProductService().updateFieldsProduct(fields);
			meta.put("code", 1);
		}
		else
		{
			meta.put("code", 0);
		}
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value ="/deleteField")
	public void deleteField(HttpServletRequest request, HttpServletResponse response)
	{
		String fieldName = request.getParameter("field_name");
		int id = Integer.parseInt(request.getParameter("field_id"));
		FieldsProduct fields = getFieldsProductService().getField(id);
		HashMap<String,Object> meta = new HashMap<String,Object>();
		if(fields != null)
		{
			HashMap<String,Object> fieldsMap = new HashMap<String,Object>();
			HashMap<String,Object> fieldNew = new HashMap<String,Object>();
			byte[] data_fields = Base64.decode(fields.getSerialFields());
			fieldsMap = ( HashMap<String,Object>) SerializationUtils.deserialize(data_fields);
			fieldsMap.remove(fieldName);
			byte[] new_data_fields = SerializationUtils.serialize(fieldsMap);
			String serial_fields = Base64.encodeBytes(new_data_fields);
			fields.setSerialFields(serial_fields);
			getFieldsProductService().updateFieldsProduct(fields);
			meta.put("code", 1);
		}
		else
		{
			meta.put("code",0);
		}
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping( value ="/saveConfig")
	public void saveConfig(HttpServletRequest request, HttpServletResponse response)
	{
		int fields_id = Integer.parseInt(request.getParameter("fields_id"));
		FieldsProduct fields = getFieldsProductService().getField(fields_id);
		HashMap<String,Object> meta = new HashMap<String,Object>();
		if(fields != null)
		{
			HashMap<String,Object> fieldsMap = new HashMap<String,Object>();
			byte[] data_fields = Base64.decode(fields.getSerialFields());
			fieldsMap = ( HashMap<String,Object>) SerializationUtils.deserialize(data_fields);
			for(Entry<String, Object> entry: fieldsMap.entrySet())
			{
				
				if(request.getParameter(""+entry.getKey()) != null)
				{
					
					HashMap<String,Object> field = ((HashMap<String,Object>)entry.getValue());
					field.put("field_name",request.getParameter(""+entry.getKey()) );
					//System.out.print();
					
				}
				else
				{
					HashMap<String,Object> field = ((HashMap<String,Object>)entry.getValue());
					if(field.get("group_name").toString().compareTo("General") == 0)
						field.put("field_name","" );
				}
			}System.out.print(fieldsMap);
			
			byte[] new_data_fields = SerializationUtils.serialize(fieldsMap);
			String serial_fields = Base64.encodeBytes(new_data_fields);
			fields.setSerialFields(serial_fields);
			getFieldsProductService().updateFieldsProduct(fields);
			meta.put("code", 1);
		}
		else
		{
			meta.put("code", 0);
		}
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping (value="/importCategory")
	public void importCategory(@RequestParam("myFile") MultipartFile file,HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		int parent_id;
		if(request.getParameter("category_id") != "")
		{
			parent_id = Integer.parseInt(request.getParameter("category_id"));
		}
		else
			parent_id = 0;
		BufferedReader br = null;
		try {
			br = new BufferedReader(
					new InputStreamReader(file.getInputStream()));
		} catch (FileNotFoundException e) {

			e.printStackTrace();
		}
		String line;
		try {
			br.readLine();
			while ((line = br.readLine()) != null) {
				String[] fields = line.split(",");
				if(!getCategoryService().findCategoryWithName(fields[0]))
				{
					Category category = new Category();
					category.setName(fields[0]);
					category.setParentId(parent_id);
					getCategoryService().createCategory(category);
				}
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		br.close();
		HashMap<String,Object> meta = new HashMap<String,Object>();
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@RequestMapping (value="/exportCategory")
	public void exportCategory(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		int category_id = Integer.parseInt(request.getParameter("category_id"));
		
		List<Category> list_category = new ArrayList<Category>();
		list_category = getCategoryService().getSubCategory(category_id);
		BufferedWriter br = new BufferedWriter(new OutputStreamWriter (new FileOutputStream("danh_sach_danh_muc.csv"),Charset.forName("UTF-8")));
		byte[] b1, b2,b3;
		String temp1, temp2,temp3;
		String sComma = ",";
		b3 = sComma.getBytes("UTF-8");
		temp3 = new String( b3);
		br.write("ID"+temp3);
		br.write("Name"+"\r\n");
		//br.write("Price"+"\r\n");
		for(int i = 0;i<list_category.size() ; i++)
		{
			b1=b2=null;
			temp1=temp2 = null;
			b1 = list_category.get(i).getName().getBytes("UTF-8");
			temp1 = new String(b1);
			br.write(list_category.get(i).getId()+temp3);
			br.write(temp1+temp3);
			br.write("\r\n");
			br.flush();
		}
		br.close();
		HashMap<String, Object> meta = new HashMap<String, Object>();
		String json = new Gson().toJson(meta);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().write(json);
		} catch (IOException e) {

			e.printStackTrace();
		}
	}
}
