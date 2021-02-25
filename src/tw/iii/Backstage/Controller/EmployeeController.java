package tw.iii.Backstage.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import tw.iii.model.Employee;
import tw.iii.model.EmployeeDao;
import tw.iii.model.Product;
import tw.iii.model.ProductDao;
import tw.iii.model.ProductService;

@Controller
public class EmployeeController {

	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private EmployeeDao edao;
	
	@Autowired
	private ProductService pService;
	
	@Autowired
	private HttpServletRequest req;

	
	//全部查詢
	@RequestMapping(path = "/goemployee", method = RequestMethod.GET)
	public String goemployee(Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IOException{
		m.addAttribute("employeeList", edao.selectAll());
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/employee.jsp";
	}
	
	//回首頁
	@RequestMapping(path = "/gobackhome", method = RequestMethod.GET)
	public String gohome(Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IOException{
//		m.addAttribute("employeeList", edao.selectAll());
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideManagement.jsp";
	}
	
	//跳轉至新增
	@RequestMapping(path="/toaddemployeejsp",method = RequestMethod.GET)
	public String toaddemployeejsp(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/employeeadd.jsp";
	}
	
	//跳轉至更新
	@RequestMapping(path="/toupdateemployeejsp",method = RequestMethod.GET)
	public String toupdateemployeejsp(@RequestParam(name="empID")int empid, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<Employee> list = edao.selectAll();
		m.addAttribute("employeeList", list);
		m.addAttribute("eeaccount",eeaccount);
		Employee employee = edao.select(empid);
		m.addAttribute("employee", employee);
		return "/WEB-INF/Backstage/employeeupdate.jsp";
	}
	
	//新增員工
	@RequestMapping(path = "/addemployee", method = RequestMethod.POST)
	public String addemployee(@RequestParam(name="empAccount")String empaccount,@RequestParam(name="empPassword")String emppassword,
			@RequestParam(name="empName")String empname,@RequestParam(name="title")String title, Model m,@RequestParam(name = "eeaccount") String eeaccount) 
					throws IllegalStateException, IOException, ParseException{
		Employee employee = new Employee(empaccount, emppassword, empname, title);
		edao.insert(employee);
		
		return goemployee(m,eeaccount);
	}
	
	//刪除員工
	@RequestMapping(path = "/deleteemployee", method = RequestMethod.GET)
	public String deleteemployee(@RequestParam(name="empID")int empid, Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IOException {
		edao.delete(empid);
		return goemployee(m,eeaccount);
	}
	
	//更新員工
	@RequestMapping(path = "/updateemployee", method = RequestMethod.POST)
	public String updateemployee(@RequestParam(name="empID")int empid, @RequestParam(name="empAccount")String empaccount,
			@RequestParam(name="empPassword")String emppassword, @RequestParam(name="empName")String empname,
			@RequestParam(name="title")String title, Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IllegalStateException, IOException, ParseException{
		edao.update(empid, empaccount, emppassword, empname, title);
		return goemployee(m,eeaccount);
	}
	
	//id查詢
	@RequestMapping(path = "/selectemployeeid", method = RequestMethod.POST)
	public String selectemployeeid(@RequestParam(name="empID")int empid, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("employeeList", edao.selectid(empid));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/employee.jsp";
	}
	
	//title查詢
	@RequestMapping(path = "/selectemployeetitle", method = RequestMethod.POST)
	public String selectemployeetitle(@RequestParam(name="title")String title, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("employeeList", edao.selecttitle(title));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/employee.jsp";
	}
	
	
	
	
}
