package model.BOs;

import java.util.ArrayList;

import model.DAOs.CommentDAO;
import model.entities.Comment;

public class CommentBO {
	public static ArrayList<Comment> getCommentsByProductID(int productID) {

		return CommentDAO.findByProductID(productID);

	}

	public static void addCommentToData(Comment comment) {
		CommentDAO.insert(comment.getComment(), comment.getClientID(), comment.getProductID());
	}
}
