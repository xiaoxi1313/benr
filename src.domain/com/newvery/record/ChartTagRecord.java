package com.newvery.record;

import com.google.gson.annotations.Expose;

public class ChartTagRecord {
	@Expose
	private int sum;
	@Expose
	private String name;
	
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
}
