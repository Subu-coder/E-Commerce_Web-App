package com.org.daoImplementation;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Component;

import com.org.dao.ItemsDao;
import com.org.dto.Customer;
import com.org.dto.Items;
import com.org.dto.Product;
import com.org.dto.Seller;

@Component
public class ItemsDaoImpl implements ItemsDao {
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("subham");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();

	@Override
	public void addItems(Items item) {
		et.begin();
		em.merge(item);
		et.commit();

	}

	@Override
	public Items fetchItemById(int id) {

		return em.find(Items.class, id);
		
	}

	@Override
	public List<Items> fetchAllItems() {

		String jpql = "SELECT items FROM Items items";
		
		Query q = em.createQuery(jpql);
		
		return q.getResultList();
		
	}
	
	@Override
	public void deleteItemById(int id) {
		Items item = em.find(Items.class, id);
		Customer customer = item.getCustomer();
		List<Items> items = customer.getItems();
		if(items!=null)
			items.remove(item);
	
		
		et.begin();
		em.merge(customer);
		em.remove(item);
		et.commit();
	}

	
	
}
