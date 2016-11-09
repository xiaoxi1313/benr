package com.newvery.ueditor;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

public class MyStrutsFilter extends StrutsPrepareAndExecuteFilter {  
    @Override  
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException,  
            ServletException {  
        HttpServletRequest request = (HttpServletRequest) req;  
        //不过滤上传图片的URL  
        String url = request.getRequestURI();  
        if ("/ueditor/jsp/imageUp.jsp".equals(url)) {  
            chain.doFilter(req, res);  
        } else {  
            super.doFilter(req, res, chain);  
        }  
    }  
}  
