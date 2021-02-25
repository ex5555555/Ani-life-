package tw.iii.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.http.*;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
import ecpay.payment.integration.domain.AioCheckOutOneTime;
import ecpay.payment.integration.ecpayOperator.EcpayFunction;
import tw.iii.model.Cart;
import tw.iii.model.Member;
import tw.iii.model.MemberDAO;
import tw.iii.model.MemberService;
import tw.iii.model.Product;
import tw.iii.model.ProductDao;
import tw.iii.model.TradingDao;
import tw.iii.model.TradingDetail;
import tw.iii.model.TradingDetailpk;
import tw.iii.model.TradingRecord;

@Controller
public class CheckController {
	
	@Autowired
	private TradingDao tdao;
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private ProductDao pdao;
	
	private AllInOne all  ;
	@Autowired
	private MemberService mbs;
	
	
	@RequestMapping(path="/check",method = RequestMethod.GET)
	public String checkout(HttpSession session) {
		List<Cart> list=(List<Cart>)session.getAttribute("cart");
		session.setAttribute("cart", list);
		String account = SecurityContextHolder.getContext().getAuthentication().getName();
		session.setAttribute("user",SecurityContextHolder.getContext().getAuthentication().getName());	
		session.setAttribute("memberdata",mbs.select(account).get(0));
		return "WEB-INF/html/checkPage.jsp";
	}
	
	//確認結帳 訂單寫入資料庫 
	@RequestMapping(path="/checkConfirm",method = RequestMethod.POST)
	public String checkConfirm(@RequestParam(name="total")int total,
							   @RequestParam(name="tel")String tel,
							   @RequestParam(name="recipient")String recipient,
							   @RequestParam(name="address")String address,
							   @RequestParam(name="remarks")String remarks,
							   @RequestParam(name="email")String email,
								Model m,HttpSession session) throws ParseException {
		
		String account =SecurityContextHolder.getContext().getAuthentication().getName() ;
		System.out.println(account);
		
		//抓取訂單日期
		Date date =new Date();
		SimpleDateFormat dateFt=new SimpleDateFormat("yyyy-MM-dd");
		String dateTime=dateFt.format(date);
		Date dateResult =dateFt.parse(dateTime);
		
		Member member=memberDAO.getAccount(account);
		
		Set<TradingRecord> trecordset =new HashSet<TradingRecord>();
		TradingRecord trecord=new TradingRecord(dateResult, total+100, account, recipient, tel, address, remarks,email, member);
		trecord.setStatus("訂單成立");
		Set<TradingDetail> tdetailset =new HashSet<TradingDetail>();
		List<Cart> list=(List<Cart>)session.getAttribute("cart");
		
		for(int i =0;i<list.size();i++) {
			Cart cart =list.get(i);
			TradingDetailpk pk =new TradingDetailpk(i+1, trecord);
			
			Product product =cart.getProduct();
			String productname=cart.getProduct().getProductName();
			int productid=cart.getProduct().getProductID();
			int price =cart.getProduct().getPrice();
			int qty=cart.getQuantity();
			int stock =product.getStock();
			product.setStock(stock-qty);
			pdao.updateStock(product);
			
			System.out.println(productname+price+qty);
			TradingDetail tdetail=new TradingDetail(pk,productname, price, qty,productid);
			tdetailset.add(tdetail);
		}
		
		trecord.setTradingdetail(tdetailset);
		trecordset.add(trecord);
		
		member.setTradingRecord(trecordset);		
		memberDAO.insert(member);
		
		session.setAttribute("tradingRecordSet", trecordset);
		session.setAttribute("tradingRecord",trecord);
		session.setAttribute("tradingDetail",tdetailset);
		
		 return "setCopyId";
	}
	
	//set copyid
	@RequestMapping(path = "/setCopyId",method = RequestMethod.POST)
	public String setCopyId(Model m,HttpSession session) {
		String account =SecurityContextHolder.getContext().getAuthentication().getName() ;
		Member member=memberDAO.getAccount(account);
		Set<TradingRecord> trecordset=member.getTradingRecord();
		int copyid =tdao.latestId(account);
		TradingRecord trecord=tdao.getRecordbyId(copyid);
		Set<TradingDetail> tdetailset=trecord.getTradingdetail();
		List<TradingDetail> tdetailList =new ArrayList<TradingDetail>();
		
		System.out.println(copyid);
		for(TradingDetail t : tdetailset) {
			t.setCopyid(copyid);
			tdetailList.add(t);
			tdetailset.add(t);
		}
		trecord.setTradingdetail(tdetailset);
		trecordset.add(trecord);
		member.setTradingRecord(trecordset);
		memberDAO.updateTrading(member);
		
		session.setAttribute("tradingRecord",trecord);
		session.setAttribute("tradingDetail",tdetailList);
		//購物車清空
		List<Cart> list=(List<Cart>)session.getAttribute("cart");
		list.clear();
		session.setAttribute("cart", list);
		
		return "ecpay";
	}
	
	//跳轉綠界
	@RequestMapping(path="/ecpay",
			method = RequestMethod.POST,consumes = "application/x-www-form-urlencoded",
            produces = MediaType.TEXT_HTML_VALUE)
	public @ResponseBody String ecpay(HttpSession session) {
		String account =SecurityContextHolder.getContext().getAuthentication().getName() ;
		AioCheckOutALL obj = new AioCheckOutALL();
		TradingRecord trecord =(TradingRecord) session.getAttribute("tradingRecord");
		List<TradingDetail> tdetailList =(List<TradingDetail>) session.getAttribute("tradingDetail");
		String productname="";
		for(int i=0;i<tdetailList.size();i++) {
			productname +=tdetailList.get(i).getProductname();
		}
		
		Date tdate =trecord.getDate();
		SimpleDateFormat sdft= new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
		String date = sdft.format(tdate);//綠界要的日期格式
		
		SimpleDateFormat merchantTradeNoft =new SimpleDateFormat("yyyyMMddhhmmss");
		String merchantTradeNo=merchantTradeNoft.format(tdate);//給綠界的訂單號
		
		obj.setMerchantTradeNo(String.valueOf(trecord.getid())+"1");
		obj.setMerchantTradeDate(date);
		obj.setTotalAmount(String.valueOf(trecord.getTotal()));
		
		//https://e8da337743bf.ngrok.io<<這一串要搭配ngrok產生 關掉ngrok再重開就要產生一組新的
		obj.setReturnURL("https://a47b22611d02.ngrok.io/SpringHibernate/receiveResult");
		obj.setTradeDesc("test");
		
		obj.setItemName("productname");
		obj.setNeedExtraPaidInfo("N");
		obj.setOrderResultURL("https://a47b22611d02.ngrok.io/SpringHibernate/receiveResult");
		obj.setClientBackURL("https://a47b22611d02.ngrok.io/SpringHibernate/receiveResult");
		obj.setCustomField1(account);
		
		all =new AllInOne("");
		String checkMacValue=EcpayFunction.genCheckMacValue("5294y06JbISpM5x9", "v77hoKGq4kWxNNIS", obj);
		System.out.println(checkMacValue);
		Hashtable<String,String> params=new Hashtable<String,String>();
		params.put("MerchantID","2000214");
		params.put("CheckMacValue", checkMacValue);
		
		all.compareCheckMacValue(params);
		String form =all.aioCheckOut(obj, null);
		return form;
	}
	
	//轉回訂單頁
	@RequestMapping(path="/receiveResult",method = RequestMethod.POST)
	public String receiveResult(HttpServletRequest req,Model m) {
		String account =req.getParameter("CustomField1");
		System.out.println(account);
		Member member =memberDAO.getAccount(account);
		Set<TradingRecord> trecordset=member.getTradingRecord();
		int id =tdao.latestId(account);
		TradingRecord trecord=tdao.getRecordbyId(id);
		Set<TradingDetail> tdetailset=trecord.getTradingdetail();
		List<TradingDetail> tdetailList =new ArrayList<TradingDetail>();
		
		for(TradingDetail tdetail : tdetailset) {
			tdetailList.add(tdetail);
		}
		
		trecord.setStatus("已付款");
		trecordset.add(trecord);
		member.setTradingRecord(trecordset);
		memberDAO.updateTrading(member);
		m.addAttribute("tradingRecord",trecord);
		m.addAttribute("tradingDetail",tdetailList);
		return "WEB-INF/html/orderPage.jsp";
	}
	 
}
