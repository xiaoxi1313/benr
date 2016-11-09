package com.newvery.task;

import com.newvery.exception.ServiceException;

public interface ISecurityExecutor {
	Object exec(SecurityTask task) throws ServiceException;
}