package tw.iii.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.stereotype.Component;

@Entity
@Table(name="product")
@Component
public class Product {
	@Id @Column(name="productid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int productID;
	
	@Column(name = "productName")
	private String productName;
	@Column(name = "stock")
	private int stock;
	@Column(name = "price")
	private int price;
	@Column(name = "species")
	private String species;
	@Column(name = "classification")
	private String classification;
	@Column(name = "brand")
	private String brand;
	@Column(name = "descripton")
	private String descripton;
	@Column(name = "img")
	private String img;
	@Column(name="status")
	private String status;
	
	@Transient
	private Long sum;
	public Product() {
		
	}

	public Long getSum() {
		return sum;
	}

	public void setSum(Long sum) {
		this.sum = sum;
	}

	public  Product(String productName, int stock, int price, String species, String classification, String brand,
			String descripton, String img,String status) {
		this.productName = productName;
		this.stock = stock;
		this.price = price;
		this.species = species;
		this.classification = classification;
		this.brand = brand;
		this.descripton = descripton;
		this.img = img;
		this.status=status;
	}
	
	public Product(String productName, int stock, int price, String species, String classification, String brand,
			String descripton,String status) {
		
		this.productName = productName;
		this.stock = stock;
		this.price = price;
		this.species = species;
		this.classification = classification;
		this.brand = brand;
		this.descripton = descripton;
		this.status = status;
		
	}

	public int getProductID() {
		return productID;
	}

	public void setProductID(int productID) {
		this.productID = productID;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getSpecies() {
		return species;
	}

	public void setSpecies(String species) {
		this.species = species;
	}

	public String getClassification() {
		return classification;
	}

	public void setClassification(String classification) {
		this.classification = classification;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getDescripton() {
		return descripton;
	}

	public void setDescripton(String descripton) {
		this.descripton = descripton;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	

}