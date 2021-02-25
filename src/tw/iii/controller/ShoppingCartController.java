package tw.iii.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import tw.iii.model.Cart;
import tw.iii.model.MemberService;
import tw.iii.model.Product;
import tw.iii.model.ProductDao;

@Controller
public class ShoppingCartController {
		@Autowired
		private ProductDao pdao;
		
		
		@RequestMapping(path="/loadMyCart",method = RequestMethod.POST)
		public @ResponseBody String loadMyCart(HttpSession session){
			List<Cart> list=(List<Cart>)session.getAttribute("cart");
			
			ArrayList<LinkedHashMap<String,String>> maps=new ArrayList<>();
			for(int i = 0;i<list.size();i++){
				LinkedHashMap<String,String> hmap = new LinkedHashMap<String,String>();
				hmap.put("name",String.valueOf(list.get(i).getProduct().getProductName()));
				hmap.put("price",String.valueOf(list.get(i).getProduct().getPrice()));
				hmap.put("Stock",String.valueOf(list.get(i).getStock()));
				hmap.put("quantity",String.valueOf(list.get(i).getQuantity()));
				hmap.put("id",String.valueOf(list.get(i).getProduct().getProductID()));
				hmap.put("img",String.valueOf(list.get(i).getProduct().getImg()));
				maps.add(hmap);
			}System.out.println(maps);
			
			  try {
		            ObjectMapper mapper = new ObjectMapper();
		            return mapper.writeValueAsString(maps);
		        }
		        catch (Exception e) {
		            e.printStackTrace();
		            throw new RuntimeException(e);
		        }
			
			
//			if(list!=null) {
//				return list;
//			}else {
//			return null;}
		}
		
		//加入購物車按鈕觸發事件(還沒檢查庫存)
		@RequestMapping(path="/addToCart",method = RequestMethod.GET)
		public @ResponseBody List<Cart> addToCart(@RequestParam(name="id")int id,
				@RequestParam(name="quantity")int quantity,
				HttpSession session) {
			Product product=pdao.getById(id);
			int stock =product.getStock();
			System.out.println(stock);
			
			//購物車不為空時
			if(session.getAttribute("cart")!=null) {
				ArrayList<LinkedHashMap<String,String>> maps=new ArrayList<>();
				List<Cart> list=(List<Cart>)session.getAttribute("cart");
				int index=isExisting(id, session);	
				if(index==-1) {//購物車沒有相同的商品時
					
					list.add(new Cart(product,quantity,stock));
					System.out.println(stock+"1");
				}else {
					
					int q = list.get(index).getQuantity();//得到原有數量
					list.get(index).setQuantity(quantity+q);//加上新增數量
					list.get(index).setStock(stock-(quantity+q));//暫時庫存
				
				}
				session.setAttribute("cart", list);
				return list;
				
			}else {//購物車為空時
				System.out.println(stock+"2");
				Cart cart=new Cart(product,quantity,stock-quantity); 
				List<Cart> list=new ArrayList<Cart>();
				list.add(cart);
				session.setAttribute("cart", list);
				return list;
			}
			
			
			
		}
		
		//購物車移除商品
		@RequestMapping(path="/deletProduct",method = RequestMethod.GET)
		public @ResponseBody List<Cart> delFromCart(@RequestParam(name="id")int id
				,HttpSession session){
			List<Cart> list=(List<Cart>)session.getAttribute("cart");
			int index=isExisting(id, session);
			list.remove(index);
			session.setAttribute("cart", list);
			return list;
		}
		
		//前往結帳(跳轉購物車)
				@RequestMapping(path="/goToCart",method = RequestMethod.GET)
				public String goCheck(HttpSession session) {
					List<Cart> list=(List<Cart>)session.getAttribute("cart");
					session.setAttribute("cart", list);
					ArrayList<LinkedHashMap<String,String>> maps=new ArrayList<>();
					for(int i = 0;i<list.size();i++){
						LinkedHashMap<String,String> hmap = new LinkedHashMap<String,String>();
						hmap.put("name",String.valueOf(list.get(i).getProduct().getProductName()));
						hmap.put("price",String.valueOf(list.get(i).getProduct().getPrice()));
						hmap.put("Stock",String.valueOf(list.get(i).getStock()));
						hmap.put("quantity",String.valueOf(list.get(i).getQuantity()));
						hmap.put("id",String.valueOf(list.get(i).getProduct().getProductID()));
						hmap.put("img",String.valueOf(list.get(i).getProduct().getImg()));
						maps.add(hmap);
					}
					
					  try {
				            ObjectMapper mapper = new ObjectMapper();
				            session.setAttribute("mycart", mapper);
				        }
				        catch (Exception e) {
				            e.printStackTrace();
				            throw new RuntimeException(e);
				        }
					return "Cart.jsp";
				}
		
		//直接購買
		@RequestMapping(path="/goToCart",method = RequestMethod.POST)
		public String goToCart(@RequestParam(name="id")int id,
				@RequestParam(name="quantity")int qty
				,HttpSession session) {
			
			Product product=pdao.getById(id);
			int stock =product.getStock();
			if(session.getAttribute("cart")!=null) {
				List<Cart> list=(List<Cart>)session.getAttribute("cart");
				int index=isExisting(id, session);
				
				
				if(qty>stock) { //檢驗庫存
					return "Cart.jsp";
				}else {
					if(index==-1) {
						list.add(new Cart(product,qty,stock-qty));
					}else {
						int q = list.get(index).getQuantity();
						if((qty+q)>stock){
							return "Cart";
						}else {
						list.get(index).setQuantity(qty+q);
						list.get(index).setStock(stock-(qty+q));
						}}
				}
				session.setAttribute("cart", list);
				
			}else {
				Cart cart=new Cart(product,1,stock-1); 
				List<Cart> list=new ArrayList<Cart>();
				list.add(cart);
				session.setAttribute("cart", list);
				
			}
			return "Cart.jsp";
		}
		//購物車頁面的商品數量調整
		@RequestMapping(path="/changeQuantity",method = RequestMethod.GET)
		public @ResponseBody List<Cart> changeQuanyity(@RequestParam(name="id")int id,
				@RequestParam(name="quantity")int quantity,
				HttpSession session){
			List<Cart> list=(List<Cart>)session.getAttribute("cart");
			int index=isExisting(id, session);
			Product product=pdao.getById(id);
			int stock =product.getStock();
			int tempStock=stock-quantity;
			
			if(tempStock<0) {
				return list;
			}else {
			System.out.println(stock);
			System.out.println(tempStock);
			list.get(index).setQuantity(quantity);
			list.get(index).setStock(tempStock);
			session.setAttribute("cart", list);
			return list;}
		}
		
		
		private int isExisting(int id,HttpSession session) {
			List<Cart> list=(List<Cart>)session.getAttribute("cart");
			for(int i =0;i<list.size();i++) 
				if(list.get(i).getProduct().getProductID()==id)
					return i;
			return -1;
				
		}
		
		
}
