package model.entities;

public class Comment {
	private int commentID;
	private String comment;
	private String datetime;
	private int clientID;
	private int productID;
	public Comment(int commentID, String comment, String datetime, int clientID,int productID) {
		this.commentID = commentID;
		this.comment = comment;
		this.datetime = datetime;
		this.clientID = clientID;
		this.productID=productID;
	}
	public Comment(String comment, int clientID,int productID) {
		this.comment = comment;
		this.clientID = clientID;
		this.productID=productID;
	}
	public int getCommentID() {
		return commentID;
	}
	public void setCommentID(int commentID) {
		this.commentID = commentID;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getDatetime() {
		return datetime;
	}
	public void setDatetime(String datetime) {
		this.datetime = datetime;
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
