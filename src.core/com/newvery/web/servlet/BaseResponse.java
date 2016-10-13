package com.newvery.web.servlet;

import com.google.gson.annotations.Expose;

public class BaseResponse {
	
	@Expose
	private int errorCode;
	
	@Expose
	private String errorMessage;

	public int getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}
}
