package tw.iii.model;



import java.text.ParseException;
import java.util.List;

public interface IMemberDao {
	public Member insert(Member mb);
	public Member selecter(String Account);
	public Member getAccount(String Account);
	public List<Member> select(String Account);
	public List<Member> selectOldpwd(String Account);
	public List<Member> selectemail(String Account,String email);
	public List<Member> selectAll();
	public Member updatepassword(String Account,String Password);
	public Member updateAll(String Account,String userName,String email,String phone,String address,String birthday,String gender) throws ParseException;
	public boolean checkLogin(String Account,String Password);
	public boolean forgetpwd(String Account,String email);
	public boolean changepwd(String Password);
	public boolean checkAccount(String Account);
	public  Member updateAuthority(String Account, String pdauthority, String frauthority);
	
}
