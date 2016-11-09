package com.newvery.web.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public abstract class BaseServlet implements IBaseServlet,SessionInterceptor {
	private Object data;
	private HttpSession session;
	private HttpServletRequest httpRequest;
	private HttpServletResponse httpResponse;
	
	
	public void setData(Object data) {
		this.data = data;
	}
	
	public Object getRequest() {
		return this.data;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	public boolean isInjectSession() {
		return true;
	}
	
	public boolean isInjectRequest() {
		return false;
	}

	public HttpServletRequest getHttpRequest() {
		return httpRequest;
	}

	public void setHttpRequest(HttpServletRequest httpRequest) {
		this.httpRequest = httpRequest;
	}

	public boolean isInjectReponse() {
		return false;
	}
	
	public HttpServletResponse getHttpResponse() {
		return httpResponse;
	}

	public void setHttpResponse(HttpServletResponse httpResponse) {
		this.httpResponse = httpResponse;
	}
	
}
