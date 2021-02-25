package tw.iii.model;

import java.util.List;

public interface IproductDao {
	//前台
	public List<Product> selectAllOpen();
	public List<Product> selectspeciesOpen(String species);
	public List<Product> selectclassOpen(String classification);
	public List<Product> selectbrandOpen(String brand);
	public List<Product> selectwhereOpen(int max, int min);
	public Object countbrandOpen(String brand);
	public Object countspeciesOpen(String species);
	public Object countclassOpen(String classification);
	public Object countwhereOpen(int max, int min);
	public Product getById(int productID);
	public Object countAllOpen();
		
	//後台
	public Product insert(Product PD);
	public boolean delete(int productID);
	public Product select(int productID);
	public Product update(Product PD);
	public List<Product> selectAll();
	public List<Product> selectnone(int stock);
	public List<Product> selectbrand(String brand);
	public List<Product> selectspecies(String species);
	public List<Product> selectclass(String classification);
	public List<Product> selectwhere(int max,int min) ;
	public List<Product> selectclose(String status);
	public Object count();
	public Object countwhere(int max,int min);
	public Object countbrand(String brand);
	public Object countspecies(String species);
	public Object countclass(String classification);
	public Object countclose(String status);
	public Object countnone(int stock);
	
	
	public boolean login(String username, String password);
	Long CountConditionOpen(int how, String condition, int max, int min);
	List<Product> SelectConditionOpen(int how, String condition, int page, int max, int min,String productname);
	List<Object[]> salepaper(int how);

	

}