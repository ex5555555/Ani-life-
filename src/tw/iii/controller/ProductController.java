package tw.iii.controller;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import tw.iii.model.Member;
import tw.iii.model.MemberDAO;
import tw.iii.model.Product;
import tw.iii.model.ProductDao;
import tw.iii.model.ProductService;
import tw.iii.model.TradingDao;
import tw.iii.model.TradingDetail;
import tw.iii.model.TradingRecord;

@Controller
public class ProductController {
	@Autowired
	private ProductService pService;
	@Autowired
	private HttpSession session;
	
	
	@Autowired
	private ProductDao pdao;
	@Autowired
	private HttpServletRequest req;
	@Autowired
	private TradingDao tdao;
	@Autowired
	private MemberDAO mdao;
	
	
	@RequestMapping(path="/getProductDetail",method = RequestMethod.GET)
	public String productDetail(@RequestParam(name="id")int id,
			@RequestParam(name="status")String status,
			@RequestParam(name="recordid")String recordid,Model m) {
		Product product =pService.getById(id);
		String species=product.getSpecies();
		
		List<TradingDetail> tdList=tdao.showGrade(id);//產品評價
		List<TradingDetail> newlist=new ArrayList<>();
		for(int j=0;j<tdList.size();j++) {
			TradingDetail td=tdList.get(j);
			TradingRecord tr =tdao.getRecordbyId(td.getCopyid());
			td.setAccount(tr.getMember().getAccount());
	
			newlist.add(td);
		}
		
		
		List<Product> productList=pdao.selectspeciesOpen(species);
		List<Product> list =new ArrayList<Product>();
		for(int i=0;i<productList.size();i++) {
			if(i<=5) {
			list.add(productList.get(i));
			
			}else {
				break;
			}
		}
		m.addAttribute("recordid",recordid);
		m.addAttribute("detail",newlist);
		m.addAttribute("status",status);
		m.addAttribute("productList",list);
		m.addAttribute("product",product);
		return "ProductDetail.jsp";
	}

	//新增商品評價
		@RequestMapping(path = "/genGrade",method = RequestMethod.POST)
		public @ResponseBody String genGrade(@RequestParam(name="recordid")int recordid,
					@RequestParam(name="gradecontent")String gradecontent,
					@RequestParam(name="productid")int productid,
					@RequestParam(name="grade")int grade) {
			TradingRecord trecord = tdao.getRecordbyId(recordid);
			Set<TradingDetail> tdetailSet=trecord.getTradingdetail();
			Member member = trecord.getMember();
			System.out.println(member.getAccount());
			TradingDetail newtdetail=new TradingDetail();
			for(TradingDetail td:tdetailSet) {
				if(td.getProductid()==productid) {
					td.setGrade(grade);
					td.setGradecontent(gradecontent);
					td.setAccount(member.getAccount());
					newtdetail=td;
					tdetailSet.add(newtdetail);
				}
			}
			System.out.println(newtdetail.getGradecontent());
			trecord.setTradingdetail(tdetailSet);
			
			Set<TradingRecord> trSet=member.getTradingRecord();
			trSet.add(trecord);
			member.setTradingRecord(trSet);
			mdao.updateTrading(member);
			
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("detail", newtdetail);	
			
			
			
			try {
				ObjectMapper mapper =new ObjectMapper();
				return mapper.writeValueAsString(map);
			} catch (JsonProcessingException e) {
				
				e.printStackTrace();
				throw new RuntimeException(e);
			}
			
		}
	
	@RequestMapping(path = "/SelectCondition", method = RequestMethod.GET)
	public String selectspecies(@RequestParam(name = "max") int max, @RequestParam(name = "min") int min,@RequestParam(name="how")int how,@RequestParam(name="currpage")int currpage,@RequestParam(name = "condition") String condition, Model m) {
		int count =  currpage*12 ;
		m.addAttribute("productList",  pdao.SelectConditionOpen( how, condition, count, max,  min));
		m.addAttribute("totalpage",Math.round(Math.ceil( pdao.CountConditionOpen(how, condition, max, min)*1.0 / 12)));//總筆數除以一次顯示幾筆=需要幾頁 
		m.addAttribute("currpage",currpage);//當前頁數
		m.addAttribute("how", how);
		m.addAttribute("condition", condition);
		m.addAttribute("max", max);
		m.addAttribute("min",min);
		
		m.addAttribute("selection", "selectSpecies");
		m.addAttribute("count", pdao.CountConditionOpen(how, condition, max, min));
		System.out.println("需要"+( pdao.CountConditionOpen(how, condition, max, min)*1.0 / 12));
		
	
		
		return "product.jsp";
	}
	@RequestMapping(path = "/SelectCondition", method = RequestMethod.POST)
	public String selectname(@RequestParam(name = "max") int max, @RequestParam(name = "min") int min,@RequestParam(name="how")int how,@RequestParam(name="currpage")int currpage,@RequestParam(name = "condition") String condition,@RequestParam(name = "productname") String productname, Model m) {
		int count =  currpage*12 ;
		m.addAttribute("productList",  pdao.SelectConditionOpen( how, condition, count, max,  min,productname));
		m.addAttribute("totalpage",Math.round(Math.ceil( pdao.CountConditionOpen(how, condition, max, min,productname)*1.0 / 12)));//總筆數除以一次顯示幾筆=需要幾頁 
		m.addAttribute("currpage",currpage);//當前頁數
		m.addAttribute("how", how);
		m.addAttribute("condition", condition);
		m.addAttribute("max", max);
		m.addAttribute("min",min);
		m.addAttribute("productname",productname);
		m.addAttribute("selection", "selectSpecies");
		m.addAttribute("count", pdao.CountConditionOpen(how, condition, max, min,productname));
		System.out.println("需要"+( pdao.CountConditionOpen(how, condition, max, min,productname)*1.0 / 12));
		
	
		
		return "product.jsp";
	}

	

}