package model.entities;
public class Location {
    private String city;
    private String region;
    private String country;
    private String longitude;
    private String latitude;

    
    public Location() {
    }

    public String getLatitude() {
		return latitude;
	}
    public String getLongitude() {
		return longitude;
	}
    public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
    public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
