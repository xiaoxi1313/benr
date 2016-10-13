package com.newvery.web.servlet.json;

import com.newvery.web.servlet.BaseResponse;

public abstract class JSONSessionServlet extends JSONServlet {

	private int userId;
	private String uuid;
	private String userName;
	
	public BaseResponse execute() {
		if(getSession().getAttribute("uid") == null) {
			BaseResponse result = new BaseResponse();
			result.setErrorCode(-100);
			result.setErrorMessage("用户未登录");
			return result;
		}
		uuid = (String)getSession().getAttribute("uuid") ;
		String strUid = getSession().getAttribute("uid").toString();
		
		userId = Integer.valueOf(strUid);
		userName = (String)getSession().getAttribute("uname");
		return exec();
	}
	
	public abstract BaseResponse exec();
	
	public boolean isInjectSession() {
		return true;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
}
