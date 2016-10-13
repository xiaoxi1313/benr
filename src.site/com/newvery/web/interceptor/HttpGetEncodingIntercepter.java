package com.newvery.web.interceptor;

import java.io.UnsupportedEncodingException;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class HttpGetEncodingIntercepter extends AbstractInterceptor {

	private static final long serialVersionUID = 1L;

	/**
	 * Struts2编码拦截器
	 */

	@Override
	public String intercept(ActionInvocation arg0) throws Exception {

		ActionContext actionContext = arg0.getInvocationContext();
		HttpServletRequest request = (HttpServletRequest) actionContext
				.get(StrutsStatics.HTTP_REQUEST);
		/**
		 * 此方法体对GET
		 */
		if (request.getMethod().equalsIgnoreCase("get")) {
			Iterator iter = request.getParameterMap().values().iterator();
			while (iter.hasNext()) {
				String[] parames = (String[]) iter.next();
				for (int i = 0; i < parames.length; i++) {
					try {
						parames[i] = new String(parames[i].getBytes("iso-8859-1"), "UTF-8");// 此处GBK与页面编码一样
					} catch (UnsupportedEncodingException e) {
						//e.printStackTrace();
					}
				}
			}
		}
		return arg0.invoke();
	}

}
