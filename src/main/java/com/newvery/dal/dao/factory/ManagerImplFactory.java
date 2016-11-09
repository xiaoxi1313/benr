package com.newvery.dal.dao.factory;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.newvery.ErrorCode;
import com.newvery.dal.dao.BaseDao;
import com.newvery.exception.ServiceException;
import org.mybatis.spring.SqlSessionTemplate;

public class ManagerImplFactory {
	private Map<String, BaseDao> instanceMap = new ConcurrentHashMap<String, BaseDao>();

	public BaseDao getInstance(Class<? extends BaseDao> cl, SqlSessionTemplate sqlSessionTemplate) throws ServiceException {
		BaseDao managerImpl  = instanceMap.get(cl.getSimpleName());
		
		if (managerImpl == null) {
			try {
				managerImpl = cl.newInstance();
				managerImpl.setSqlTemplate(sqlSessionTemplate);
				instanceMap.put(cl.getSimpleName(), managerImpl);
			} catch (InstantiationException e) {
				e.printStackTrace();
				throw new ServiceException(ErrorCode.ILLEGAL_REQUEST, "构造" + cl.getSimpleName() + "对象实例失败:" + e.getMessage(), e);
			} catch (IllegalAccessException e) {
				e.printStackTrace();
				throw new ServiceException(ErrorCode.ILLEGAL_REQUEST, "构造" + cl.getSimpleName() + "对象实例失败:" + e.getMessage(), e);
			}
		}
		return managerImpl;
	}
}
