package model.BOs;

import java.util.ArrayList;

import model.DAOs.OwnerShopDAO;
import model.entities.Shop;

public class OwnerShopBO {
    public static void addShopToData(Shop shop) {
    	OwnerShopDAO.insert(shop.getUser(), shop.getPass(), shop.getNameShop(), shop.getUrlAvatar());
    }
    public static ArrayList<Shop> getShops() {
		return OwnerShopDAO.findAll();
    }
    public static Shop getShopByID(int shopID) {
    	
		return OwnerShopDAO.findByShopId(shopID);
    }
    public static Shop getAccesser(String user, String pass) {
		return OwnerShopDAO.findByUserAndPass(user, pass);
    	
    }
}
