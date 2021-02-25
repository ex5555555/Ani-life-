package tw.iii.controller;

//import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.iii.model.Member;
import tw.iii.model.MemberService;

@Controller
public class RegisterController {
	@Autowired
	private MemberService mbs;
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	@RequestMapping(path = "/register.controller", method = RequestMethod.POST)
	public String registerAction(@RequestParam(name = "account") String account,@RequestParam(name = "password")String password,@RequestParam(name = "configpwd") String configpwd
			,@RequestParam(name = "username")String userName,@RequestParam(name = "email")String email,@RequestParam(name = "phone")String phone,@RequestParam(name = "address")String address
			,@RequestParam(name = "birthday")String birthday,@RequestParam(name = "gender")String gender,Model m) throws ParseException {
		Map<String, String>err = new HashMap<String, String>();
		boolean isaccount = mbs.checkaccount(account);
		Member mbean = new Member();
		if(account==null || account.length()==0) {
			err.put("account", "請輸入帳號");	
		}else if(isaccount) {
			err.put("repeat", "此帳號已被註冊，請換一個");
		}else if(!account.matches("^[a-zA-z]\\w{4,26}$")) {
			err.put("accountformat", "帳號必須是字母開頭");
		}
		
		if(password==null || password.length()==0) {
			err.put("password", "請輸入密碼");	
		}else if(!password.matches("\\w{4,26}$")) {
			err.put("passwordformat", "密碼需4~26個任意數字加字母");
		}
		if(configpwd==null || configpwd.length()==0) {
			err.put("againpwd", "請再次輸入密碼");	
		}else if(!configpwd.equals(password)) {
			err.put("checkpwd", "請確認輸入的密碼是否一致");
		}
		if(userName==null || userName.length()==0) {
			err.put("userName", "請輸入姓名");	
		}
		if(email==null || email.length()==0) {
			err.put("email", "請輸入E-mail");	
		}
		if(phone==null || phone.length()==0) {
			err.put("phone", "請輸入電話");	
		}
		if(address==null || address.length()==0) {
			err.put("address", "請輸入地址");	
		}
		if(birthday == null || birthday.length()==0) {
			err.put("birthday", "請輸入生日");
		}
		m.addAttribute("err",err);
		if(err!=null&&!err.isEmpty()) {
			return "register.jsp";
		}
		mbean.setAccount(account);
		mbean.setPassword(passwordEncoder().encode(password));
		mbean.setUserName(userName);
		mbean.setEmail(email);
		mbean.setPhone(phone);
		mbean.setAddress(address);
		mbean.setFrauthority("t");
		mbean.setPdauthority("t");
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date br = sdf1.parse(birthday);
		mbean.setBirthday(br);
		mbean.setGender(gender);
		mbs.insert(mbean);
			
		return "home.jsp";
		
		
	}
}
