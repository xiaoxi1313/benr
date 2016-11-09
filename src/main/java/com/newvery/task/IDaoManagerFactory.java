package com.newvery.task;

import com.newvery.dal.dao.BaseDao;

public interface IDaoManagerFactory {
	public BaseDao getManagerImpl(Class<? extends BaseDao> cl);
}
