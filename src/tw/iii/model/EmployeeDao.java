package tw.iii.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("employeeDao")
public class EmployeeDao {
	
	@Autowired
	private SessionFactory sessionfactory;
	
	public EmployeeDao(SessionFactory sessionfactory) {
		this.sessionfactory=sessionfactory;
	}
	
	//EMP新增
	public Employee insert(Employee ee) {
		Session session=sessionfactory.getCurrentSession();
		Employee employee = session.get(Employee.class, ee.getEmpid());
		
		if(employee==null) {
			session.save(ee);
			System.out.println("Add Success !!");
			return ee;
		}
		return null;
	}
	
	//EMP刪除
	public boolean delete(int empid) {
		Session session=sessionfactory.getCurrentSession();
		Employee employee = session.get(Employee.class, empid);
		
		if(employee!=null) {
			session.delete(employee);
			return true;
		}
		return false;
	}
	//EMP查詢empaccount
		public List<Employee> selectempaccount(String empaccount){
			Session session=sessionfactory.getCurrentSession();
			Query<Employee>query = session.createQuery("from Employee where empaccount like ?1",Employee.class);
			query.setParameter(1, empaccount);
			return query.list();
		}
	
	//EMP查詢單筆
	public Employee select(int empid) {
		Session session = sessionfactory.getCurrentSession();
		Employee employee = session.get(Employee.class, empid);
		return employee;
	}
	
	//EMP查詢id
	public List<Employee> selectid(int empid) {
		Session session=sessionfactory.getCurrentSession();
		Query<Employee>query = session.createQuery("from Employee where empID like ?1",Employee.class);
		query.setParameter(1, "%"+empid);
		return query.list();
	}
	
	//EMP查詢title
	public List<Employee> selecttitle(String title){
		Session session=sessionfactory.getCurrentSession();
		Query<Employee>query = session.createQuery("from Employee where title like ?1",Employee.class);
		query.setParameter(1, "%"+title);
		return query.list();
	}
	
	//EMP更新
	public Employee update(int empid, String empaccount, String emppassword,
			String empname, String title) {
		Session session=sessionfactory.getCurrentSession();
		Employee employee = session.get(Employee.class, empid);
		
		if(employee != null) {
			employee.setEmpaccount(empaccount);
			employee.setEmppassword(emppassword);
			employee.setEmpname(empname);
			employee.setTitle(title);
			session.save(employee);
		}
		return null;
	}
	
	//EMP查詢全部
	public List<Employee> selectAll(){
		Session session=sessionfactory.getCurrentSession();
		Query<Employee>query = session.createQuery("from Employee", Employee.class);
		return query.list();
	}
	
	//EMP登入
	public boolean login(String empaccount, String emppassword) {
		Session session=sessionfactory.getCurrentSession();
		Query<Object>query = session.createQuery("from Employee where empAccount=?1 and empPassword=?2");
		query.setParameter(1, empaccount);
		query.setParameter(2, emppassword);
		System.out.println(query.list());
		return query.list().isEmpty()?false:true;
	}
	
	
	
}
