package com.newvery.record;

import com.google.gson.annotations.Expose;

public class ChartRecord {
	@Expose
	private int sum;
	@Expose
	private long date;
	
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
	public long getDate() {
		return date;
	}
	public void setDate(long date) {
		this.date = date;
	}
}
