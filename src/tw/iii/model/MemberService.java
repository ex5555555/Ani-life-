package tw.iii.model;



import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
@Service("MemberService")
public class MemberService {
	@Autowired
	private MemberDAO mDao;
	
	public Member insert(Member mb) {
		
		return mDao.insert(mb);
		
	};
	
	public Member selecter(String Account) {
		
		return mDao.selecter(Account);
		
	};
	
	public List<Member> select(String Account){
		
		return mDao.select(Account);
		
	};
	public List<Member> selectOldpwd(String Account){
		
		return mDao.selectOldpwd(Account);
		
	};
	
	public List<Member> selectemail(String Account,String email){
		
		return mDao.selectemail(Account, email);
		
	};
	
	
	public List<Member> selectAll(){
		
		return mDao.selectAll();
		
	};
	
	public Member updatepassword(String Account,String Password) {
		
		return mDao.updatepassword(Account, Password);
	};
	
	public Member updateAll(String Account,String userName,String email,String phone,String address,String birthday,String gender) throws ParseException {
		
		return mDao.updateAll(Account, userName, email, phone, address, birthday, gender);
	};
	
	public boolean checkLogin(String Account,String Password) {
		
		return mDao.checkLogin(Account, Password);
	};
	
	public boolean forgetpwd(String Account,String email) {
		
		return mDao.forgetpwd(Account, email);
	};
	
	public boolean changepwd(String Password) {
		
		return mDao.changepwd(Password);
	};
	public boolean checkaccount(String Account) {
		return mDao.checkAccount(Account);
	}
	
	public Member updateAuthority(String Account,String pdauthority,String frauthority) {
		return mDao.updateAuthority(Account, pdauthority, frauthority);
};
}
