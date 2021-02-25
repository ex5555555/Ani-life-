package tw.iii.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;

import tw.iii.model.GoogleMap;
import tw.iii.model.MapDao;


@Controller
public class MapController {

	@Autowired
	private MapDao mapDao;
	
	
	//全部查詢
		@RequestMapping(path = "/gomap",method = RequestMethod.GET)
		public String entryAction(@RequestParam(name="currpage")int currpage,Model m) {
			int count =  currpage*5 ;
			m.addAttribute("totalpage",Math.round(Math.ceil(mapDao.mapcount()*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
			m.addAttribute("currpage",currpage);//當前頁數
			m.addAttribute("selection","all");
			m.addAttribute("MapList",mapDao.selectAllpage(count));	
			 String url ="uploadtempDir/";
			 m.addAttribute("selection2",url);	
			 m.addAttribute("init",true);
				m.addAttribute("navigation",false);
				m.addAttribute("country",false);
				m.addAttribute("countryname",null);
				m.addAttribute("type2",0);
			return "WEB-INF/html/Map.jsp";
			
		}
		
		
		@RequestMapping(path = "/gomapjson",method = RequestMethod.POST)
		public @ResponseBody String jsondd(@RequestParam(name="type") int type,Model m,@RequestParam(name="city") String city) {  
			List<GoogleMap> list;
			//
			if(type!=0) {				
				list =mapDao.selectcity24oremergency(city,type);
			}else {
				if(!city.equals("南投地理中心")) {
			     	list = mapDao.selectcity(city);
				}else {
					list = mapDao.selectAll();
					
				}
				
			}
			
			
				ArrayList<LinkedHashMap<String,GoogleMap>> maps=new ArrayList<>();
				for(int i = 0;i<list.size();i++){
					LinkedHashMap<String,GoogleMap> hmap = new LinkedHashMap<String,GoogleMap>();
				
					hmap.put("mappp",list.get(i));					
					maps.add(hmap);			
					}System.out.println(maps);	
				
				  try {
			            ObjectMapper mapper = new ObjectMapper();
			            return  mapper.writeValueAsString(maps);
			           
			        }
			        catch (Exception e) {
			            e.printStackTrace();
			            throw new RuntimeException(e);
			        }
			
		
		 }
}
