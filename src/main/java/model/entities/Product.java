package model.entities;

import java.util.Random;

public class Product {
	private int id;
	private String product;
	private String originalPrice;
	private String salePrice;
	private String numsold;
	private String url;
	private int categoryID;
	private int shopID;
	public Product(int id, String product, String originalPrice, String salePrice, String url,int shopID,int categoryID) {
		this.id=id;
		this.numsold=formSold((new Random()).nextInt((10000 - 1) + 1) + 1) ;
		this.product = product;
		this.originalPrice = form(originalPrice) ;
		this.salePrice = form(salePrice);
		this.url = url;
		this.shopID=shopID;
		this.categoryID=categoryID;
	}
	public Product(int id, String product, String originalPrice, String salePrice, String url,int shopID) {
		this.id=id;
		this.numsold=formSold((new Random()).nextInt((10000 - 1) + 1) + 1) ;
		this.product = product;
		this.originalPrice = form(originalPrice) ;
		this.salePrice = form(salePrice);
		this.url = url;
		this.shopID=shopID;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumsold() {
		return numsold;
	}

	public String getProduct() {
		return product;
	}
	public String getFewChar() {
		return product.length()>50? product.substring(0,50)+"...":product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = form(originalPrice);
	}
	public String getSalePrice() {
		return salePrice;
	}
	public void setSalePrice(String salePrice) {
		this.salePrice = form(salePrice);
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	public int getShopID() {
		return shopID;
	}

	public void setShopID(int shopID) {
		this.shopID = shopID;
	}

	public int getCategoryID() {
		return categoryID;
	}

	public void setCategoryID(int categoryID) {
		this.categoryID = categoryID;
	}

	public static String formMoney(String amount) {
		char num[]=amount.toCharArray();
		String money="";
		int len=0;
		for(int i=num.length-1; i>=0;i--) {
			len++; 
			money=num[i]+money;
			if(len%3==0 && len!=0 && i!=0) {
				money='.'+money;
			}
		}
		
		return money;
	}
	public static String form(String amount) {
		char[] num=amount.toCharArray();
		amount="";
		for(char a: num) if(a!='.' && a!=',')amount+=a;
		return amount;
	}
	public String formSold(long amount) {
		return (amount>=1000?  (amount/100/10.0)+"k":""+amount).replace('.', ',');
	}
}

