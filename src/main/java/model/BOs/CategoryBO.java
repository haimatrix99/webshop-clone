package model.BOs;

import java.util.ArrayList;

import model.DAOs.CategoryDAO;
import model.entities.Category;

public class CategoryBO {
    public static String getCategory(int categoryID) {

		return CategoryDAO.findByCategoryId(categoryID);
    }
    public static ArrayList<Category> getCategorysInData() {

		return CategoryDAO.findAll();
    }
}
