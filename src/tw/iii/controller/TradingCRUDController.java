package tw.iii.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import tw.iii.model.Cart;
import tw.iii.model.Member;
import tw.iii.model.MemberDAO;
import tw.iii.model.Product;
import tw.iii.model.ProductDao;
import tw.iii.model.TradingDao;
import tw.iii.model.TradingDetail;
import tw.iii.model.TradingDetailpk;
import tw.iii.model.TradingRecord;

@Controller
public class TradingCRUDController {
	@Autowired
	private TradingDao tdao;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private ProductDao pdao;

	
	//顯示所有訂單
	@GetMapping(path="/showAllTrading")
	public String showAllTrading(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<TradingRecord> recordList=tdao.getAllRecord();
		m.addAttribute("recordList",recordList);
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/TradingRecordPage.jsp";
	}
	
	//排序訂單(新>舊)
	@GetMapping(path="/showAllTradingOrderByDate")
	public String showAllTradingOrderByDate(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<TradingRecord> recordList =tdao.getAllRecordorderByDate();
		
		m.addAttribute("recordList",recordList);
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/TradingRecordPage.jsp";
	}
	@GetMapping(path="/showAllTradingOrderByTotal")
	public String showAllTradingOrderByTotal(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<TradingRecord> recordList =tdao.getAllRecordorderByTotal();
		m.addAttribute("recordList",recordList);
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/TradingRecordPage.jsp";
	}
	
	@PostMapping(path="/showTrading")
	public String showTrading(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<TradingRecord> recordList =tdao.getAllRecordorderByDate();
		
		m.addAttribute("recordList",recordList);
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/TradingRecordPage.jsp";
	}
	
	//搜尋單筆訂單
	@PostMapping(path="/showTradingbyId")
	public String searchbyId(@RequestParam(name="orderid")int id,Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		TradingRecord recordList=tdao.getRecordbyId(id);
		m.addAttribute("recordList",recordList);
		return "/WEB-INF/Backstage/TradingRecordPage.jsp";
	}
	
	@PostMapping(path="/searchTradingRecord")
	public String searchTradingRecord(@RequestParam(name="id")String id,
			@RequestParam(name="account")String account,
			@RequestParam(name="status")String status,
			@RequestParam(name="recipient")String recipient,
			@RequestParam(name="tel")String tel,
			@RequestParam(name="email")String email,
			@RequestParam(name="address")String address,
			@RequestParam(name="beginDate")String beginDate,
			@RequestParam(name="endDate")String endDate,
			@RequestParam(name="min")String min,
			@RequestParam(name="max")String max
			,Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<TradingRecord> recordList=tdao.searchTradingRecord(id, status, account, recipient, tel, address, email, beginDate, endDate,min,max);
		m.addAttribute("recordList",recordList);
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/TradingRecordPage.jsp";
	}
	

	//單筆訂單細項顯示(後台)
	@GetMapping(path="/showTradingRecordnDetail")
	public String showTradingRecordnDetail(@RequestParam(name="orderid")int id,Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		TradingRecord trecord=tdao.getRecordbyId(id);
		m.addAttribute("eeaccount",eeaccount);
		List<TradingDetail> tradingDetail =tdao.getDetail(id);
		m.addAttribute("trecord",trecord);
		m.addAttribute("tradingDetail",tradingDetail);
		return "/WEB-INF/Backstage/UpdateMyTrading.jsp";
	}
	
	//更新訂單
	@PostMapping(path="/updateTrading")
	public String updateTrading(@RequestParam(name="id")String id,
			@RequestParam(name="status")String status,
			@RequestParam(name="recipient")String recipient,
			@RequestParam(name="tel")String tel,
			@RequestParam(name="address")String address,
			@RequestParam(name="email")String email,Model m,@RequestParam(name = "eeaccount") String eeaccount ) throws ParseException {
		
		TradingRecord trecord = tdao.getRecordbyId(Integer.parseInt(id));
		trecord.setStatus(status);
		trecord.setRecipient(recipient);
		trecord.setAddress(address);
		trecord.setTel(tel);
		trecord.setEmail(email);
		Member member=trecord.getMember();
		Set<TradingRecord> trSet=member.getTradingRecord();
		trSet.add(trecord);
		member.setTradingRecord(trSet);
		memberDAO.updateTrading(member);
		m.addAttribute("eeaccount",eeaccount);
		return "showTrading";
	}
	
	//刪除訂單(後台)
	@GetMapping(path="/delTradingRecord")
	public String delTradingRecord(@RequestParam(name="orderid")int id,Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		System.out.println(id);
		tdao.delTradingRecord(id);
		m.addAttribute("eeaccount",eeaccount);
		return "showAllTrading";
	}
	
	
	//查詢訂單(前台)
	@GetMapping(path="/showTradingRecord")
	public String showTradingRecord(Model m) {
		String account =SecurityContextHolder.getContext().getAuthentication().getName();
		List<TradingRecord> tradingRecord =tdao.getRecordorderbydate(account);
		
		
		ArrayList<LinkedHashMap<String,Object>> maps=new ArrayList<>();
		
		for(int i =0;i<tradingRecord.size();i++) {
			List<TradingDetail> tradingDetail =tdao.getDetail(tradingRecord.get(i).getid());
			LinkedHashMap<String,Object> map=new LinkedHashMap<String,Object>();

			map.put("tradingRecord",tradingRecord.get(i) );
			
			List<TradingDetail> list=new ArrayList<>();
			
			for(int j =0;j<tradingDetail.size();j++) {
				Product p=(Product) pdao.getByName(tradingDetail.get(j).getProductname());
				TradingDetail tdetail=tradingDetail.get(j);
				tdetail.setImg(p.getImg());
				list.add(tdetail);
				map.put("tradingDetail", list);

			}
			
			maps.add(map);
		}
		m.addAttribute("allDetail",maps);

		return "WEB-INF/html/MyTradingRecord.jsp";
	}
	
	
	
	
	
}
