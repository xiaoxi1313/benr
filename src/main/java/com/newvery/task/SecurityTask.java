package com.newvery.task;

import com.newvery.exception.ServiceException;

public interface SecurityTask {
	public Object exec() throws ServiceException;

	public String getOperatorIP();

	public void setDaoManagerFactory(IDaoManagerFactory factory);
	public IDaoManagerFactory getDaoManagerFactory();
}
