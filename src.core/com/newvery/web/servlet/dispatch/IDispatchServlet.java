package com.newvery.web.servlet.dispatch;

import com.newvery.web.servlet.BaseResponse;
import com.newvery.web.servlet.IBaseServlet;

public interface IDispatchServlet extends IBaseServlet{

	/**
	 * 
	 * @return 返回dispatch url路径
	 */
	public String execute();
	
	
	/**
	 * 传递给下一个ＵＲＩ的值
	 * @return
	 */
	public BaseResponse getResult();
	
	
	
}
