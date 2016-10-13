package com.newvery.web.servlet.dispatch;

import com.newvery.web.servlet.BaseServlet;
import com.newvery.web.servlet.IBaseServlet;

public abstract class DispatchServlet extends BaseServlet implements IDispatchServlet{
	
	public int getServletType() {
		return IBaseServlet.SERVLET_TYPE_DISPATCH;
	}
	
}
