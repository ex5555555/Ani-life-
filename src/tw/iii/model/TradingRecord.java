package tw.iii.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Fetch;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Entity
@Table(name="tradingrecord")
@Component
public class TradingRecord {
	
	@Id @Column(name="id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="date")
	private Date date;
	
	@Column(name="total")
	private int total;
	
	@Column(name="recipient")
	private String recipient;
	
	@Column(name="tel")
	private String tel;
	@Transient 
	private String account;
	
	@Column(name="address")
	private String address;
	
	@Column(name="remarks")
	private String remarks;
	
	@Column(name="status")
	private String status;
	
	@Column(name="email")
	private String email;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="account")
	@Autowired
	private Member member;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "pk.tradingRecord",cascade = CascadeType.ALL)
	private Set<TradingDetail> tradingdetail = new HashSet<TradingDetail>();
	
	public TradingRecord() {
		
	}
	
	public TradingRecord( Date date, int total, String account, String recipient, String tel, String address,
			String remarks,String email, Member member) {
		super();
		
		this.date = date;
		this.total = total;
		this.account = account;
		this.recipient = recipient;
		this.tel = tel;
		this.address = address;
		this.remarks = remarks;
		this.email=email;
		this.member = member;
	}



	public TradingRecord( Date date, int total, String account, String recipient, String tel, String address,
			String remarks, String status, Member member, Set<TradingDetail> tradingdetail) {
		super();
		
		this.date = date;
		this.total = total;
		this.account = account;
		this.recipient = recipient;
		this.tel = tel;
		this.address = address;
		this.remarks = remarks;
		this.status = status;
		this.member = member;
		this.tradingdetail = tradingdetail;
	}



	public int getid() {
		return id;
	}

	public void setid(int id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public Set<TradingDetail> getTradingdetail() {
		return tradingdetail;
	}

	public void setTradingdetail(Set<TradingDetail> tradingdetail) {
		this.tradingdetail = tradingdetail;
	}



	public String getRecipient() {
		return recipient;
	}



	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}



	public String getTel() {
		return tel;
	}



	public void setTel(String tel) {
		this.tel = tel;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public String getRemarks() {
		return remarks;
	}



	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}
