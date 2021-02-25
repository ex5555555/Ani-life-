package tw.iii.Backstage.Controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
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
import tw.iii.model.GoogleMap;
import tw.iii.model.MapDao;
import tw.iii.model.Member;
import tw.iii.model.MemberDAO;
import tw.iii.model.MemberService;
import tw.iii.model.Product;
import tw.iii.model.ProductDao;
import tw.iii.model.ProductService;

@Controller
public class BackSideGoogleMapController {
	
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private MapDao mdao;
	
	@Autowired
	private HttpServletRequest req;

	
	//全部查詢
	@RequestMapping(path = "/gogooglemap", method = RequestMethod.GET)
	public String gogooglemap(Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IOException{
		m.addAttribute("goolemapList", mdao.selectAll());
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideGoogleMapManagement.jsp";
	}
	

	
	//跳轉至新增
	@RequestMapping(path="/toaddgooglemapjsp",method = RequestMethod.GET)
	public String toaddgooglemapjsp(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideGoogleMapCreate.jsp";
	}
	
	//跳轉至更新
	@RequestMapping(path="/toupdategooglemapjsp",method = RequestMethod.GET)
	public String toupdategooglemapjsp(@RequestParam(name="id")int id, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<GoogleMap> list = mdao.selectAll();
		m.addAttribute("goolemapList", list);
		m.addAttribute("eeaccount",eeaccount);
		GoogleMap map = mdao.select(id);
		m.addAttribute("googlemap", map);
		return "/WEB-INF/Backstage/BackSideGoogleMapUpdate.jsp";
	}
	
	//新增地圖
	@RequestMapping(path = "/addgooglemap", method = RequestMethod.POST)
	public String addgooglemap(@RequestParam(name="mapname")String mapname,@RequestParam(name="tel")String tel,
			@RequestParam(name="dress")String dress,@RequestParam(name="lat")BigDecimal lat,
			@RequestParam(name="lng")BigDecimal lng,@RequestParam(name="city")String city,
			@RequestParam(name="er")String er,@RequestParam(name="h24")String h24,Model m,@RequestParam(name = "eeaccount") String eeaccount) 
					throws IllegalStateException, IOException, ParseException{
		GoogleMap map = new GoogleMap(mapname, tel, dress, lat, lng, city, er, h24);
		mdao.insert(map);
		return gogooglemap(m,eeaccount);
	}
	
	//刪除地圖
	@RequestMapping(path = "/deletegooglemap", method = RequestMethod.GET)
	public String deletegooglemap(@RequestParam(name="id")int id, Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IOException {
		mdao.delete(id);
		return gogooglemap(m,eeaccount);
	}
	
	//更新地圖
	@RequestMapping(path = "/updategooglemap", method = RequestMethod.POST)
	public String updategooglemap(@RequestParam(name="id")int id, @RequestParam(name="mapname")String mapname,
			@RequestParam(name="tel")String tel, @RequestParam(name="dress")String dress,
			@RequestParam(name="lat")BigDecimal lat, @RequestParam(name="lng")BigDecimal lng,
			@RequestParam(name="city")String city, @RequestParam(name="er")String er,
			@RequestParam(name="h24")String h24, Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IllegalStateException, IOException, ParseException{
		mdao.update(id, mapname, tel, dress, lat, lng, city, er, h24);
		return gogooglemap(m,eeaccount);
	}
	
	//編號查詢
	@RequestMapping(path = "/selectgooglemapid", method = RequestMethod.POST)
	public String selectgooglemapid(@RequestParam(name="id")int id, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("goolemapList", mdao.selectid(id));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideGoogleMapManagement.jsp";
	}
	
	//縣市查詢
	@RequestMapping(path = "/selectgooglemapcity", method = RequestMethod.POST)
	public String selectgooglemapcity(@RequestParam(name="city")String city, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("goolemapList", mdao.selectcity(city));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideGoogleMapManagement.jsp";
	}
	
	//er查詢
	@RequestMapping(path = "/selectgooglemaper", method = RequestMethod.POST)
	public String selectgooglemaper(@RequestParam(name="er")String er, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("goolemapList", mdao.selecter(er));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideGoogleMapManagement.jsp";
	}
		
	//h24查詢
	@RequestMapping(path = "/selectgooglemaph24", method = RequestMethod.POST)
	public String selectgooglemaph24(@RequestParam(name="h24")String h24, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("goolemapList", mdao.selecth24(h24));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideGoogleMapManagement.jsp";
	}
}