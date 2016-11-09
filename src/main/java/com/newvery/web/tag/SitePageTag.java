package com.newvery.web.tag;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.components.Component;
import org.apache.struts2.views.jsp.ComponentTagSupport;

import com.opensymphony.xwork2.util.ValueStack;

public class SitePageTag extends ComponentTagSupport  {

	private String page;
	private String params;
	private String pageTableId;
	
	private static final long serialVersionUID = 1L;

	@Override
	public Component getBean(ValueStack arg0, HttpServletRequest request,HttpServletResponse response) {
		return new SitePages(arg0,request);
	}


	public String getPageTableId() {
		return pageTableId;
	}

	public void setPageTableId(String pageTableId) {
		this.pageTableId = pageTableId;
	}


	@Override
	protected void populateParams() {    
        super.populateParams();    
            
        SitePages pages = (SitePages)component;    
        pages.setPage(page);
        pages.setPageTableId(pageTableId);
        pages.setParams(params);
    }


	public String getPage() {
		return page;
	}


	public void setPage(String page) {
		this.page = page;
	}


	public String getParams() {
		return params;
	}


	public void setParams(String params) {
		this.params = params;
	}   
	
}
