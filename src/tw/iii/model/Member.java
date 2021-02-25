package tw.iii.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;


@Entity
@Table(name="member")
@Component
public class Member {
	@Id @Column(name="account")
	private String account;
	@Column(name="password")
	private String password;
	@Column(name="username")
	private String userName;
	@Column(name="email")
	private String email;
	@Column(name="phone")
	private String phone;
	@Column(name="address")
	private String address;
	@DateTimeFormat(pattern = "YYYY-MM-dd")
	@Column(name="birthday")
	private Date birthday;
	@Column(name="gender")
	private String gender;
	@Column(name="pdauthority")
	private String pdauthority;
	@Column(name="frauthority")
	private String frauthority;
	
	public String getPdauthority() {
		return pdauthority;
	}

	public void setPdauthority(String pdauthority) {
		this.pdauthority = pdauthority;
	}

	public String getFrauthority() {
		return frauthority;
	}

	public void setFrauthority(String frauthority) {
		this.frauthority = frauthority;
	}

	@OneToMany(fetch = FetchType.LAZY,mappedBy = "member",cascade = CascadeType.ALL)
	private Set<TradingRecord> tradingRecord = new HashSet<TradingRecord>(); 
	
	public Member() {
		
	}

	public Member(String account, String password, String userName, String email, String phone, String address,
			Date birthday, String gender, Set<TradingRecord> tradingRecord) {
		super();
		this.account = account;
		this.password = password;
		this.userName = userName;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.birthday = birthday;
		this.gender = gender;
		this.tradingRecord = tradingRecord;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Set<TradingRecord> getTradingRecord() {
		return tradingRecord;
	}

	public void setTradingRecord(Set<TradingRecord> tradingRecord) {
		this.tradingRecord = tradingRecord;
	}
	
	
}
