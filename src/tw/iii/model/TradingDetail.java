package tw.iii.model;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Entity
@Table(name="tradingdetail")
@Component
public class TradingDetail {
	
	@EmbeddedId
	@Autowired
	private TradingDetailpk pk;
	
	@Column(name="productname")
	private String productname;
	@Column(name="price")
	private int price;
	@Column(name="qty")
	private int qty;
	@Column(name="copyid")
	private int copyid;
	@Column(name="productid")
	private int productid;
	@Column(name="grade")
	private int grade;
	@Column(name="gradecontent")
	private String gradecontent;
	
	@Transient
	private String account;
	@Transient
	private String img;

	public TradingDetail() {
		
	}
	

	public TradingDetail(String productname, int price, int qty,int copyid
			) {
		super();
		this.productname = productname;
		this.price = price;
		this.qty = qty;
		this.copyid=copyid;
	}




	public TradingDetail(TradingDetailpk pk, String productname, int price, int qty,int productid) {
		super();
		this.pk = pk;
		this.productname = productname;
		this.price = price;
		this.qty = qty;
		this.productid=productid;
	}


	public String getProductname() {
		return productname;
	}

	public void setProductname(String productname) {
		this.productname = productname;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}


	public int getCopyid() {
		return copyid;
	}


	public void setCopyid(int copyid) {
		this.copyid = copyid;
	}


	public int getProductid() {
		return productid;
	}


	public void setProductid(int productid) {
		this.productid = productid;
	}


	public int getGrade() {
		return grade;
	}


	public void setGrade(int grade) {
		this.grade = grade;
	}


	public String getGradecontent() {
		return gradecontent;
	}


	public void setGradecontent(String gradecontent) {
		this.gradecontent = gradecontent;
	}


	public String getImg() {
		return img;
	}


	public void setImg(String img) {
		this.img = img;
	}


	public String getAccount() {
		return account;
	}


	public void setAccount(String account) {
		this.account = account;
	}



}
