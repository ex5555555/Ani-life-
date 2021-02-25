package tw.iii.model;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Repository;

@Repository("mapdao")
public class MapDao {

	@Autowired
	private SessionFactory sessionfactory;
	
	public MapDao(SessionFactory sessionfactory) {
		this.sessionfactory = sessionfactory;
	}


	public List<GoogleMap> selectAllpage(int page) {
		Session session=sessionfactory.getCurrentSession();
		Query<GoogleMap> query = session.createQuery("from GoogleMap", GoogleMap.class);		
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<GoogleMap> list = query.list();
		return list;
		
	}
	
	public List<GoogleMap> selectcitypage(String city,int page) {
		Session session=sessionfactory.getCurrentSession();
		Query<GoogleMap> query = session.createQuery("from GoogleMap where city like ?1",GoogleMap.class);
		query.setParameter(1,city);
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<GoogleMap> list = query.list();
		return list;
		
	}
	
	
	public List<GoogleMap> selectAll() {
		Session session=sessionfactory.getCurrentSession();
		Query<GoogleMap> query = session.createQuery("from GoogleMap", GoogleMap.class);	
		
		List<GoogleMap> list = query.list();
		return list;
		
	}
	
	public List<GoogleMap> selectcity(String city) {
		Session session=sessionfactory.getCurrentSession();
		Query<GoogleMap> query = session.createQuery("from GoogleMap where city like ?1",GoogleMap.class);
		query.setParameter(1,city);
		
		List<GoogleMap> list = query.list();
		return list;
		
	}
	
	
	public List<GoogleMap> selectcity24oremergency(String city,int y) {
		Session session=sessionfactory.getCurrentSession();		
		String	 HQL = null;
		if(y==1) {
		HQL ="from GoogleMap where city like ?1 and h24 = 'y'";
		}if(y==2) {
		HQL ="from GoogleMap where city like ?1 and er = 'y'";			
		}if(y==3) {
		HQL ="from GoogleMap where city like ?1 and er = 'y' and h24 = 'y'";	
		}
		Query<GoogleMap>  query = session.createQuery(HQL,GoogleMap.class);
		query.setParameter(1,city);			
		List<GoogleMap> list = query.list();
		return list;
		
	}
	
	public Long mapclasscount(String city) {
		Session session=sessionfactory.getCurrentSession();
		Query<Long> query = session.createQuery(" select count(*) from GoogleMap where city = ?1");
		query.setParameter(1,city);
		Long forumcount = query.uniqueResult();
		return forumcount;
	}
	
	public Long mapcount() {
		Session session=sessionfactory.getCurrentSession();
		Query<Long> query = session.createQuery(" select count(*) from GoogleMap");		
		Long forumcount = query.uniqueResult();
		return forumcount;
	}
	
	public List<GoogleMap> select24oremergency(int page,String city,int y) {
		Session session=sessionfactory.getCurrentSession();		
		String	 HQL = null;
		if(y==1) {
		HQL ="from GoogleMap where city like ?1 and h24 = 'y'";
		}if(y==2) {
		HQL ="from GoogleMap where city like ?1 and er = 'y'";			
		}if(y==3) {
		HQL ="from GoogleMap where city like ?1 and er = 'y' and h24 = 'y'";	
		}
		Query<GoogleMap>  query = session.createQuery(HQL,GoogleMap.class);
		query.setParameter(1,city);
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<GoogleMap> list = query.list();
		return list;
		
	}
	
	public Long map24oremergencycount(String city,int y) {
		Session session=sessionfactory.getCurrentSession();
		String	 HQL = null;
		if(y==1) {
		HQL ="select count(*) from GoogleMap where city = ?1 and h24 = 'y'";
		}if(y==2) {
		HQL ="select count(*) from GoogleMap where city = ?1 and er = 'y'";			
		}if(y==3) {
		HQL ="select count(*) from GoogleMap where city = ?1 and er = 'y' and h24 = 'y'";	
		}
		Query<Long> query = session.createQuery(HQL);
		query.setParameter(1,city);
		Long forumcount = query.uniqueResult();
		return forumcount;
	}
	

	
	

	

	public  GoogleMap select(int id) {
		Session session=sessionfactory.getCurrentSession();
		GoogleMap map = session.get(GoogleMap.class,id);	
		return map;
	}
	
	
	//下面是後台的
	public List<GoogleMap> selectid(int id) {
		Session session=sessionfactory.getCurrentSession();
		Query<GoogleMap>query = session.createQuery("from GoogleMap where id like ?1",GoogleMap.class);
		query.setParameter(1, id);
		return query.list();
	}
	
	
	public List<GoogleMap> selecter(String er){
		Session session=sessionfactory.getCurrentSession();
		Query<GoogleMap>query = session.createQuery("from GoogleMap where er like ?1",GoogleMap.class);
		query.setParameter(1, er);
		return query.list();
	}
	
	
	public List<GoogleMap> selecth24(String h24){
		Session session=sessionfactory.getCurrentSession();
		Query<GoogleMap>query = session.createQuery("from GoogleMap where h24 like ?1",GoogleMap.class);
		query.setParameter(1, h24);
		return query.list();
	}
	
	
	public GoogleMap update(int id, String mapname, String tel, String dress, BigDecimal lat,
			BigDecimal lng, String city, String er, String h24) {
		Session session=sessionfactory.getCurrentSession();
		GoogleMap googlemap = session.get(GoogleMap.class, id);
		
		if(googlemap != null) {
			googlemap.setId(id);
			googlemap.setMapname(mapname);
			googlemap.setTel(tel);
			googlemap.setDress(dress);
			googlemap.setLat(lat);
			googlemap.setLng(lng);
			googlemap.setCity(city);
			googlemap.setEr(er);
			googlemap.setH24(h24);
			session.save(googlemap);
		}
		return null;
	}
	
	
	public boolean delete(int id) {
		Session session=sessionfactory.getCurrentSession();
		GoogleMap googlemap = session.get(GoogleMap.class, id);
		
		if(googlemap!=null) {
			session.delete(googlemap);
			return true;
		}
		return false;
	}
	
	
	public GoogleMap insert(GoogleMap gm) {
		Session session=sessionfactory.getCurrentSession();
		GoogleMap googlemap = session.get(GoogleMap.class, gm.getId());
		
		if(googlemap==null) {
			session.save(gm);
			System.out.println("Add Success !!");
			return gm;
		}
		return null;
	}
}
