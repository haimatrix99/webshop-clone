package model.entities;

public class Cart {
	private int cartID;
	private int quantity;
	private String feature;
	private int clientID;
	private int productID;
	public Cart(int cartID, int quantity, String feature, int clientID, int productID) {
		this.cartID = cartID;
		this.quantity = quantity;
		this.feature = feature;
		this.clientID = clientID;
		this.productID = productID;
	}
	public int getCartID() {
		return cartID;
	}
	public void setCartID(int cartID) {
		this.cartID = cartID;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public String getFeature() {
		return feature;
	}
	public void setFeature(String feature) {
		this.feature = feature;
	}
	public int getClientID() {
		return clientID;
	}
	public void setClientID(int clientID) {
		this.clientID = clientID;
	}
	public int getProductID() {
		return productID;
	}
	public void setProductID(int productID) {
		this.productID = productID;
	}
	
}
