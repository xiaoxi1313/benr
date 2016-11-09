package com.newvery.web.servlet.json;

import com.newvery.web.servlet.BaseResponse;
import com.newvery.web.servlet.IBaseServlet;

public interface IJSONServlet extends IBaseServlet {
	public BaseResponse execute();
}
