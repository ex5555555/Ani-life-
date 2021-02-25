package tw.iii.model;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TradingDao {
	@Autowired
	private SessionFactory sessionfactory;

	public TradingDao(SessionFactory sessionfactory) {
		this.sessionfactory=sessionfactory;
	}
	
	//全部訂單資料
	public List<TradingRecord> getAllRecord(){
		Session session =sessionfactory.getCurrentSession();
		Query<TradingRecord> query =session.createQuery("from TradingRecord",TradingRecord.class);
		return query.list();
	}
	//依日期顯示
	public List<TradingRecord> getAllRecordorderByDate(){
		Session session =sessionfactory.getCurrentSession();
		Query<TradingRecord> query =session.createQuery("from TradingRecord order by date desc",TradingRecord.class);
		return query.list();
	}
	//依價格排序
	public List<TradingRecord> getAllRecordorderByTotal(){
		Session session =sessionfactory.getCurrentSession();
		Query<TradingRecord> query =session.createQuery("from TradingRecord order by total desc",TradingRecord.class);
		return query.list();
	}
	
	//帳號查詢訂單
	public List<TradingRecord> getRecordbyAccount(String account){
		Session session =sessionfactory.getCurrentSession();
		Query<TradingRecord> query =session.createQuery("from TradingRecord where account =?1",TradingRecord.class);
		query.setParameter(1, account);
		return query.list();
	}
	//帳號查詢訂單
	public List<TradingRecord> getRecordorderbydate(String account){
		Session session =sessionfactory.getCurrentSession();
		Query<TradingRecord> query =session.createQuery("from TradingRecord where account =?1 order by date desc",TradingRecord.class);
		query.setParameter(1, account);
		return query.list();
	}
	
	//訂單號查詢訂單
	public TradingRecord getRecordbyId(int id){
		Session session =sessionfactory.getCurrentSession();
		Query<TradingRecord> query =session.createQuery("from TradingRecord where id =?1",TradingRecord.class);
		query.setParameter(1, id);
		return query.list().get(0);
	}
	//後臺動態查詢
	public List<TradingRecord> searchTradingRecord(String id,String status,String account,String recipient,
			String tel,String address,String email,String beginDate,String endDate,String min,String max){
		Session session = sessionfactory.getCurrentSession();
		StringBuffer hql =new StringBuffer();
		hql.append("from TradingRecord where 1=1");
		
		if(id!=null&&!"".equals(id)) {
			hql.append("and id = '"+id+"'");
		}
		if(status!=null&&!"".equals(status)) {
			hql.append("and status = '"+status+"'");
		}
		if(account!=null&&!"".equals(account)) {
			hql.append("and account = '"+account+"'");
		}
		
		if(recipient!=null&&!"".equals(recipient)) {
			hql.append("and recipient = '"+recipient+"'");
		}
		
		if(tel!=null&&!"".equals(tel)) {
			hql.append("and tel = '"+tel+"'");
		}
		
		if(address!=null&&!"".equals(address)) {
			hql.append("and address like '%"+address+"%'");
		}
		
		if(email!=null&&!"".equals(email)) {
			hql.append("and address ='"+email+"'");
		}
		
		if(beginDate!=null&&!"".equals(beginDate)&&endDate!=null&&!"".equals(endDate)) {
			hql.append("and date between '"+beginDate+"' and '"+endDate+"'");
		}
		if(min!=null&&!"".equals(min)&&max!=null&&!"".equals(max)) {
			hql.append("and total between "+min+" and "+max);
		}

		Query<TradingRecord> query=session.createQuery(hql.toString());
		return query.list();
	}
	
	
	
	//set copyid 要用的
	public Integer latestId(String account) {
		Session session =sessionfactory.getCurrentSession();
		Query<Integer> query=session.createQuery("select max(id) from TradingRecord where account =?1");
		query.setParameter(1, account);
		Integer max=query.uniqueResult();
		return max;
	}
	
	//細項查詢
	public List<TradingDetail> getDetail(int id){
		Session session =sessionfactory.getCurrentSession();
		Query<TradingDetail> query=session.createQuery("from TradingDetail where copyid =?2",TradingDetail.class);
		query.setParameter(2, id);
		return query.list();
		
	}

	
	//刪除訂單+細項
	public void delTradingRecord(int id) {
		Session session =sessionfactory.getCurrentSession();
		TradingRecord tbean=session.get(TradingRecord.class, id);
		if(tbean!=null) {
			session.delete(tbean);
		}
		
	}
	
	//商品頁顯示評價
	public List<TradingDetail> showGrade(int productid){
		Session session = sessionfactory.getCurrentSession();
		Query<TradingDetail> query=session.createQuery("from TradingDetail where productid =?2",TradingDetail.class);
		query.setParameter(2, productid);
		return  query.list();
	}
	
	public List<String> selectTopProduct(){
		Session session = sessionfactory.getCurrentSession();
		Query<String> query =session.createQuery("select productname from TradingDetail group by productname order by sum(qty) desc");
		query.setFirstResult(0);
		query.setMaxResults(5);
		
		return  query.list();
		
	}


	

}
