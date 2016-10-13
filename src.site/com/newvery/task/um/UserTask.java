package com.newvery.task.um;

import com.newvery.dal.dao.permission.IPermissionDao;
import com.newvery.dal.dao.permission.impl.PermissionDaoImpl;
import com.newvery.dal.dao.user.IUserDao;
import com.newvery.dal.dao.user.impl.UserDaoImpl;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class UserTask implements SecurityTask {

	private String operatorIP;
	private IDaoManagerFactory daoManagerFactory;

	public String getOperatorIP() {
		return operatorIP;
	}

	public void setOperatorIP(String operatorIP) {
		this.operatorIP = operatorIP;
	}

	public IDaoManagerFactory getDaoManagerFactory() {
		return daoManagerFactory;
	}

	public void setDaoManagerFactory(IDaoManagerFactory daoManagerFactory) {
		this.daoManagerFactory = daoManagerFactory;
	}

	public IUserDao getUserDao() {
		return (IUserDao)getDaoManagerFactory().getManagerImpl(UserDaoImpl.class);
	}
	
	public IPermissionDao getPermissionDao() {
		return (IPermissionDao)getDaoManagerFactory().getManagerImpl(PermissionDaoImpl.class);
	}
}
