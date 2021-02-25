package tw.iii.model;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("forumDao")
public class ForumDao {

	@Autowired
	private SessionFactory sessionfactory;

	public ForumDao(SessionFactory sessionfactory) {
		this.sessionfactory = sessionfactory;
	}

	// vvvvv gohome的熱門文章區
	// 找出第一樓的文章
	public ForumDetail showheadDetail(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<ForumDetail> query = session.createQuery("from ForumDetail where copyfdid = ?1 ", ForumDetail.class);
		query.setParameter(1, id);
		query.setFirstResult(0);
		query.setMaxResults(1);
		ForumDetail FD = query.uniqueResult();
		return FD;
	}

	// 熱門文章
	public List<Integer> selecthotForum() {
		Session session = sessionfactory.getCurrentSession();
		Query<Integer> query = session
				.createQuery("select copyfdid from ForumDetail group by copyfdid order by count(copyfdid) desc");
		query.setFirstResult(0);
		query.setMaxResults(5);
		List<Integer> list = query.list();

		return list;
	}

	// 找標題home用的
	public Forum selecttitle2(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum where fid = ?1 ", Forum.class);
		query.setParameter(1, id);
		Forum list = query.uniqueResult();
		return list;
	}

	// ^^^^

	// 找討論版標題的功能
	public String selecttitle(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum where fid = ?1 ", Forum.class);
		query.setParameter(1, id);
		List<Forum> list = query.list();

		String tt = list.get(0).getTitle();
		return tt;
	}

	// vvvv goeditor 前往編輯器回文
	public ForumDetail selectoneDetail(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<ForumDetail> query = session.createQuery("from ForumDetail where fdid = ?1 ", ForumDetail.class);
		query.setParameter(1, id);
		ForumDetail fd = query.uniqueResult();
		return fd;
	}
	// ^^^^

	// vvvv goforum 前往討論版
	public Long Forumcount() {
		Session session = sessionfactory.getCurrentSession();
		Query<Long> query = session.createQuery(" select count(*) from Forum");
		Long forumcount = query.uniqueResult();
		return forumcount;
	}

	public List<ForumSpecies> selectAllSpecies() {
		Session session = sessionfactory.getCurrentSession();
		Query<ForumSpecies> query = session.createQuery("from ForumSpecies", ForumSpecies.class);
		return query.list();
	}

	// 剩下.size功能
	public List<Forum> selectAllForum() {
		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum", Forum.class);
		List<Forum> list = query.list();
		return list;
	}

	// 一次五筆文章顯示
	public List<Forum> selectlistForum(int page) {

		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum", Forum.class);
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<Forum> list = query.list();
		return list;
	}

	// 找出樓層為1的detail資料
	public List<ForumDetail> selectfl(int page) {
		Session session = sessionfactory.getCurrentSession();
		Query<ForumDetail> query = session.createQuery("from ForumDetail where fl = 1", ForumDetail.class);
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<ForumDetail> list = query.list();
		return list;
	}

	// 每一篇文章的留言數量
	public List<Integer> flcount(int page) {
		Session session = sessionfactory.getCurrentSession();
		Query<Integer> query = session.createQuery("select count(copyfdid) from ForumDetail group by copyfdid ");
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<Integer> list = query.list();

		return list;
	}
	// ^^^^

	// vvvvv 查找最新文章的功能
	public List<Forum> selectnewforum() {
		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum where title != '[此文章已由原作者刪除]' order by date desc",
				Forum.class);
		query.setFirstResult(0);
		query.setMaxResults(6);
		List<Forum> list = query.list();
		return list;
	}

	// ^^^^^

	// vvvv selectforumspecies 各專區瀏覽的功能
	// 需要的頁數
	public Long Forumclasscount(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<Long> query = session.createQuery(" select count(*) from Forum where copyfid = ?1");
		query.setParameter(1, id);
		Long forumcount = query.uniqueResult();
		return forumcount;
	}

	// 找出樓層為1的detail資料 各專區瀏覽版本
	public List<Object[]> selectflSpecies(int id, int page) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object[]> query = session.createQuery(
				"select F,FD.content from Forum F inner join ForumDetail FD on F.fid = FD.copyfdid where  F.copyfid =?1 and  FD.fl = 1 ");
		query.setParameter(1, id);

		query.setFirstResult(page);
		query.setMaxResults(5);
		List<Object[]> list = query.list();
		return list;
	}

	// 每一篇文章的留言數量 各專區瀏覽版本
	public List<Integer> flcountSpecies(int id, int page) {
		Session session = sessionfactory.getCurrentSession();
		Query<Integer> query = session.createQuery(
				"select count(FD.copyfdid) from Forum F inner join ForumDetail FD on F.fid = FD.copyfdid  where F.copyfid =?1 group by FD.copyfdid");
		query.setParameter(1, id);
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<Integer> list = query.list();

		return list;
	}

	// ^^^^^^

	// vvvv goforumdetail 前往文章內容
	public List<ForumDetail> showDetail(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<ForumDetail> query = session.createQuery("from ForumDetail where copyfdid = ?1 ", ForumDetail.class);
		query.setParameter(1, id);
		return query.list();
	}

	// ^^^^^

	// vvvv createnewforum 發文提交

	public ForumSpecies insertForumSP(ForumSpecies forumSpecies) {
		Session session = sessionfactory.getCurrentSession();
		ForumSpecies SP = session.get(ForumSpecies.class, forumSpecies.getFsid());
		if (SP != null) {
			session.save(SP);
		}

		return SP;
	}

	// 定義某一個專區
	public ForumSpecies selectForumSpecies(int fsid) {
		Session session = sessionfactory.getCurrentSession();
		ForumSpecies forum = session.get(ForumSpecies.class, fsid);
		return forum;
	}

	// ^^^^

	// vvvv fileuploadcontroller 回文編輯器提交

	// 樓層+1
	public Integer fl(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<Integer> query = session.createQuery("select max(fl) from ForumDetail where copyfdid  = ?1 ");
		query.setParameter(1, id);
		Integer max = query.uniqueResult();

		return max;
	}

	public Forum selectff(int id) {
		Session session = sessionfactory.getCurrentSession();
		Forum forum = session.get(Forum.class, id);
		return forum;
	}

	public Forum insertb(Forum foruml) {
		Session session = sessionfactory.getCurrentSession();
		Forum forumselect = session.get(Forum.class, foruml.getFid());
		if (forumselect != null) {
			session.save(foruml);
		}

		return foruml;
	}
	// ^^^^

	// vvvv delete 刪除文章

	public boolean deletedetail(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<ForumDetail> query = session.createQuery("from ForumDetail where fdid = ?1 ", ForumDetail.class);
		query.setParameter(1, id);
		ForumDetail fd = query.uniqueResult();
		fd.setContent("[此樓層文章已由原作者刪除]");
		fd.setImg(null);
		;
		if (fd != null) {
			session.save(fd);
			return true;
		}
		return false;

	}

	public boolean deleteforum(int id) {
		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum where fid = ?1 ", Forum.class);
		query.setParameter(1, id);
		Forum forum = query.uniqueResult();
		forum.setTitle("[此文章已由原作者刪除]");

		if (forum != null) {
			session.save(forum);
			return true;
		}
		return false;

	}

	// ^^^^

	// vvvv selectkeyword 關鍵次查詢版本
	// 找出樓層為1的detail資料 帶類別 模糊查詢 keyword
	public List<Object[]> selectflSpeciesbuffer(String title, int page) {
		Session session = sessionfactory.getCurrentSession();

		System.out.println("長度一共是這樣" + title.length());
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < title.length(); i++) {
			sb.append("%");

			sb.append(title.charAt(i));
		}
		sb.append("%");
		System.out.println(sb.toString() + "這樣喔");
		String tt = sb.toString();
		Query<Object[]> query = session.createQuery(
				"select F,FD.content from Forum F inner join ForumDetail FD on F.fid = FD.copyfdid where  F.title like ?1 and  FD.fl = 1 ");
		query.setParameter(1, tt);

		query.setFirstResult(page);
		query.setMaxResults(5);
		List<Object[]> list = query.list();
		return list;
	}

	// 關鍵字查詢的筆數
	public Long Forumkeywordcount(String title) {
		Session session = sessionfactory.getCurrentSession();
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < title.length(); i++) {
			sb.append("%");

			sb.append(title.charAt(i));
		}
		sb.append("%");
		String tt = sb.toString();
		Query<Long> query = session.createQuery(" select count(*) from Forum where  title like ?1");
		query.setParameter(1, tt);
		Long forumcount = query.uniqueResult();
		return forumcount;
	}

	// ^^^^

	public List<Forum> selectforumSpecies(int id, int page) {
		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum where copyfid = ?1", Forum.class);
		query.setParameter(1, id);
		query.setFirstResult(page);
		query.setMaxResults(5);
		List<Forum> list = query.list();
		return list;
	}
	
	
	//vvvv
	
	public List<Forum> selectaccountforum(String account) {
		Session session = sessionfactory.getCurrentSession();
		Query<Forum> query = session.createQuery("from Forum where account = ?1 and title != '[此文章已由原作者刪除]' ", Forum.class);
		query.setParameter(1,account);		
		List<Forum> list = query.list();
		System.out.println("長度有"+list.size());
		return list;
	}
	
	public List<ForumDetail> selectaccountforumdetail(String account) {
		Session session = sessionfactory.getCurrentSession();
		Query<ForumDetail> query = session.createQuery("from ForumDetail where account = ?1 and content != '[此樓層文章已由原作者刪除]' ", ForumDetail.class);
		query.setParameter(1,account);		
		List<ForumDetail> list = query.list();
		return list;
	}
	
	//^^^^

}
