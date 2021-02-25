package tw.iii.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Component;

@Entity
@Table(name="forumDetail")
@Component
public class ForumDetail {
	
	
	@Id 
	@Column(name = "fdid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int fdid ;

	

	@Column(name = "copyfdid")
	private int copyfdid;
	
	@Column(name="account")
    private String account;
	
	
    
	@Column(name="content")
    private String content;
	
	@Column(name="img")
    private String img;
	
	
	@Column(name="date")
    private Date date;
	
	@Column(name="fl")
	private int fl;
	
	 @Transient @Column(name="fid")
	 private int fid;
    
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="fid")
	private Forum forum;
    
    public ForumDetail() {
		
	}
    
	
	public ForumDetail(int copyfdid,String account,String content,Date date, Forum forum) {
        this.copyfdid=copyfdid;
		this.account=account;
		this.content=content;		
		this.forum=forum;
		this.date=date;
		
	}


	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	

	public Forum getForum() {
		return forum;
	}

	public void setForum(Forum forum) {
		this.forum = forum;
	}


	public int getFdid() {
		return fdid;
	}


	public void setFdid(int fdid) {
		this.fdid = fdid;
	}


	public int getCopyfdid() {
		return copyfdid;
	}


	public void setCopyfdid(int copyfdid) {
		this.copyfdid = copyfdid;
	}


	public int getFid() {
		return fid;
	}


	public void setFid(int fid) {
		this.fid = fid;
	}


	public int getFl() {
		return fl;
	}


	public void setFl(int fl) {
		this.fl = fl;
	}



	

}
