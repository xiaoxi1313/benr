package com.newvery.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.google.gson.Gson;
import com.newvery.web.servlet.BaseResponse;
import com.newvery.web.servlet.IBaseServlet;
import com.newvery.web.servlet.ServletContextMap;
import com.newvery.web.servlet.dispatch.IDispatchServlet;
import com.newvery.web.servlet.json.IJSONServlet;
import com.newvery.web.servlet.redirect.IRedirectServlet;



public class BaseFilter implements Filter{
	private static Log log = LogFactory.getLog(BaseFilter.class);
	
	public static final String encoding = "UTF-8";
	public static final String[] extensions = new String[]{"json","ajax","action"};

	public void doFilter(ServletRequest req, ServletResponse response,
			FilterChain filter) throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
		
		request.setCharacterEncoding(encoding);
		
		String url = getServletPath(request);
		String urlName = dropExtension(url);
		log.debug("url = " + url + " urlname = " + urlName);
		if(urlName != null) {//处理的类型
			Class cls = ServletContextMap.get(urlName);
			if(cls != null) {
				log.debug("请求" + urlName + "请求类" + cls.getName());
				try {
					IBaseServlet servlet = (IBaseServlet)cls.newInstance();
					
					//注入session
					if(servlet.isInjectSession()) {
						servlet.setSession(request.getSession());
					}
					
					//注入response
					if(servlet.isInjectReponse()) {
						servlet.setHttpResponse((HttpServletResponse)response);
					}
					
					
					//注入request,如果取原生的httprequest则不进行Bean封装
					if(servlet.isInjectRequest()) {
						servlet.setHttpRequest(request);
					} 
					if(servlet.getRequestClass() != null) {
						Object requestData = servlet.getRequestClass().newInstance();
						//将传过来的值转化为对应的请求对象
						BeanUtils.populate(requestData, request.getParameterMap());
						servlet.setData(requestData);
					}
					
					switch(servlet.getServletType()) {
						case IBaseServlet.SERVLET_TYPE_JSON:
							response.reset();
							
							//还需要对对象属性循环进行处理。
							//套用GSON来实现
							BaseResponse result = ((IJSONServlet)servlet).execute();
							//JSONObject jsonObj = new JSONObject();
							//String resultInfo = jsonObj.
							Gson gson = new Gson();
							String resultInfo = gson.toJson(result);
							
							response.setContentType("application/json;charset=utf-8");
							response.getWriter().print(resultInfo);
							response.getWriter().close();
							return;
						case IBaseServlet.SERVLET_TYPE_DISPATCH:
							IDispatchServlet dispatchServlet = (IDispatchServlet) servlet;
							String dispatchUrl = dispatchServlet.execute();
							request.setAttribute("result", dispatchServlet.getResult());
							request.getRequestDispatcher(dispatchUrl).forward(request, response);
							return;
						case IBaseServlet.SERVLET_TYPE_REDIRECT:
							String redirectUrl = ((IRedirectServlet)servlet).execute();
							((HttpServletResponse)response).sendRedirect(redirectUrl);
							return;
					}
				} catch (InstantiationException e) {
					e.printStackTrace();
				} catch (IllegalAccessException e) {
					e.printStackTrace();
				} catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
		
		filter.doFilter(request, response);
	}

	String dropExtension(String name) {
        if (extensions == null) {
            return name;
        }
        for (String ext : extensions) {
            if ("".equals(ext)) {
                // This should also handle cases such as /foo/bar-1.0/description. It is tricky to
                // distinquish /foo/bar-1.0 but perhaps adding a numeric check in the future could
                // work
                int index = name.lastIndexOf('.');
                if (index == -1 || name.indexOf('/', index) >= 0) {
                    return name;
                }
            } else {
                String extension = "." + ext;
                if (name.endsWith(extension)) {
                    name = name.substring(0, name.length() - extension.length());
                    return name;
                }
            }
        }
        return null;
    }
	
	public static String getServletPath(HttpServletRequest request) {
        String servletPath = request.getServletPath();
        
        String requestUri = request.getRequestURI();
        // Detecting other characters that the servlet container cut off (like anything after ';')
        if (requestUri != null && servletPath != null && !requestUri.endsWith(servletPath)) {
            int pos = requestUri.indexOf(servletPath);
            if (pos > -1) {
                servletPath = requestUri.substring(requestUri.indexOf(servletPath));
            }
        }
        
        if (null != servletPath && !"".equals(servletPath)) {
            return servletPath;
        }
        
        int startIndex = request.getContextPath().equals("") ? 0 : request.getContextPath().length();
        int endIndex = request.getPathInfo() == null ? requestUri.length() : requestUri.lastIndexOf(request.getPathInfo());

        if (startIndex > endIndex) { // this should not happen
            endIndex = startIndex;
        }

        return requestUri.substring(startIndex, endIndex);
    }
	
	public void init(FilterConfig arg0) throws ServletException {
	}

	public void destroy() {
	}
	
}
