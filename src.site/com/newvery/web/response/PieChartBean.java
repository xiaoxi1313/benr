package com.newvery.web.response;

import com.google.gson.annotations.Expose;

public class PieChartBean {
	
	@Expose
	private String name;
	
	@Expose
	private double y;

	
	public PieChartBean(String name,double y) {
		this.name = name;
		this.y = y;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

	
}
