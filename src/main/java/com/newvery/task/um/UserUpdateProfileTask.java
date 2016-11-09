package com.newvery.task.um;

import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserRecord;
import com.newvery.utils.StringUtil;

public class UserUpdateProfileTask extends UserTask {
	
	private long userId;
	private String password;
	private String email;
	private String icon;
	private String newPassword;
	

	@Override
	public Object exec() throws ServiceException {
		UserRecord user = getUserDao().findUserById(userId);
		
		if(user == null ) {
			throw new ServiceException(ErrorCode.USER_LOGIN_ERROR, "非法请求" );
		}
		
		if(StringUtil.isNull(password) != null) {
			if(!user.getPassword().equals(password)) {
				throw new ServiceException(ErrorCode.USER_LOGIN_ERROR, "原始密码错误");
			}
			
			if(StringUtil.isNull(newPassword) != null) {
				user.setPassword(newPassword);
			}
		}
		
		
		user.setEmail(email);
		if(icon != null) {
			user.setIcon(icon);
		}
		
		getUserDao().updateUser(user);
		
		return user;
	}


	public long getUserId() {
		return userId;
	}


	public void setUserId(long userId) {
		this.userId = userId;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getIcon() {
		return icon;
	}


	public void setIcon(String icon) {
		this.icon = icon;
	}


	public String getNewPassword() {
		return newPassword;
	}


	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

}
