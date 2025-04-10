package model.BOs;

import java.util.ArrayList;

import model.DAOs.ClientDAO;
import model.entities.Client;

public class ClientBO {
    public static int addClientToData(Client client) {
    	return ClientDAO.insert(client.getUser(), client.getPassword(), client.getMoney(), client.getFullName(), client.getBirthday()
    			, client.getAddress(), client.getPhone());
    }
    public static ArrayList<Client> getClients() {
    	
		return ClientDAO.findAll();
    }
    public static Client getClientById(int clientID) {
		return ClientDAO.findByClientId(clientID);
    }
    public static Client getAccesser(String user, String pass) {

		return ClientDAO.findByUserAndPass(user, pass);
    }
    public static void updateAccountInData(Client client) {
    	ClientDAO.updateByClientId( client.getUser(), client.getPassword(), client.getFullName(), client.getBirthday(),
					client.getAddress(), client.getPhone(), client.getImage(), client.getId());
    }


}
