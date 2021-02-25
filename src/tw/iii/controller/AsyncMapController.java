package tw.iii.controller;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonObjectFormatVisitor;

import tw.iii.model.GoogleMap;

import tw.iii.model.MapDao;


@Controller
public class AsyncMapController {

	@Autowired
	private MapDao mapDao;
	
	//這是非同步傳json 沒用到
	@RequestMapping(path = "/mapselect",method = RequestMethod.GET)
	public @ResponseBody String selectmap(@RequestParam(name="id")String id) throws InterruptedException, ExecutionException {
//		GoogleMap map  =Dao.select(Integer.parseInt(id));
//		LinkedHashMap<String,String> mapp = new LinkedHashMap<String,String>();
//		mapp.put("id",String.valueOf(map.getId()));
//		mapp.put("name",map.getMapname());
//		mapp.put("lat",String.valueOf(map.getLat()));
//		mapp.put("lng",String.valueOf(map.getLng()));
//		 System.out.println(map.getMapname());
		 //
		 List<GoogleMap> list= mapDao.selectAll();
			ArrayList<LinkedHashMap<String,String>> maps=new ArrayList<>();
			for(int i = 0;i<list.size();i++){
				LinkedHashMap<String,String> hmap = new LinkedHashMap<String,String>();
				hmap.put("id",String.valueOf(list.get(i).getId()));
				hmap.put("mapname",list.get(i).getMapname());
				hmap.put("tel",list.get(i).getTel());
				hmap.put("dress",list.get(i).getDress());
				hmap.put("lat",String.valueOf(list.get(i).getLat()));
				hmap.put("lng",String.valueOf(list.get(i).getLng()));
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
		
	//	return maps;
	}
	
	
	@RequestMapping(path = "/mapselect2get",method = RequestMethod.GET)
	public String selectmap2get(@RequestParam(name="city") String city,@RequestParam(name="id")int id,Model m) throws InterruptedException, ExecutionException {
		m.addAttribute("totalpage",Math.round(Math.ceil(mapDao.mapclasscount(city)*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
		m.addAttribute("currpage",0);//當前頁數
		m.addAttribute("mmm",mapDao.select(id));
		m.addAttribute("neww","a");
		m.addAttribute("selection","selectClass");
		m.addAttribute("cityList",mapDao.selectcitypage(city,0));
		m.addAttribute("init",false);
		m.addAttribute("navigation",false);
		m.addAttribute("country",false);
		 String url ="uploadtempDir/";
		 m.addAttribute("type2",0);
		m.addAttribute("countryname",city);
		return "WEB-INF/html/Map.jsp";
	}
	
	
	@RequestMapping(path = "/mapselect3",method = RequestMethod.POST)
	public String selectmap3(@RequestParam(name="type") int type,@RequestParam(name="starting") String starting,@RequestParam(name="city") String city,@RequestParam(name="id")String id,Model m) throws InterruptedException, ExecutionException {
		m.addAttribute("totalpage",Math.round(Math.ceil(mapDao.mapclasscount(city)*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
		m.addAttribute("currpage",0);//當前頁數
		m.addAttribute("type",type);
		m.addAttribute("country",false);
		m.addAttribute("navigation",true);
		m.addAttribute("starting",starting);
		m.addAttribute("mmm",mapDao.select(Integer.parseInt(id)));
		m.addAttribute("neww","a");
		m.addAttribute("selection","selectClass");
		m.addAttribute("cityList",mapDao.selectcitypage(city,0));
		m.addAttribute("init",false);
		m.addAttribute("countryname",city);
		 String url ="uploadtempDir/";
		 m.addAttribute("selection2",url);			
		 m.addAttribute("type2",0);
		
		return "WEB-INF/html/Map.jsp";
	}
	
	//條件查詢
			@RequestMapping(path = "/gomapcity",method = RequestMethod.GET)
			public String selectcity(@RequestParam(name="currpage")int currpage,@RequestParam(name="city") String city,Model m) {	
				int count =  currpage*5 ;
				m.addAttribute("totalpage",Math.round(Math.ceil(mapDao.mapclasscount(city)*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
				m.addAttribute("currpage",currpage);//當前頁數
				m.addAttribute("countryname",city);
				m.addAttribute("country",true);
				m.addAttribute("navigation",false);
				m.addAttribute("init",true);
				m.addAttribute("selection","selectClass");
				m.addAttribute("cityList",mapDao.selectcitypage(city,count));	
				m.addAttribute("type2",0);
				return "WEB-INF/html/Map.jsp";
			}
			
			//急診查詢
			@RequestMapping(path = "/select24h",method = RequestMethod.GET)
			public String select24h(@RequestParam(name="type") int type,@RequestParam(name="currpage")int currpage,@RequestParam(name="city") String city,Model m) {	
				int count =  currpage*5 ;
				
				m.addAttribute("currpage",currpage);//當前頁數
				m.addAttribute("countryname",city);
				m.addAttribute("country",true);
				m.addAttribute("navigation",false);
				m.addAttribute("init",true);
				m.addAttribute("selection","24h");
				m.addAttribute("cityList",mapDao.select24oremergency(count,city,type));				
				m.addAttribute("type2",type);
			    m.addAttribute("totalpage",Math.round(Math.ceil(mapDao.map24oremergencycount(city,type)*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
			
				
				
			
				return "WEB-INF/html/Map.jsp";
			}
}
