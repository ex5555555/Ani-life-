package tw.iii.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("productDao")
public class ProductDao implements IproductDao {

	@Autowired
	private SessionFactory sessionfactory;

	public ProductDao(SessionFactory sessionfactory) {
		this.sessionfactory = sessionfactory;
	}

	public Product getById(int productID) {
		Session session=sessionfactory.getCurrentSession();
		Product product =session.get(Product.class,productID);
		return product;
	}
	
	@Override
	public Product insert(Product PD) {
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class, PD.getProductID());

		if (product == null) {

			session.save(PD);
			System.out.println("Add Success !!");
			return PD;
		}
		return null;
	}

	@Override
	public boolean delete(int productID) {
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class, productID);

		if (product != null) {
			session.delete(product);
			return true;
		}
		return false;
	}


	@Override
	public Product update(Product PD) {
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class, PD.getProductID());
		if (product != null) {
			session.update(product);
		
		}
		

		return product;
	}

	@Override
	public Product select(int productID) {
		Session session = sessionfactory.getCurrentSession();
		Product product = session.get(Product.class, productID);
		return product;
	}
	
	
	@Override
	public List<Product> selectAll() {
		Session session = sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product", Product.class);
		return query.list();
	}
	

	
	@Override
	public List<Product> selectnone(int stock) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  stock like ?1",Product.class);
		query.setParameter(1,0);
		return query.list();
	}
	


	@Override
	public List<Product> selectbrand(String brand) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  brand like ?1",Product.class);
		query.setParameter(1,brand);
		return query.list();
	}
	
	@Override
	public List<Product> selectAllOpen() {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  status like ?1",Product.class);
		query.setParameter(1,"上架中");
		return query.list();
	}
	
	public List<Product> selectnameOpen(String productname){
		Session session=sessionfactory.getCurrentSession();
		StringBuffer sb=new StringBuffer();
		for(int i =0;i<productname.length();i++) {
			sb.append("%");
			sb.append(productname.charAt(i));
		}
		Query<Product> query = session.createQuery("from Product where  where  status='上架中' and productName like ?1",Product.class);
		query.setParameter(1, sb.toString());
		return query.list();
		
	}
	
	@Override
	public List<Product> selectbrandOpen(String brand) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  status=?1 and brand=?2",Product.class);
		query.setParameter(1,"上架中");
		query.setParameter(2,brand);
		return query.list();
	}
	
	@Override
	public List<Product> selectspeciesOpen(String species) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  status=?1 and species=?2",Product.class);
		query.setParameter(1,"上架中");
		query.setParameter(2,species);
		return query.list();
	}
	
	@Override
	public List<Product> selectclassOpen(String classification) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  status=?1 and classification=?2",Product.class);
		query.setParameter(1,"上架中");
		query.setParameter(2,classification);
		return query.list();
	}
	
	
	@Override
	public List<Product> selectwhereOpen(int max, int min) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query =session.createQuery("from Product where status=?1 and price between :xxx and :ooo",Product.class);
		query.setParameter("xxx",min);
		query.setParameter("ooo",max);
		query.setParameter(1,"上架中");	
		return query.list();
	}
	
	@Override
	public List<Product> selectclose(String status) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where  status like ?1",Product.class);
		query.setParameter(1,"下架中");
		return query.list();
	}
	
	@Override
	public List<Product> selectspecies(String species) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where species like ?1",Product.class);
		query.setParameter(1,species);
		return query.list();
	}
	

	@Override
	public List<Product> selectclass(String classification) {
		Session session=sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where classification like ?1",Product.class);
		query.setParameter(1,classification);
		return query.list();
	}

	@Override
	public List<Product> selectwhere(int max, int min) {
		Session session = sessionfactory.getCurrentSession();
		Query<Product> query = session.createQuery("from Product where price between :xxx and :ooo", Product.class);
		query.setParameter("xxx", min);
		query.setParameter("ooo", max);
		return query.list();
	}

	@Override
	public Object count() {
		Session session = sessionfactory.getCurrentSession();
		String hql = "select count(*) from Product";
		Object count = session.createQuery(hql).uniqueResult(); // uniqueResult()方法返回Object型別

		return count;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object countwhere(int max, int min) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*) from Product where price between :xxx and :ooo");
		query.setParameter("xxx",min);
		query.setParameter("ooo",max);
		Object count2  = query.uniqueResult();
		return count2;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object countbrand(String brand) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  brand like ?1");
		query.setParameter(1,brand);	
		Object count3  = query.uniqueResult();
		return count3;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object countspecies(String species) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  species like ?1");
		query.setParameter(1,species);	
		Object count4  = query.uniqueResult();
		return count4;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Object countclass(String classification) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  classification like ?1");
		query.setParameter(1,classification);	
		Object count5  = query.uniqueResult();
		return count5;
	}

	//缺貨
	@SuppressWarnings("unchecked")
	@Override
	public Object countnone(int stock) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  stock like ?1");
		query.setParameter(1,0);	
		Object count7  = query.uniqueResult();
		return count7;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Object countAllOpen() {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  status like ?1");
		query.setParameter(1,"上架中");	
		Object count7  = query.uniqueResult();
		return count7;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Object countbrandOpen(String brand) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  status=?1 and brand=?2");
		query.setParameter(1,"上架中");	
		query.setParameter(2, brand);
		Object count7  = query.uniqueResult();
		return count7;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Object countspeciesOpen(String species) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  status=?1 and species=?2");
		query.setParameter(1,"上架中");	
		query.setParameter(2, species);
		Object count7  = query.uniqueResult();
		return count7;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Object countclassOpen(String classification) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  status=?1 and classification=?2");
		query.setParameter(1,"上架中");	
		query.setParameter(2, classification);
		Object count7  = query.uniqueResult();
		return count7;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Object countwhereOpen(int max, int min) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*) from Product where status=?1 and price between :xxx and :ooo");
		query.setParameter("xxx",min);
		query.setParameter("ooo",max);
		query.setParameter(1,"上架中");	
		Object count7  = query.uniqueResult();
		return count7;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Object countclose(String status) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("select count(*)  from Product where  status like ?1");
		query.setParameter(1,"下架中");	
		Object count6  = query.uniqueResult();
		return count6;
	}



	@Override
	public boolean login(String username, String password) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query = session.createQuery("from Users where userName=?1 and userPassword=?2");		
		query.setParameter(1, username);
		query.setParameter(2, password);
		
		return query.list().isEmpty()?false:true;
		
	}

	public Object getByName(String name) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object> query =session.createQuery("from Product where  productName =?1");
		query.setParameter(1, name);
		Object product=query.uniqueResult();
		
		return product;
	}
	
	
	public void updateStock(Product product) {
		Session session = sessionfactory.getCurrentSession();
		Product p =session.get(Product.class, product.getProductID());
		
		if(p!=null) {
			p.setStock(product.getStock());
			
			session.save(p);
		}
	}
	
//  ----------
	
	@Override
	public List<Product> SelectConditionOpen(int how,String condition,int page,int max, int min,String productname) {
		Session session=sessionfactory.getCurrentSession();	
		Query<Product> query;
		List<Product> list = null ;
		if(how==1) {
			query = session.createQuery("from Product where  status like '上架中' ",Product.class);
			query.setFirstResult(page);
			query.setMaxResults(12);
			 list =query.list();
			
		}else if(how==2) {
			query = session.createQuery("from Product where  status='上架中'  and species=?1",Product.class);
			query.setParameter(1,condition);
			query.setFirstResult(page);
			query.setMaxResults(12);
			 list =query.list();
		}else if(how==3) { 
			query =	session.createQuery("from Product where  status='上架中'  and classification=?1",Product.class);
			query.setParameter(1,condition);
			query.setFirstResult(page);
			query.setMaxResults(12);		
			 list =query.list();
		}else if(how==4) {
			query = session.createQuery("from Product where  status='上架中'  and brand like ?1",Product.class);			
			query.setParameter(1,condition);			
			query.setFirstResult(page);
			query.setMaxResults(12);		
			list =query.list();
		}else if(how==5) {	
			query =session.createQuery("from Product where status='上架中' and price between :xxx and :ooo",Product.class);
			query.setParameter("xxx",min);
			query.setParameter("ooo",max);
			query.setFirstResult(page);
			query.setMaxResults(12);		
			 list =query.list();
			
		}else if(how==6) {
			query = session.createQuery("from Product where  status='上架中'  and productName like ?1",Product.class);
			StringBuffer sb=new StringBuffer();
			for(int i=0;i<productname.length();i++) {
				sb.append("%");
				sb.append(productname.charAt(i));
				sb.append("%");
			}
			System.out.println(sb.toString());
			query.setParameter(1, sb.toString());
			query.setFirstResult(page);
			query.setMaxResults(12);		
			list =query.list();
		}
	
		return  list;
		
		
	}
	public List<Product> SelectConditionOpen(int how,String condition,int page,int max, int min) {
		Session session=sessionfactory.getCurrentSession();	
		Query<Product> query;
		List<Product> list = null ;
		if(how==1) {
			query = session.createQuery("from Product where  status like '上架中' ",Product.class);
			query.setFirstResult(page);
			query.setMaxResults(12);
			 list =query.list();
			
		}else if(how==2) {
			query = session.createQuery("from Product where  status='上架中'  and species=?1",Product.class);
			query.setParameter(1,condition);
			query.setFirstResult(page);
			query.setMaxResults(12);
			 list =query.list();
		}else if(how==3) { 
			query =	session.createQuery("from Product where  status='上架中'  and classification=?1",Product.class);
			query.setParameter(1,condition);
			query.setFirstResult(page);
			query.setMaxResults(12);		
			 list =query.list();
		}else if(how==4) {
			query = session.createQuery("from Product where  status='上架中'  and brand like ?1",Product.class);			
			query.setParameter(1,condition);			
			query.setFirstResult(page);
			query.setMaxResults(12);		
			list =query.list();
		}else if(how==5) {	
			query =session.createQuery("from Product where status='上架中' and price between :xxx and :ooo",Product.class);
			query.setParameter("xxx",min);
			query.setParameter("ooo",max);
			query.setFirstResult(page);
			query.setMaxResults(12);		
			 list =query.list();
			
		}
		return  list;
		
		
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public Long CountConditionOpen(int how,String condition,int max, int min) {
		Session session=sessionfactory.getCurrentSession();		
		Query<Long> query;
		Long count  = null ;
		if(how==1) {
			query = session.createQuery("select count(*) from Product where  status like '上架中' ");
			count  = query.uniqueResult();
		}else if(how==2) {
			query = session.createQuery("select count(*) from Product where  status='上架中'  and species=?1");
			query.setParameter(1,condition);
			count  = query.uniqueResult();
		}else if(how==3) { 
			query =	session.createQuery("select count(*) from Product where  status='上架中'  and classification=?1");
			query.setParameter(1,condition);
			count  = query.uniqueResult();
		}else if(how==4) {
			query = session.createQuery("select count(*) from Product where  status='上架中'  and brand like ?1");			
			query.setParameter(1,condition);			
			count  = query.uniqueResult();
		}else if(how==5) {	
			query =session.createQuery("select count(*)  from Product where status='上架中' and price between :xxx and :ooo");
			query.setParameter("xxx",min);
			query.setParameter("ooo",max);				
			count  = query.uniqueResult();
			
		}
	
		return count ;
	}
	
	public Long CountConditionOpen(int how,String condition,int max, int min,String productname) {
		Session session=sessionfactory.getCurrentSession();		
		Query<Long> query;
		Long count  = null ;
		if(how==1) {
			query = session.createQuery("select count(*) from Product where  status like '上架中' ");
			count  = query.uniqueResult();
		}else if(how==2) {
			query = session.createQuery("select count(*) from Product where  status='上架中'  and species=?1");
			query.setParameter(1,condition);
			count  = query.uniqueResult();
		}else if(how==3) { 
			query =	session.createQuery("select count(*) from Product where  status='上架中'  and classification=?1");
			query.setParameter(1,condition);
			count  = query.uniqueResult();
		}else if(how==4) {
			query = session.createQuery("select count(*) from Product where  status='上架中'  and brand like ?1");			
			query.setParameter(1,condition);			
			count  = query.uniqueResult();
		}else if(how==5) {	
			query =session.createQuery("select count(*)  from Product where status='上架中' and price between :xxx and :ooo");
			query.setParameter("xxx",min);
			query.setParameter("ooo",max);				
			count  = query.uniqueResult();
			
		}else if(how==6) {
			query = session.createQuery("select count(*) from Product where  status='上架中'  and productName like ?1");
			StringBuffer sb=new StringBuffer();
			for(int i=0;i<productname.length();i++) {
				sb.append("%");
				sb.append(productname.charAt(i));
				sb.append("%");
			}
			System.out.println();
			query.setParameter(1, sb.toString());
			count  = query.uniqueResult();
		}
	
		return count ;
	}
	
	
	// 報表-銷售量
			public List<Object[]> pdsalepaper() {
				Session session = sessionfactory.getCurrentSession();
				Query<Object[]> query = session.createQuery(
						"select  productname ,sum(qty) from TradingDetail group by productname order by sum(qty) desc");
				query.setFirstResult(0);
				query.setMaxResults(10);
				return query.list();
			}

			// 報表-品牌銷售量
			public List<Object[]> pdbrandpaper() {
				Session session = sessionfactory.getCurrentSession();
				Query<Object[]> query = session.createQuery(
						"select  productid ,sum(qty*price) from TradingDetail group by productid order by productid,sum(qty*price) desc");

				return query.list();
			}

			// 報表-月份銷售量
			public List<Object[]> monsalepaper() {
				Session session = sessionfactory.getCurrentSession();
				Query<Object[]> query = session.createQuery("select datename(year,date),month(date) ,sum(total) from TradingRecord group by datename(year,date),month(date)  order by datename(year,date)asc,month(date) asc");
				return query.list();

			}

			@Override
			public List<Object[]> salepaper(int how) {
				Session session = sessionfactory.getCurrentSession();
				Query<Object[]> query;
				List<Object[]> list = null;
				if (how == 1) {
					query = session.createQuery("select  productname ,sum(qty) from TradingDetail group by productname order by sum(qty) desc");
					query.setFirstResult(0);
					query.setMaxResults(10);
					list = query.list();

				} else if (how == 2) {
					query = session.createQuery("select  productid ,sum(qty*price) from TradingDetail group by productid order by sum(qty*price) desc");
					list = query.list();
				} else if (how == 3) {
					query = session.createQuery("select datename(year,date),month(date) ,sum(total) from TradingRecord group by datename(year,date),month(date)  order by datename(year,date) desc,month(date)desc");
					list = query.list();
				}

				return list;

			}



			public List<Product> getname(String productName) {
				Session session = sessionfactory.getCurrentSession();
				Product product = session.get(Product.class, productName);
				Query<Product> query = session.createQuery("from Product", Product.class);
				return query.list();
			}
			
			public Product getname2(String productName) {
				Session session = sessionfactory.getCurrentSession();
				Query<Product> query = session.createQuery("from Product where productName=?1", Product.class);
				query.setParameter(1, productName);
				return query.uniqueResult();
			}

		

	
}
