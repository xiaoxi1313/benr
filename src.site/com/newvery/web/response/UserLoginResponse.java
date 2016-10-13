package com.newvery.web.response;

import com.google.gson.annotations.Expose;
import com.newvery.web.servlet.BaseResponse;

public class UserLoginResponse extends BaseResponse {

	@Expose
	private String refererUrl;

	public String getRefererUrl() {
		return refererUrl;
	}

	public void setRefererUrl(String refererUrl) {
		this.refererUrl = refererUrl;
	}
	
}
