package com.org.daoImplementation;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Component;

import com.org.dao.CustomerDao;
import com.org.dto.Customer;
import com.org.dto.Items;
import com.org.dto.Seller;

@Component
public class CustomerDaoImpl implements CustomerDao {
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("subham");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();

	@Override
	public void saveAndUpdateCustomer(Customer customer) {
		et.begin();
		em.merge(customer);
		et.commit();
	}

	@Override
	public Customer fetchCustomerByEmailAndPassword(String email, String password) {
		
		String jpql = "SELECT c FROM Customer c WHERE email=?1 AND password=?2";
		
		Query query = em.createQuery(jpql);
		query.setParameter(1, email);
		query.setParameter(2, password);
		
		List<Customer> c = query.getResultList();
		if(c.isEmpty()) {
			return null;
		}
		Customer customer = c.get(0);
		c.clear();
		
		return customer;
	}

	@Override
	public Customer fetchCustomerById(int id) {

		return em.find(Customer.class, id);

	}

	@Override
	public boolean fetchCustomerByEmail(String email) {

		String jpql = "SELECT c FROM Customer c WHERE email=?1";
		
		Query q = em.createQuery(jpql);
		q.setParameter(1, email);
		List<Customer> customer = q.getResultList();
		
		if(customer.isEmpty())
			return false;
		
		return true;
		
	}

	@Override
	public void removeCustomer(Customer customer) {
		et.begin();
		
		List<Items> items = customer.getItems();
		
		if(items!=null)
			for (Items item : items) {
				em.remove(item);
			}
		em.remove(customer);
		
		
		et.commit();
	}

}
