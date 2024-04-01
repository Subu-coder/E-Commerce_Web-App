package com.org.daoImplementation;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Component;

import com.org.dao.SellerDao;
import com.org.dto.Items;
import com.org.dto.Product;
import com.org.dto.Seller;

@Component
public class SellerDaoImpl implements SellerDao {
	
	EntityManagerFactory emf = Persistence.createEntityManagerFactory("subham");
	EntityManager em = emf.createEntityManager();
	EntityTransaction et = em.getTransaction();

	@Override
	public void saveAndUpdateSeller(Seller seller) {
		et.begin();
		em.merge(seller);
		et.commit();
	}

	@Override
	public Seller fetchSellerByEmailAndPassword(String email, String password) {

		String jpql = "SELECT s FROM Seller s WHERE email=?1 AND password=?2";
		
		Query q = em.createQuery(jpql);
		q.setParameter(1, email);
		q.setParameter(2, password);
	
		List<Seller> s = q.getResultList();
		
		if(s.isEmpty()) {
			
			return null;
			
		}
			Seller seller = s.get(0);
			s.clear();
			
			return seller;
		
	}

	@Override
	public Seller fetchSellerById(int id) {

		return em.find(Seller.class, id);
		
	}

	@Override
	public boolean fetchSellerByEmail(String email) {

		String jpql = "SELECT s FROM Seller s WHERE email=?1";
		
		Query q = em.createQuery(jpql);
		q.setParameter(1, email);
		List<Seller> seller = q.getResultList();
		
		if(seller.isEmpty())
			return false;
		
		return true;
		
	}

	@Override
	public void removeSeller(Seller seller) {
		// TODO Auto-generated method stub
		et.begin();
		
		List<Product> products = seller.getProducts();
		
		for (Product product: products) {
			em.remove(product);
		}
		
		em.remove(seller);
		et.commit();
		
	}

}
