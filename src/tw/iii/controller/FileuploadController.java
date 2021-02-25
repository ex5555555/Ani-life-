package tw.iii.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import tw.iii.model.Forum;
import tw.iii.model.ForumDao;
import tw.iii.model.ForumDetail;
import tw.iii.model.ForumSpecies;
import tw.iii.model.GoogleMap;
import tw.iii.model.MemberService;
import tw.iii.model.Product;
import tw.iii.model.ProductDao;
import tw.iii.model.TradingDao;

import org.springframework.security.core.context.SecurityContextHolder;

@Controller
public class FileuploadController {
	 String s;
		@Autowired
		private HttpServletRequest req;
	
		@Autowired
		private MemberService mbs;
		
		@Autowired
		private ForumDao forumDao;
		
		@Autowired
		private TradingDao tdao;
	
		@Autowired
		private ProductDao pdao;
		
		@RequestMapping(path = "/gohome",method = RequestMethod.GET)
		public String homehot(Model m) throws IOException {
		List<Integer> list =forumDao.selecthotForum();
			for(int i = 0;i<list.size();i++) {
			
			m.addAttribute("hotforum"+i,forumDao.showheadDetail(list.get(i)));
			m.addAttribute("hottitle"+i,forumDao.selecttitle(list.get(i)));
			}
		//首頁熱門產品
		List<String> pnamelist = tdao.selectTopProduct();
		List<Product> productlist=new ArrayList<Product>();
		
		for(String str:pnamelist) {
			String productname=str;
			Product p =(Product)pdao.getByName(productname);
			productlist.add(p);
		}
			m.addAttribute("productlist",productlist);
			return "home.jsp";
		}
		 
		@RequestMapping(path = "/gocreateeditor",method = RequestMethod.GET)
		public String createeditor(Model m,@RequestParam(name="forumid") int forumid) throws IOException {
			 m.addAttribute("id",forumid);
			
			return "WEB-INF/html/CreateEditor.jsp";
		}
		
		
		
		@RequestMapping(path = "/goeditor",method = RequestMethod.GET)
		public String goeditor(Model m,@RequestParam(name="forumid") int forumid,@RequestParam(name="fdid") int fdid) throws IOException {
			if(fdid!=0) {
				 m.addAttribute("fdid",forumDao.selectoneDetail(fdid));
				
				
				
			}  
			 m.addAttribute("id",forumid);
			 m.addAttribute("title",forumDao.selecttitle(forumid));
			 String url ="uploadtempDir/";
			 m.addAttribute("selection2",url);	
			return "WEB-INF/html/Editor.jsp";
		}
		
		@RequestMapping(path = "/goforum",method = RequestMethod.GET)
		public String goforum(@RequestParam(name="currpage")int currpage,Model m) throws IOException {	
		
			int count =  currpage*5 ;
			//頁數
			m.addAttribute("totalpage",Math.round(Math.ceil(forumDao.Forumcount()*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
			m.addAttribute("currpage",currpage);//當前頁數
			 //登入
			String account = SecurityContextHolder.getContext().getAuthentication().getName();
			m.addAttribute("user",SecurityContextHolder.getContext().getAuthentication().getName());	
			m.addAttribute("memberdata",mbs.select(account).get(0));
			//顯示討論版需要的參數
			m.addAttribute("AllSpecies",forumDao.selectAllSpecies());	
				
			m.addAttribute("forumid",forumDao.selectAllForum().size()+1);	
			m.addAttribute("selection","all");	
			m.addAttribute("newforum",forumDao.selectnewforum());
		
				List<Forum> list1 = forumDao.selectlistForum(count);
				List<ForumDetail> list2 = forumDao.selectfl(count);
				List<Integer>  list3 = forumDao.flcount(count);
				ArrayList<LinkedHashMap<String,Object>> maps=new ArrayList<>();
				System.out.println();
				for(int i = 0;i<list1.size();i++){
					LinkedHashMap<String,Object> hmap = new LinkedHashMap<String,Object>();				
					hmap.put("forum",list1.get(i));			
					hmap.put("forumdetail",list2.get(i));	
					hmap.put("flcount",list3.get(i));	
					
					maps.add(hmap);			
					}
				m.addAttribute("AllForum",maps);	
				
				System.out.println("count="+count);
				System.out.println("總共"+forumDao.Forumcount()+"筆");
				System.out.println("總共"+Math.ceil(forumDao.Forumcount()*1.0 / 5)+"頁");
				
			return "WEB-INF/html/Forum.jsp";
		}
	
		
		@RequestMapping(path = "/selectforumspecies",method = RequestMethod.GET)
		public String selectforumspecies(@RequestParam(name="currpage")int currpage,@RequestParam(name="fiid")int fiid,Model m) {
			//頁數
			int count =  currpage*5 ;
			m.addAttribute("totalpage",Math.round(Math.ceil(forumDao.Forumclasscount(fiid)*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
			m.addAttribute("currpage",currpage);//當前頁數			
			
			
     	//發文權限			
			String account = SecurityContextHolder.getContext().getAuthentication().getName();
			m.addAttribute("user",SecurityContextHolder.getContext().getAuthentication().getName());	
			m.addAttribute("memberdata",mbs.select(account).get(0));

			//顯示討論版需要的參數
			m.addAttribute("AllSpecies",forumDao.selectAllSpecies());				
			m.addAttribute("copyfid",fiid);	
			m.addAttribute("forumid",forumDao.selectAllForum().size()+1);				
			m.addAttribute("selection","selectClass");
			m.addAttribute("newforum",forumDao.selectnewforum());
			List<Object[]> list1 = forumDao.selectflSpecies(fiid,count);		
			List<Integer>  list3 = forumDao.flcountSpecies(fiid,count);
			ArrayList<LinkedHashMap<String,Object>> maps=new ArrayList<>();
			System.out.println();
			for(int i = 0;i<list1.size();i++){		
				LinkedHashMap<String,Object> hmap = new LinkedHashMap<String,Object>();	
				hmap.put("forum",(Forum)list1.get(i)[0]);
				hmap.put("content",list1.get(i)[1]);
				hmap.put("flcount",list3.get(i));					
				maps.add(hmap);			
				}
			m.addAttribute("forumlist",maps);	
			return "WEB-INF/html/Forum.jsp";
		}
		
		
		@RequestMapping(path = "/goforumdetail",method = RequestMethod.GET)
		public String goforumdetail(Model m,@RequestParam(name="forumid") int forumid) throws IOException {
			String account = SecurityContextHolder.getContext().getAuthentication().getName();
			m.addAttribute("user",SecurityContextHolder.getContext().getAuthentication().getName());	
			m.addAttribute("memberdata",mbs.select(account).get(0));
			 m.addAttribute("id",forumid);
			 m.addAttribute("title",forumDao.selecttitle(forumid));
			m.addAttribute("forumdata",forumDao.showDetail(forumid));	
			m.addAttribute("forumid",forumDao.selectAllForum().size()+1);	
			m.addAttribute("AllSpecies",forumDao.selectAllSpecies());	
			return "WEB-INF/html/ForumDetail.jsp";
			
		}
		
		
		@RequestMapping(value ="/createnewforum",method = RequestMethod.POST)
		public  String CreateNewForum(@RequestParam(name="myfile") MultipartFile mfile,@RequestParam(name="species")int species,@RequestParam(name="forumid")int forumid,@RequestParam(name="title") String title,@RequestParam(name="content") String content,
				Model m) throws IllegalStateException, IOException, ParseException{
			System.out.println("forumid="+forumid+"species="+species);
			String account =SecurityContextHolder.getContext().getAuthentication().getName() ;
			 Date dNow = new Date( );
			    SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd HH:mm:ss");
			    String datetime = ft.format(dNow);
			    Date fdate= ft.parse(datetime);
			    ForumSpecies FS =forumDao.selectForumSpecies(species);
			    System.out.println(FS.getFsid());
			    Forum forum=new Forum(species,title,account,fdate,FS);
			    ForumDetail forumDetail=new ForumDetail(forumid,account,content,fdate,forum);
			    forumDetail.setFl(1);
			    if(!mfile.isEmpty()) {
				    String filename= mfile.getOriginalFilename();
				 String savepath =req.getServletContext().getRealPath("/")+"uploadtempDir\\";
			   	 File file = new File(savepath);
				 file.mkdirs();
				 File savefile = new File(file,filename);
				 InputStream inn = mfile.getInputStream();
				 FileOutputStream fos = new FileOutputStream(savefile);
				 byte[] bb = new byte[1024];
				 int le = -1;
				 while((le=inn.read(bb))!=-1) {
					 fos.write(bb,0,le);		 
				 }
				 forumDetail.setImg(filename);
				 }else {
					 forumDetail.setImg(null);
				 }
			    Set<ForumDetail>  setforumDetail = new HashSet<ForumDetail>();
			    setforumDetail.add(forumDetail);
			    forum.setForumDetail(setforumDetail);
			    
			    Set<Forum>  SP = new HashSet<Forum>();
			    SP.add(forum);
			    FS.setForum(SP);
			    forumDao.insertForumSP(FS);
			    System.out.println("交易成功");
	     	
			   
			return    goforumdetail(m,forumid);
			 
		//	insertForum_Detail()l
			
		}
		
		
		@RequestMapping(value ="/fileuploadcontroller",method = RequestMethod.POST)
	public  String processFileupload(@RequestParam(name="myfile") MultipartFile mfile,@RequestParam(name="title") String title,@RequestParam(name="forumid") int forumid,@RequestParam(name="fdid") int fdid,@RequestParam(name="content") String content,
			Model m) throws IllegalStateException, IOException, ParseException{
	
	
	    ForumDetail fd=new ForumDetail();
		String account =SecurityContextHolder.getContext().getAuthentication().getName() ;
		Date dNow = new Date( );
	    SimpleDateFormat ft = new SimpleDateFormat ("yyyy-MM-dd hh:mm:ss");
	    String datetime = ft.format(dNow);
	    Date fdate= ft.parse(datetime);
	    String filename= mfile.getOriginalFilename();
	 if(!mfile.isEmpty()) {
	 String savepath =req.getServletContext().getRealPath("/")+"uploadtempDir\\";
   	 File file = new File(savepath);
	 file.mkdirs();
	 File savefile = new File(file,filename);
	 InputStream inn = mfile.getInputStream();
	 FileOutputStream fos = new FileOutputStream(savefile);
	 byte[] bb = new byte[1024];
	 int le = -1;
	 while((le=inn.read(bb))!=-1) {
		 fos.write(bb,0,le);		 
	 }
	 fd.setImg(filename);
	 }else {
		 fd.setImg(null);//目前需要想
	 }
	 
	 if(fdid!=0) {
		 fd=forumDao.selectoneDetail(fdid);
		 if(!mfile.isEmpty()) {
			 fd.setImg(filename);
			 
		 }
	}	
	 if(fdid==0) {
		 int fl = forumDao.fl(forumid);
		 fd.setFl(fl+1);
		 
	 }
	  Forum forum= forumDao.selectff(forumid);
	
	 if(title!="") {
		 forum.setTitle(title);
		 
	 } 
	     fd.setAccount(account);
		 fd.setContent(content);
		 fd.setDate(fdate);
		 fd.setForum(forum);
		 fd.setCopyfdid(forumid);
		
		 Set<ForumDetail>  ForumDetail = new HashSet<ForumDetail>();
		 ForumDetail.add(fd);
		 forum.setForumDetail(ForumDetail);
	 forumDao.insertb(forum);
	System.out.println("成功儲存");
	

		
	

	
//這邊都是非同步的處理 //回傳json
//	LinkedHashMap<String,String> hmap = new LinkedHashMap<String,String>();
//			hmap.put("id",String.valueOf(fff.getId()));
//			hmap.put("account",fff.getaccount());
//			hmap.put("title",fff.getTitle());
//			hmap.put("content",fff.getContent());
//			hmap.put("img",fff.getImg());
//			hmap.put("date",ft.format(fff.getDate()));
//		
//		System.out.println(hmap);
//		
//		  try {
//	            ObjectMapper mapper = new ObjectMapper();
//	            return mapper.writeValueAsString(hmap);
//	        }
//	        catch (Exception e) {
//	            e.printStackTrace();
//	            throw new RuntimeException(e);
//	        }
	

	 return goforumdetail(m,forumid);
	
	//同步版本換這個 然後把json給//   還有 @ResponseBody
	//return "WEB-INF/html/Forum.jsp";
	
	}
		
		
@RequestMapping(value ="/delete",method = RequestMethod.GET)
public  String delete(@RequestParam(name="fl") int fl,@RequestParam(name="fdid") int fdid,@RequestParam(name="forumid") int forumid,Model m) throws IllegalStateException, IOException, ParseException{
		
	boolean delete = forumDao.deletedetail(fdid);
	if(fl==1){		
		forumDao.deleteforum(forumid);
		return goforum(1,m);
	}
	 return goforumdetail(m,forumid);
}
		
@RequestMapping(path = "/selectkeyword",method = RequestMethod.POST)
public String selectkeyword(@RequestParam(name="currpage")int currpage,@RequestParam(name="keyword")String keyword,Model m) {
	//頁數
	int count =  currpage*5 ;
	m.addAttribute("totalpage",Math.round(Math.ceil(forumDao.Forumkeywordcount(keyword)*1.0 / 5)));//總筆數除以一次顯示幾筆=需要幾頁 
	m.addAttribute("currpage",currpage);//當前頁數			
	 //登入
	m.addAttribute("user",SecurityContextHolder.getContext().getAuthentication().getName());	

	//顯示討論版需要的參數
	m.addAttribute("AllSpecies",forumDao.selectAllSpecies());				
	
	m.addAttribute("forumid",forumDao.selectAllForum().size()+1);				
	m.addAttribute("selection","keyword");
	m.addAttribute("newforum",forumDao.selectnewforum());
	List<Object[]> list1 =  forumDao.selectflSpeciesbuffer(keyword,count);
	//List<Integer>  list3 = forumDao.flcountSpecies(fiid,count);
	ArrayList<LinkedHashMap<String,Object>> maps=new ArrayList<>();
if(list1.size()!=0) {
	for(int i = 0;i<list1.size();i++){		
		LinkedHashMap<String,Object> hmap = new LinkedHashMap<String,Object>();	
		hmap.put("forum",(Forum)list1.get(i)[0]);
		hmap.put("content",list1.get(i)[1]);
		//hmap.put("flcount",list3.get(i));					
		maps.add(hmap);			
		}
	m.addAttribute("forumkeyword",maps);	
}else {
	m.addAttribute("forumkeyword",null);	
	
}
	
	return "WEB-INF/html/Forum.jsp";
}


@RequestMapping(path = "/gomyforum",method = RequestMethod.GET)
public String gomyforum(Model m) throws IOException {
	String account=SecurityContextHolder.getContext().getAuthentication().getName();
	m.addAttribute("user",account);	
	List<Forum> list =forumDao.selectaccountforum(account);
	if(list.size()>0) {
	m.addAttribute("myforum",list);
	}else {
	m.addAttribute("myforum","null");		
	}
	
	List<ForumDetail> list2=forumDao.selectaccountforumdetail(account);
	if(list2.size()>0) { 
	m.addAttribute("myforumdetail",list2);
	}else {
	m.addAttribute("myforumdetail","null");		
	}
	m.addAttribute("gomyforum","myforum");
	return "member.jsp";
	
}

		
	
}
