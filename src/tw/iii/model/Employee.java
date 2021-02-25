package tw.iii.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "employee")
public class Employee {
	
	@Id
	@Column(name = "empID")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int empid;
	
	@Column(name = "empAccount")
	private String empaccount;
	
	@Column(name = "empPassword")
	private String emppassword;
	
	@Column(name = "empName")
	private String empname;
	
	@Column(name = "title")
	private String title;
	
	public Employee() {
		
	}
	public Employee(String empaccount,String emppassword,
			String empname,String title) {
		this.empaccount=empaccount;
		this.emppassword=emppassword;
		this.empname=empname;
		this.title=title;
	}
	
	public int getEmpid() {
		return empid;
	}
	public void setEmpid(int empid) {
		this.empid = empid;
	}
	public String getEmpaccount() {
		return empaccount;
	}
	public void setEmpaccount(String empaccount) {
		this.empaccount = empaccount;
	}
	public String getEmppassword() {
		return emppassword;
	}
	public void setEmppassword(String emppassword) {
		this.emppassword = emppassword;
	}
	public String getEmpname() {
		return empname;
	}
	public void setEmpname(String empname) {
		this.empname = empname;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
}
