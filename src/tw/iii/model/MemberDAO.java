package tw.iii.model;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;


import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

@Repository("memberDAO")
public class MemberDAO implements IMemberDao {
	
	@Autowired
	private SessionFactory sessionfactory;
	
	public MemberDAO(SessionFactory sessionfactory) {
		this.sessionfactory=sessionfactory;
	}
	
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Override
	public Member insert(Member mb) {
		Session session = sessionfactory.getCurrentSession();
		Member mbr =session.get(Member.class, mb.getAccount());
		
		if(mbr == null) {
			session.save(mb);
			System.out.println("註冊成功");
			return mb;
		}
		System.out.println("已有此會員");
		return null;
	}

	@Override
	public Member selecter(String Account) {
		Session session = sessionfactory.openSession();
		Member mbr = session.get(Member.class, Account);
		session.close();
		return mbr;
	}
	

	@Override
	public List<Member> select(String Account) {
		Session session = sessionfactory.getCurrentSession();
		Query<Member> query = session.createQuery("from Member where account=?1");
		query.setParameter(1, Account);
		return query.list();
	}
	@Override
	public List<Member> selectOldpwd(String Account) {
		Session session = sessionfactory.getCurrentSession();
		Query<Member> query = session.createQuery("select password from Member where account=?1");
		query.setParameter(1, Account);
		return query.list();
	}
	@Override
	public List<Member> selectemail(String Account, String email) {
		Session session = sessionfactory.getCurrentSession();
		Query<Member> query = session.createQuery("select email from Member where account=?1 and email=?2");
		query.setParameter(1, Account);
		query.setParameter(2, email);
		return query.list();
	}

	@Override
	public List<Member> selectAll() {
		Session session = sessionfactory.getCurrentSession();
		Query<Member> mb=session.createQuery("from Member",Member.class);
		return mb.list();
	}

	@Override
	public Member updatepassword(String Account,String Password) {
		Session session = sessionfactory.getCurrentSession();
		Member mbr = session.get(Member.class, Account);
		if(mbr != null) {
			mbr.setPassword(passwordEncoder().encode(Password));
			session.save(mbr);
		}
		
		return mbr;
	}

	@Override
	public Member updateAll(String Account,String userName, String email, String phone, String address, String birthday, String gender) throws ParseException {
		Session session = sessionfactory.getCurrentSession();
		Member mbr = session.get(Member.class, Account);
		
		if(mbr != null) {
			mbr.setUserName(userName);
			mbr.setEmail(email);
			mbr.setPhone(phone);
			mbr.setAddress(address);
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date br = sdf1.parse(birthday);
			mbr.setBirthday(br);
			mbr.setGender(gender);
			
			session.save(mbr);
		}
		
		return mbr;
	}

	@Override
	public boolean checkLogin(String Account, String Password) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object> query = session.createQuery("from Member where account=?1 and password=?2");
		query.setParameter(1, Account);
		query.setParameter(2, Password);
		return query.list().isEmpty()?false:true;
	}

	@Override
	public boolean forgetpwd(String Account, String email) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object> query = session.createQuery("from Member where account=?1 and email=?2");
		query.setParameter(1, Account);
		query.setParameter(2, email);
		return query.list().isEmpty()?false:true;
	}

	@Override
	public boolean changepwd(String Password) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object> query = session.createQuery("from Member where password=?1");
		query.setParameter(1, Password);
		return query.list().isEmpty()?false:true;
	}

	@Override
	public boolean checkAccount(String Account) {
		Session session = sessionfactory.getCurrentSession();
		Query<Object> query = session.createQuery("from Member where account=?1");
		query.setParameter(1, Account);
		return query.list().isEmpty()?false:true;
	}


	@Override
	public Member getAccount(String account) {
		Session session = sessionfactory.getCurrentSession();
		Member member =session.get(Member.class, account);
		return member;
	}
	
	public void updateTrading(Member member) {
		Session session = sessionfactory.getCurrentSession();
		Member m=session.get(Member.class, member.getAccount());
	
		m.setTradingRecord(member.getTradingRecord());
		session.save(m);
	}
	
	@Override
	public Member updateAuthority(String Account,String pdauthority,String frauthority) {
		Session session = sessionfactory.getCurrentSession();
		Member mbr = session.get(Member.class, Account);
		if(mbr != null) {
			mbr.setPdauthority(pdauthority);
			mbr.setFrauthority(frauthority);
			
			session.save(mbr);
		}
		return mbr ;
		
	}


}
