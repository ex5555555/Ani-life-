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

@Entity
@Table(name="forum")
public class Forum {
	
	@Id 
	@Column(name = "fid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int fid ;
    
	@Column(name="title")
	private String title;
 
	@Column(name="account")
	private String account;
 
	@Column(name="date")
	private Date date;
	
	
	
	@Column(name="copyfid")
	private int copyfid;
	
	@Transient @Column(name="fsid")
	private int fsid;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="fsid")
    private ForumSpecies  forumSpecies ;

	@OneToMany(fetch = FetchType.LAZY,mappedBy = "forum",cascade = CascadeType.ALL)
	private   Set<ForumDetail>  forumDetail=new HashSet<ForumDetail>();
	
	

	
	public Forum() {
		
	}
	
	public Forum(int copyfid,String title,String account,Date date,ForumSpecies  forumSpecies) {
		this.title=title;
		this.account=account;
		this.date=date;
		this.copyfid=copyfid;
		this.forumSpecies=forumSpecies;
	
	}
	
	public Forum(int copyfid,String title,String account,Date date,  Set<ForumDetail>  forumDetail) {
		this.title=title;
		this.account=account;
		this.date=date;
		this.forumDetail=forumDetail;
		this.copyfid=copyfid;
		
	}
	
	
	public  Set<ForumDetail>  getForumDetail() {
		return forumDetail;
	}

	public void setForumDetail(  Set<ForumDetail>  forumDetail) {
		this.forumDetail = forumDetail;
	}
	
	


	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	
	public ForumSpecies getForumSpecies() {
		return forumSpecies;
	}

	public void setForumSpecies(ForumSpecies forumSpecies) {
		this.forumSpecies = forumSpecies;
	}

	public int getFid() {
		return fid;
	}

	public void setFid(int fid) {
		this.fid = fid;
	}

	public int getCopyfid() {
		return copyfid;
	}

	public void setCopyfid(int copyfid) {
		this.copyfid = copyfid;
	}

	public int getFsid() {
		return fsid;
	}

	public void setFsid(int fsid) {
		this.fsid = fsid;
	}

	

	
}
