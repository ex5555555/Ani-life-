package tw.iii.model;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.stereotype.Component;

@Entity
@Table(name="googlemap")
@Component
public class GoogleMap {
 
   @Id @Column(name="id")
   @GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
   
   @Column(name="mapname")
	private String mapname;
   
   @Column(name="tel")
	private String tel;
   
   @Column(name = "dress")
	private String dress;
   
   @Column(name="lat")
	private BigDecimal lat;
   
   @Column(name="lng")
	private BigDecimal lng;
   
   @Column(name="city")
   private String city;
   
   @Column(name="er")
   private String er;
   
   @Column(name="h24")
   private String h24;
   
   
	
	
	
	public String getEr() {
	return er;
}


public void setEr(String er) {
	this.er = er;
}


public String getH24() {
	return h24;
}


public void setH24(String h24) {
	this.h24 = h24;
}


	public String getCity() {
	return city;
}


public void setCity(String city) {
	this.city = city;
}


	public GoogleMap() {
		
	}
	
	
  public GoogleMap(String mapname,String tel,String dress,BigDecimal lat,BigDecimal lng) {
		this.mapname=mapname;
		this.tel=tel;
		this.dress=dress;
		this.lat=lat;
		this.lng=lng;
	}

  public GoogleMap(String mapname,String tel,String dress,BigDecimal lat,BigDecimal lng, String city, String er, String h24) {
	  this.mapname=mapname;
	  this.tel=tel;
	  this.dress=dress;
	  this.lat=lat;
	  this.lng=lng;
	  this.city=city;
	  this.er=er;
	  this.h24=h24;
  }

public int getId() {
	return id;
}


public void setId(int id) {
	this.id = id;
}


public String getMapname() {
	return mapname;
}


public void setMapname(String mapname) {
	this.mapname = mapname;
}


public String getTel() {
	return tel;
}


public void setTel(String tel) {
	this.tel = tel;
}


public String getDress() {
	return dress;
}


public void setDress(String dress) {
	this.dress = dress;
}


public BigDecimal getLat() {
	return lat;
}


public void setLat(BigDecimal lat) {
	this.lat = lat;
}


public BigDecimal getLng() {
	return lng;
}


public void setLng(BigDecimal lng) {
	this.lng = lng;
}

}
