package com.newvery.web.filter;

import org.apache.struts2.ServletActionContext;

import com.newvery.Constants;
import com.newvery.record.UserRecord;
import com.newvery.web.action.BaseWebAction;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginIntercepter extends AbstractInterceptor {
	private static final long serialVersionUID = 4415009437492527203L;

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {

		if(invocation.getAction() instanceof BaseWebAction ) {
			UserRecord user = (UserRecord)ServletActionContext.getRequest().getSession().getAttribute(Constants.LOGIN_MEMBER_SESSION_NAME);
			if(user == null) {
				
				return "login";
			}
		} 

		return invocation.invoke();
	}



}