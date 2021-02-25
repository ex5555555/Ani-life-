package tw.iii.Backstage.Controller;


import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.annotation.RequestScope;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;

import tw.iii.model.Product;
import tw.iii.model.ProductDao;
import tw.iii.model.ProductService;

@Controller
public class BackSideProductController {
	@Autowired
	private ProductService pService;

	@Autowired
	private ProductDao pDao;

	@Autowired
	private HttpServletRequest req;

	// 跳轉至產品管理頁面
	@RequestMapping(path = "/bsProductManagement", method = RequestMethod.GET)
	public String bsProductManagement(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<Product> list = pService.selectAll();
		m.addAttribute("selected", "bsAll");
		m.addAttribute("bsproductList", pService.selectAll());
		m.addAttribute("bscount", String.valueOf(pService.count()));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	// 跳轉至新增頁面
	@RequestMapping(path = "/toBsCreateProduct", method = RequestMethod.GET)
	public String bsCreateProduct(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<Product> list = pService.selectAll();
		m.addAttribute("bsproductList", list);
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideCreateProduct.jsp";
	}

	/*
	 * // 跳轉至確認頁面
	 * 
	 * @RequestMapping(path = "/toConfirmPage", method = RequestMethod.POST) public
	 * String toConfirmPage(@RequestParam(name = "id") int
	 * productID,@RequestParam(name = "productname") String productName,
	 * 
	 * @RequestParam(name = "stock") int stock, @RequestParam(name = "price") int
	 * price,
	 * 
	 * @RequestParam(name = "species") String species, @RequestParam(name =
	 * "classification") String classf,
	 * 
	 * @RequestParam(name = "brand") String brand, @RequestParam(name =
	 * "descripton") String descripton,
	 * 
	 * @RequestParam(name = "status") String status, @RequestParam(name = "myfile")
	 * MultipartFile mfile, Model m) {
	 * 
	 * 
	 * 
	 * m.addAttribute("productID",productID); m.addAttribute("stock",stock);
	 * m.addAttribute("price",price); m.addAttribute("productname",productName);
	 * m.addAttribute("species",species); m.addAttribute("classfisication",classf);
	 * m.addAttribute("brand",brand); m.addAttribute("descripton",descripton);
	 * m.addAttribute("status",status);
	 * 
	 * 
	 * return "BackSideProductConfrim.jsp"; }
	 */
	

	// 新增
	@RequestMapping(path = "/bsAddProduct", method = RequestMethod.POST)
	public String bsAddProduct(@RequestParam(name = "productname") String productName,
			@RequestParam(name = "stock") int stock, @RequestParam(name = "price") int price,
			@RequestParam(name = "species") String species, @RequestParam(name = "classification") String classf,
			@RequestParam(name = "brand") String brand, @RequestParam(name = "descripton") String descripton,
			@RequestParam(name = "status") String status, @RequestParam(name = "myfile") MultipartFile mfile, Model m,@RequestParam(name = "eeaccount") String eeaccount)
			throws IOException {
		Product product = new Product(productName, stock, price, species, classf, brand, descripton, status);

		if (!mfile.isEmpty()) {
			String filename = mfile.getOriginalFilename();
			String savepath = "C:\\Users\\iii\\Downloads\\SpringMVC_forum_Map0130_0632\\WebContent\\WEB-INF\\img";
			

			File file = new File(savepath);
			file.mkdirs();
			File savefile = new File(file, filename);
			InputStream inn = mfile.getInputStream();
			FileOutputStream fos = new FileOutputStream(savefile);
			byte[] bb = new byte[1024];
			int le = -1;
			while ((le = inn.read(bb)) != -1) {
				fos.write(bb, 0, le);
			}
			product.setImg(filename);
		} else {
			product.setImg(null);
		}

		pService.insert(product);
		m.addAttribute("eeaccount",eeaccount);
		System.out.println("新增成功!!");
		return "/WEB-INF/Backstage/BackSideCreateProduct.jsp";
	}

	// 刪除
	@RequestMapping(path = "/bsDelProduct", method = RequestMethod.GET)
	public String bsDelProduct(@RequestParam(name = "id") int id, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		pService.delete(id);

		return bsSelectAll(m,eeaccount);
	}

	// 跳轉至更新頁面
	@RequestMapping(path = "/toBsUpdateProduct", method = RequestMethod.GET)
	public String toBsUpdateProduct(@RequestParam(name = "id") int id, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<Product> list = pService.selectAll();
		m.addAttribute("bsproductList", list);

		Product pbean = pService.select(id);
		m.addAttribute("product", pbean);
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductUpdate.jsp";
	}

	// 更新
	@RequestMapping(path = "/bsUpdateProduct", method = RequestMethod.POST)
	public String bsUpdateProduct(@RequestParam(name = "id") int productID,
			@RequestParam(name = "productname") String productName, @RequestParam(name = "stock") int stock,
			@RequestParam(name = "price") int price, @RequestParam(name = "species") String species,
			@RequestParam(name = "classification") String classification, @RequestParam(name = "brand") String brand,
			@RequestParam(name = "descripton") String descripton, @RequestParam(name = "status") String status,
			@RequestParam(name = "myfile") MultipartFile mfile, Model m,@RequestParam(name = "eeaccount") String eeaccount) throws IOException {
		System.out.println(
				productID + productName + stock + price + species + classification + brand + descripton + status);
		Product product = pDao.select(productID);
		product.setProductName(productName);
		product.setStock(stock);
		product.setBrand(brand);
		product.setClassification(classification);
		product.setDescripton(descripton);
		product.setSpecies(species);
		product.setPrice(price);
		product.setStatus(status);
		System.out.println(product.getProductID());

		if (!mfile.isEmpty()) {
			String filename = mfile.getOriginalFilename();
			String savepath = "C:\\Users\\iii\\Downloads\\SpringMVC_forum_Map0130_0632\\WebContent\\WEB-INF\\img";
			File file = new File(savepath);
			file.mkdirs();
			File savefile = new File(file, filename);
			InputStream inn = mfile.getInputStream();
			FileOutputStream fos = new FileOutputStream(savefile);
			byte[] bb = new byte[1024];
			int le = -1;
			while ((le = inn.read(bb)) != -1) {
				fos.write(bb, 0, le);
			}
			product.setImg(filename);
		}

		pService.update(product);

		System.out.println("更新成功!!");

	

		return bsSelectAll(m,eeaccount);
	}

	// 全部查詢
	@RequestMapping(path = "/bsSelectAll", method = RequestMethod.POST)
	public String bsSelectAll(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsAll");
		m.addAttribute("bsproductList", pService.selectAll());
		m.addAttribute("bscount", String.valueOf(pService.count()));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	// 上架
	@RequestMapping(path = "/statusOpen", method = RequestMethod.GET)
	public String statusOpen(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "open");
		m.addAttribute("bsproductList", pService.selectAllOpen());
		m.addAttribute("bscount", String.valueOf(pDao.countAllOpen()));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	// 下架
	@RequestMapping(path = "/statusClose", method = RequestMethod.GET)
	public String statusClose(@RequestParam(name = "status") String status, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "close");
		m.addAttribute("bsproductList", pDao.selectclose(status));
		m.addAttribute("bscount", String.valueOf(pDao.countclose(status)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	// 缺貨
	@RequestMapping(path = "/stocknone", method = RequestMethod.GET)
	public String stocknone(@RequestParam(name = "stock") int stock, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "none");
		m.addAttribute("bsproductList", pDao.selectnone(stock));
		m.addAttribute("bscount", String.valueOf(pDao.countnone(stock)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}
	
	// 去分類查詢
	@RequestMapping(path = "/tobsSelect", method = RequestMethod.GET)
	public String tobsSelectSpecies(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductSelect.jsp";
	}
	
	// 動物分類查詢
	@RequestMapping(path = "/bsSelectSpecies", method = RequestMethod.GET)
	public String bsSelectSpecies(@RequestParam(name = "species") String species, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsSelectSpecies");
		m.addAttribute("bsproductList", pService.selectspecies(species));
		m.addAttribute("bscount", String.valueOf(pService.countspecies(species)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	// 動物分類查詢   post
	@RequestMapping(path = "/bsSelectSpecies2", method = RequestMethod.POST)
	public String bsSelectSpecies2(@RequestParam(name = "species") String species, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsSelectSpecies");
		m.addAttribute("bsproductList", pService.selectspecies(species));
		m.addAttribute("bscount", String.valueOf(pService.countspecies(species)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}
	
	// 品牌查詢
	@RequestMapping(path = "/bsSelectBrand", method = RequestMethod.GET)
	public String bsSelectBrand(@RequestParam(name = "brand") String brand, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsSelectBrand");
		m.addAttribute("bsproductList", pService.selectbrand(brand));
		m.addAttribute("bscount", String.valueOf(pService.countbrand(brand)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	// 品牌查詢   post
	@RequestMapping(path = "/bsSelectBrand2", method = RequestMethod.POST)
	public String bsSelectBrand2(@RequestParam(name = "brand") String brand, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsSelectBrand");
		m.addAttribute("bsproductList", pService.selectbrand(brand));
		m.addAttribute("bscount", String.valueOf(pService.countbrand(brand)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}
	
	// 產品種類查詢
	@RequestMapping(path = "/bsSelectClass", method = RequestMethod.GET)
	public String bsSelectClass(@RequestParam(name = "classification") String classf, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsSelectClass");
		m.addAttribute("bsproductList", pService.selectclass(classf));
		m.addAttribute("bscount", String.valueOf(pService.countclass(classf)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	// 產品種類查詢   post
	@RequestMapping(path = "/bsSelectClass2", method = RequestMethod.POST)
	public String bsSelectClass2(@RequestParam(name = "classification") String classf, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsSelectClass");
		m.addAttribute("bsproductList", pService.selectclass(classf));
		m.addAttribute("bscount", String.valueOf(pService.countclass(classf)));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}
	
	// 價格查詢
	@RequestMapping(path = "/bsSelectPrice", method = RequestMethod.POST)
	public String bsSelectPrice(@RequestParam(name = "max") String max, @RequestParam(name = "min") String min,
			Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		m.addAttribute("selected", "bsLimitPrice");
		m.addAttribute("bsproductList", pService.selectwhere(Integer.parseInt(max), Integer.parseInt(min)));
		m.addAttribute("bscount", String.valueOf(pService.countwhere(Integer.parseInt(max), Integer.parseInt(min))));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}

	@RequestMapping(path = "/bsGetAllProduct", method = RequestMethod.GET)
	public String bsGetAllProduct(Model m,@RequestParam(name = "eeaccount") String eeaccount) {
		List<Product> list = pService.selectAll();
		m.addAttribute("bsproductList", list);
		m.addAttribute("bscount", String.valueOf(pService.count()));
		m.addAttribute("eeaccount",eeaccount);
		return "/WEB-INF/Backstage/BackSideProductManagement.jsp";
	}
	
	
	
	// 產品銷售前10
		@RequestMapping(path = "/salepaper", method = RequestMethod.GET)
		public @ResponseBody String salepaper() throws InterruptedException, ExecutionException {
			ArrayList<LinkedHashMap<String, Object>> map = new ArrayList<>();

			List<Object[]> pd = (List<Object[]>) pDao.pdsalepaper();

			for (Object[] obj : pd) {
				LinkedHashMap<String, Object> pdmap = new LinkedHashMap<String, Object>();
				String pname = (String) obj[0];
				Long sum = (Long) (obj[1]);
				pdmap.put("productname", pname);
				pdmap.put("sum", sum);
				map.add(pdmap);
			}
			System.out.println(map);

			try {
				ObjectMapper mapper = new ObjectMapper();
				return mapper.writeValueAsString(map);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}

		}

		// 品牌銷售排行
		@SuppressWarnings("unchecked")
		@RequestMapping(path = "/brandpaper", method = RequestMethod.GET)
		public @ResponseBody String brandpaper() throws InterruptedException, ExecutionException {
			ArrayList<LinkedHashMap<String, Object>> map = new ArrayList<>();
			List<Object[]> pd = (List<Object[]>) pDao.pdbrandpaper();
			System.out.println("123");
			LinkedHashMap<String, Integer> mapp = new LinkedHashMap<String, Integer>();
			mapp.put("ROYAL法國皇家", 0);
			mapp.put("BLACKWOOD柏萊富", 0);
			mapp.put("Hills希爾思", 0);
			mapp.put("Nutram紐頓", 0);
			mapp.put("ORIJEN渴望", 0);
			mapp.put("Toma-pro優格", 0);
			System.out.println(mapp);

			for (Object[] obj : pd) {
				Integer pid = (Integer) obj[0];
				Long sum = (Long) (obj[1]);
				String brand = pDao.getById(pid).getBrand();
				for (Map.Entry<String, Integer> maps : mapp.entrySet()) {
					if (brand.equals(maps.getKey())) {
						mapp.replace(maps.getKey(), (int) (maps.getValue() + sum));
					}
				}
			}
			for (Map.Entry<String, Integer> maps : mapp.entrySet()) {
				LinkedHashMap<String, Object> mmap = new LinkedHashMap<String, Object>();
				System.out.println("keysss" + maps.getKey());
				mmap.put("productname", maps.getKey());
				mmap.put("sum", maps.getValue());
				map.add(mmap);
			}
			try {
				ObjectMapper mapper = new ObjectMapper();
				return mapper.writeValueAsString(map);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}

		}

		// 月份銷售報表
		@RequestMapping(path = "/monsalepaper", method = RequestMethod.GET)
		public @ResponseBody String monsalepaper() throws InterruptedException, ExecutionException {
			ArrayList<LinkedHashMap<String, Object>> map = new ArrayList<>();
			List<Object[]> pd = (List<Object[]>) pDao.monsalepaper();
			for (Object[] obj : pd) {
				LinkedHashMap<String, Object> pdmap = new LinkedHashMap<String, Object>();
				String pname = (String) obj[0];
				System.out.println(obj[1].toString());
				Long sum = (Long) (obj[2]);
				if(obj[1].toString().length()==1) {
					pdmap.put("productname", pname+"  "+"  "+"0"+obj[1].toString()+"月");
				}else {
				pdmap.put("productname", pname+"  "+"  "+"  "+obj[1].toString()+"月");
				}
				pdmap.put("sum", sum);
				map.add(pdmap);
			}
			System.out.println(map);

			try {
				ObjectMapper mapper = new ObjectMapper();
				return mapper.writeValueAsString(map);
			} catch (Exception e) {
				e.printStackTrace();
				throw new RuntimeException(e);
			}

		}

		@RequestMapping(path = "/paper", method = RequestMethod.GET)
		public String paper(@RequestParam(name = "how") int how, Model m,@RequestParam(name = "eeaccount") String eeaccount) {
			ArrayList<LinkedHashMap<String, Object>> map = new ArrayList<>();
			m.addAttribute("eeaccount",eeaccount);
			

			if (how == 1) {
				List<Object[]> list = pDao.salepaper(how);
				List<Product> pd = new ArrayList<Product>();

				for (Object[] obj : list) {

					String pname = (String) obj[0];
					Long sum = (Long) (obj[1]);
					Product product = pDao.getname2(pname);
					product.setSum(sum);
					pd.add(product);

				}
				m.addAttribute("productlist", pd);
			
			} else if (how == 2) {
				LinkedHashMap<String, Integer> mapp = new LinkedHashMap<String, Integer>();
				mapp.put("Hills希爾思", 0);
				mapp.put("BLACKWOOD柏萊富", 0);
				mapp.put("ORIJEN渴望", 0);
				mapp.put("ROYAL法國皇家", 0);
				mapp.put("Nutram紐頓", 0);
				mapp.put("Toma-pro優格", 0);
				
				LinkedHashMap<String, Object> pdmap = new LinkedHashMap<String, Object>();
				List<Object[]> list = pDao.salepaper(how);
				
				for (Object[] obj :list ) {
					Integer pid = (Integer) obj[0];
					Long sum = (Long) (obj[1]);
					String brand = pDao.getById(pid).getBrand();
					for (Map.Entry<String, Integer> maps : mapp.entrySet()) {
						if (brand.equals(maps.getKey())) {
							mapp.replace(maps.getKey(), (int) (maps.getValue() + sum));
						}
					}
				}
				for (Map.Entry<String, Integer> maps : mapp.entrySet()) {
					LinkedHashMap<String, Object> mmap = new LinkedHashMap<String, Object>();
				
					mmap.put("brand", maps.getKey());
					mmap.put("sum", maps.getValue());
					map.add(mmap);
				}
				
				m.addAttribute("productlist", map);
			

				
			} else {
				List<Object[]> list = pDao.salepaper(how);
			

				for (Object[] obj : list) {
					LinkedHashMap<String, Object> pdmap = new LinkedHashMap<String, Object>();
					String pname = (String) obj[0];
					Long sum = (Long) (obj[2]);
					 pdmap.put("brand",pname+"年"+obj[1].toString()+"月");
					 pdmap.put("sum",sum);
					 map.add(pdmap);

				}
				m.addAttribute("productlist", map);
				

			}
			
			m.addAttribute("how", how);
			return "/WEB-INF/Backstage/paper.jsp";

		}
		
		
}