package tw.iii.model;

public class Cart {
	private Product product;
	private int quantity;
	private int tempstock;

	public Cart() {
	}
	
	public Cart(Product product,int quantity) {
		this.product=product;
		this.quantity=quantity;
	}
	public Cart(Product product,int quantity,int tempstock) {
		this.product=product;
		this.quantity=quantity;
		this.tempstock=tempstock;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getStock() {
		return tempstock;
	}

	public void setStock(int tempstock) {
		this.tempstock = tempstock;
	}

}
