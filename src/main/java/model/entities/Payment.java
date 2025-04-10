package model.entities;

public class Payment {
	private int paymentID;
	private String cardholderName;
	private String nameAccount;
	private int status;
	private int clientID;
	private String money;
	public Payment(int paymentID, String cardholderName, String nameAccount, int status, int clientID,String money) {
		this.paymentID = paymentID;
		this.cardholderName = cardholderName;
		this.nameAccount = nameAccount;
		this.status = status;
		this.clientID = clientID;
		this.money=money;
	}
	public int getPaymentID() {
		return paymentID;
	}
	public void setPaymentID(int paymentID) {
		this.paymentID = paymentID;
	}
	public String getCardholderName() {
		return cardholderName;
	}
	public void setCardholderName(String cardholderName) {
		this.cardholderName = cardholderName;
	}
	public String getNameAccount() {
		return nameAccount;
	}
	public void setNameAccount(String nameAccount) {
		this.nameAccount = nameAccount;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public int getClientID() {
		return clientID;
	}
	public void setClientID(int clientID) {
		this.clientID = clientID;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	
}
