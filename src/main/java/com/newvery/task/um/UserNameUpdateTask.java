package com.newvery.task.um;

import com.newvery.exception.ServiceException;

public class UserNameUpdateTask extends UserTask{

	private long userId;
	private String userName;
	
	@Override
	public Object exec() throws ServiceException {
		
		getUserDao().updateUserName(userId, userName);
		
		return null;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}



	
}
