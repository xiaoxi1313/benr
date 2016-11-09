package com.newvery.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

public class HttpUtil {

	
	public static String getCookieValue(Cookie[] cookies,String key) {
		String v = null;
		if(cookies != null) {
			for (Cookie cookie : cookies) {
				if(key.equals(cookie.getName())) {
					v = cookie.getValue();
				}
			}
		}
		return v;
	}
	
	
	public static void addCookie(HttpServletResponse response,String name,String value,int maxAge){
		System.out.println("写入cookie " + name + " = " + value);
	    Cookie cookie = new Cookie(name,value);
	    cookie.setPath("/");
	    //cookie.setDomain(".tao-a.cn");
	    if(maxAge>0)  cookie.setMaxAge(maxAge);
	    response.addCookie(cookie);
	}
}
