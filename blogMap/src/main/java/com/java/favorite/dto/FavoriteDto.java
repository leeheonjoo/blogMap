package com.java.favorite.dto;

import java.util.Date;

public class FavoriteDto {
	private int favorite_no;
	private Date favorite_rgdate;
	
	public int getFavorite_no() {
		return favorite_no;
	}
	public void setFavorite_no(int favorite_no) {
		this.favorite_no = favorite_no;
	}
	public Date getFavorite_rgdate() {
		return favorite_rgdate;
	}
	public void setFavorite_rgdate(Date favorite_rgdate) {
		this.favorite_rgdate = favorite_rgdate;
	}
	
	
}
