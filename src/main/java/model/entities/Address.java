package model.entities;

public class Address {
	private String road;
	private String quarter;
	private String suburb;
	private String city;

	public Address() {
		// TODO Auto-generated constructor stub
	}

	public String getCity() {
		return city;
	}

	public String getQuarter() {
		return quarter;
	}

	public String getRoad() {
		return road;
	}

	public String getSuburb() {
		return suburb;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public void setQuarter(String quarter) {
		this.quarter = quarter;
	}

	public void setRoad(String road) {
		this.road = road;
	}

	public void setSuburb(String suburb) {
		this.suburb = suburb;
	}
}
