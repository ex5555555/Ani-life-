package tw.iii.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="forumSpecies")
public class ForumSpecies {

	@Id 
	@Column(name="fsid")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int fsid ;
	


	@Column(name="species")
	private String species;
	
	@OneToMany(fetch = FetchType.LAZY,mappedBy = "forumSpecies",cascade = CascadeType.ALL)
	private   Set<Forum>  forum=new HashSet<Forum>();
	
	public ForumSpecies() {
	
	}
	
	public ForumSpecies( Set<Forum>  forum,String species) {
		this.forum=forum;
		this.species=species;
	}

	


	

	

	public int getFsid() {
		return fsid;
	}

	public void setFsid(int fsid) {
		this.fsid = fsid;
	}

	public String getSpecies() {
		return species;
	}

	public void setSpecies(String species) {
		this.species = species;
	}

	public Set<Forum> getForum() {
		return forum;
	}

	public void setForum(Set<Forum> forum) {
		this.forum = forum;
	}

	
	
}
