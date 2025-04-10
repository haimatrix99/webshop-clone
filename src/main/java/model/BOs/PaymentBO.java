package model.BOs;

import java.util.ArrayList;

import model.DAOs.PaymentDAO;
import model.entities.Payment;


public class PaymentBO {
	public static ArrayList<Payment> getPayments() {

		return PaymentDAO.findAll();

	}

	public static void addPaymentToData(Payment pay) {
		PaymentDAO.insert(pay.getCardholderName(), pay.getNameAccount(), pay.getStatus() + "", pay.getClientID(),
				pay.getMoney());
	}

	public static void updateStatusPayment(int paymentID, String status) {
		PaymentDAO.updateStatusByPaymentId(paymentID, status);
	}

	public static void deletePayment(int paymentID) {
		PaymentDAO.deleteByPaymentId(paymentID);
	}

	public static void updatePaymentsMoney() {
		PaymentDAO.updatePaymentsMoney();
	}
}
