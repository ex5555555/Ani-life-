package tw.iii.Backstage.Controller;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.iii.model.EmployeeDao;

@Controller
public class EmployeeLoginController {

	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private EmployeeDao edao;
	
	@RequestMapping(path = "/employeelogin", method = RequestMethod.GET)
	public String employeeLogin(@RequestParam(name = "empAccount")String empaccount, 
			@RequestParam(name = "empPassword")String emppassword, Model m, HttpServletRequest req) {
		
		Map<String,String> err=new HashMap<String,String>();
		
		boolean isLogin=edao.login(empaccount, emppassword);
		
		if(empaccount==null||empaccount.length()==0) {
			err.put("empAccount","請輸入帳號" );
		}
		if(emppassword==null||emppassword.length()==0) {
			err.put("empPassword", "請輸入密碼");
		}
		
		if(isLogin) {
			HttpSession session=req.getSession();
			session.setAttribute("isLogin", isLogin);
			m.addAttribute("eeaccount", edao.selectempaccount(empaccount).get(0).getTitle());
			return "/WEB-INF/Backstage/BackSideManagement.jsp";
		}
		m.addAttribute("err", err);
		if(err!=null&&!err.isEmpty()) {
			return "/WEB-INF/Backstage/eeindex.jsp";		
			}
		err.put("msg", "帳號或密碼錯誤，請重新輸入!");
		return "/WEB-INF/Backstage/eeindex.jsp";
	}
	
	
	@RequestMapping(path = "/goemployeelogin", method = RequestMethod.GET)
	public String Login( Model m) {
		return "/WEB-INF/Backstage/eeindex.jsp";
	}
	
}
