package com.pojo;

public class Offices {
    private int officeId;
    private String address;
    private String city;
    private String state;

    public int getOfficeId() {
        return officeId;
    }

    public void setOfficeId(int officeId) {
        this.officeId = officeId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Offices offices = (Offices) o;

        if (officeId != offices.officeId) return false;
        if (address != null ? !address.equals(offices.address) : offices.address != null) return false;
        if (city != null ? !city.equals(offices.city) : offices.city != null) return false;
        if (state != null ? !state.equals(offices.state) : offices.state != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = officeId;
        result = 31 * result + (address != null ? address.hashCode() : 0);
        result = 31 * result + (city != null ? city.hashCode() : 0);
        result = 31 * result + (state != null ? state.hashCode() : 0);
        return result;
    }
}
