package model.entities;

public class Client {
	private int id;
	private String user;
	private String password;
	private String money;
	private String fullName;
	private String birthday;
	private String address;
	private String phone;
	private String image;
	private String role;

	public Client(int id, String user, String password, String money, String fullName, String birthday, String address,
			String phone,String image,String role) {
		this.id = id;
		this.user = user;
		this.password = password;
		this.money = money;
		this.fullName = fullName;
		this.birthday = birthday;
		this.address = address;
		this.phone = phone;
		this.image = image;
		this.role = role;
	}
	public Client() {
		// TODO Auto-generated constructor stub
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getFullName() {
		return fullName;
	}
	public void setFullName(String fullName) {
		this.fullName = fullName;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	@Override
	public String toString() {
		return "Client [id=" + id + ", user=" + user + ", password=" + password + ", money=" + money + ", fullName="
				+ fullName + ", birthday=" + birthday + ", address=" + address + ", phone=" + phone + "]";
	}

	
}
