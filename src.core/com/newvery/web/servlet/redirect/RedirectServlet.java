package com.newvery.web.servlet.redirect;

import com.newvery.web.servlet.BaseServlet;
import com.newvery.web.servlet.IBaseServlet;

public abstract class RedirectServlet extends BaseServlet implements IRedirectServlet{
	
	public int getServletType() {
		return IBaseServlet.SERVLET_TYPE_REDIRECT;
	}
}
