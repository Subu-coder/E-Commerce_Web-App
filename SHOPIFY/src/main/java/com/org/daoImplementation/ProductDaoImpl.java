package com.org.daoImplementation;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Component;

import com.org.dao.ProductDao;
import com.org.dto.Items;
import com.org.dto.Product;
import com.org.dto.Seller;

@Component
public class ProductDaoImpl implements ProductDao {
	
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("subham");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();

	@Override
	public void saveAndUpdateProduct(Product product) {
		et.begin();
		em.merge(product);
		et.commit();
	}

	@Override
	public Product fetchProductById(int id) {

		return em.find(Product.class, id);
	}

	@Override
	public List<Product> fetchAllProduct() {

		String jpql = "SELECT prod FROM Product prod";
		
		Query q = em.createQuery(jpql);
		
		return q.getResultList();
	}

	@Override
	public void deleteProductById(int id) {
		Product product = em.find(Product.class, id);
		Seller seller = product.getSeller();
		List<Product> products = seller.getProducts();
		
		if(products != null)
			products.remove(product);
		
		seller.setProducts(products);
		
		et.begin();
		em.merge(seller);
		em.remove(product);
		et.commit();
	}

	@Override
	public boolean fetchProductByNameCategoryAndDescription(String name,String category, String desc) {

		String jpql = "SELECT p FROM Product p WHERE name=?1 AND description=?2 AND category=?3";
		
		Query q = em.createQuery(jpql);
		q.setParameter(1, name);
		q.setParameter(2, desc);
		q.setParameter(3, category);
		
		List<Product> product = q.getResultList();
		
		if(product.isEmpty())
			return false;
		
		return true;
	}

}
