package tw.iii.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service
public class ProductService {
	@Autowired
	private ProductDao pDao;
	
	public Product getById(int productID) {
		return pDao.getById(productID);
	}
	public Product insert(Product PD) {
		return pDao.insert(PD);
	}
	public boolean delete(int productID) {
		return pDao.delete(productID);
	}
	public Product update( Product PD) {
		return pDao.update(PD);
	}
	public Product select(int productID) {
		return pDao.select(productID);
	}
	public List<Product> selectAll(){
		return pDao.selectAll();
	}

	public List<Product> selectnone(int stock){
		return pDao.selectnone(stock);
	}
	
	public List<Product> selectbrand(String brand){
		return pDao.selectbrand(brand);
	}
	public List<Product> selectAllOpen(){
		return pDao.selectAllOpen();
	}
	public List<Product> selectclose(String status){
		return pDao.selectclose(status);
	}
	public List<Product> selectspecies(String species){
		return pDao.selectspecies(species);
	}
	public List<Product> selectclass(String classification){
		return pDao.selectclass(classification);
	}
	public List<Product> selectwhere(int max,int min){
		return pDao.selectwhere(max, min);
	}
	public List<Product> selectbrandOpen(String brand){
		return pDao.selectbrandOpen(brand);
	}
	public List<Product> selectspeciesOpen(String species){
		return pDao.selectspeciesOpen(species);
	}
	public List<Product> selectclassOpen(String classification){
		return pDao.selectclassOpen(classification);
	}
	public List<Product> selectwhereOpen(int max, int min){
		return pDao.selectwhereOpen(max, min);
	}
	
	
	
	public Object count() {
		return pDao.count();
	}
	public Object countwhere(int max,int min) {
		return pDao.countwhere(max, min);
	}
	public Object countbrand(String brand) {
		return pDao.countbrand(brand);
	}
	public Object countspecies(String species) {
		return pDao.countspecies(species);
	}
	public Object countclass(String classification) {
		return pDao.countclass(classification);
	}
	public Object countnone(int stock) {
		return pDao.countnone(stock);
	}
	public Object countAllOpen() {
		return pDao.countAllOpen();
	}
	public Object countbrandOpen(String brand) {
		return pDao.countbrandOpen(brand);
	}
	public Object countclose(String status) {
		return pDao.countclose(status);
	}
	public Object countspeciesOpen(String species) {
		return pDao.countspeciesOpen(species);
	}
	public Object countclassOpen(String classification) {
		return pDao.countclassOpen(classification);
	}
	public Object countwhereOpen(int max, int min) {
		return pDao.countwhereOpen(max, min);
	}
	public boolean login(String username, String password) {
		return pDao.login(username, password);
	}


}