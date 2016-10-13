package com.newvery.task.um;

import java.util.Date;

import com.newvery.Constants;
import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserLogRecord;
import com.newvery.record.UserRecord;

public class LoginTask extends UserTask {
	
	private String userName;
	private String password;
	private String browser;

	@Override
	public Object exec() throws ServiceException {
		userName = userName.trim();
		UserRecord user = getUserDao().findUserByUserName(userName);
		
		if(user == null ) {
			throw new ServiceException(ErrorCode.USER_LOGIN_ERROR, "密码错误或者用户名不存在" );
		}
		
		//if(!user.getPassword().equals(DigestUtil.md5(getPassword()))) {
		if(!user.getPassword().equals(getPassword())) {
			throw new ServiceException(ErrorCode.USER_LOGIN_ERROR, "密码错误或者用户名不存在");
		}
		
		if(user.isLocked()) {
			throw new ServiceException(ErrorCode.USER_IS_LOCKED, "用户已被锁定");
		}
		if(user.isDeleted()){
			throw new ServiceException(ErrorCode.USER_IS_DISABLED,"用户已被禁用");
		}
		
		// 普通用户验证VIP剩余时间
		if (user.getRole().getId() == Constants.ROLE_GAOJIYONGHU || user.getRole().getId() == Constants.ROLE_PUTONGYONGHU) {
			
			if(user.getUserGroup() == null ) {
				throw new ServiceException(ErrorCode.USER_IS_DISABLED,"未分组用户！");
			}
			
			if (user.getUserGroup().getVipRemains() <= 0) {
				//throw new ServiceException(ErrorCode.USER_IS_DISABLED,"VIP有效期已过，请联系管理员！");
			}
		}
		
		getUserDao().updateLoginDate(user);
		
		UserLogRecord log = new UserLogRecord();
		log.setUser(user);
		log.setCreatedate(new Date());
		log.setType(Constants.USER_OPERATION_LOGIN);
		log.setIp(getOperatorIP());
		log.setBrowser(getBrowser());
		
		getUserDao().insertUserLog(log);
		
		return user;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getBrowser() {
		return browser;
	}

	public void setBrowser(String browser) {
		this.browser = browser;
	}
}
