package com.newvery.web.servlet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public interface IBaseServlet {

	int SERVLET_TYPE_JSON = 1;
	int SERVLET_TYPE_DISPATCH = 2;
	int SERVLET_TYPE_REDIRECT = 3;
	
	
	String ERROR_PAGE = "error.jsp";
	String NOT_LOGIN = "login_expire.jsp";
	
	public void setData(Object data);
	

	public Class<?> getRequestClass();
	
	/**
	 * Servlet 的类型
	 * 类型有： 1， json servlet, 2, dispatch servlet, 3, redirect servlet. 
	 * @return
	 */
	public int getServletType();
	
	
	/**
	 * 是否注入HttpSession
	 * @return
	 */
	public boolean isInjectSession();
	
	HttpSession getSession();
	
	void setSession(HttpSession session);
	
	
	/**
	 * 是否注入原生的HttpServletRequest
	 */
	public boolean isInjectRequest();
	HttpServletRequest getHttpRequest();
	void setHttpRequest(HttpServletRequest request);
	
	
	public boolean isInjectReponse();
	HttpServletResponse getHttpResponse();
	void setHttpResponse(HttpServletResponse reponse);
}
