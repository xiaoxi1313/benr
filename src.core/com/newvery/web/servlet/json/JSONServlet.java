package com.newvery.web.servlet.json;

import com.newvery.web.servlet.BaseServlet;
import com.newvery.web.servlet.IBaseServlet;

public abstract class JSONServlet extends BaseServlet implements IJSONServlet{

	public int getServletType() {
		return IBaseServlet.SERVLET_TYPE_JSON;
	}

}
