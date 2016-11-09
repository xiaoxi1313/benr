package com.newvery.web.response;

import com.google.gson.annotations.Expose;
import com.newvery.web.servlet.BaseResponse;

public class NextArticleIdResponse extends BaseResponse {
	
	@Expose
	private long aid;

	public long getAid() {
		return aid;
	}

	public void setAid(long aid) {
		this.aid = aid;
	}
	
}
