package com.newvery.task.um;

import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;

public class UserGroupDeleteTask extends UserTask{

	private long userGroupId;
	
	@Override
	public Object exec() throws ServiceException {
		getUserDao().deleteUserGroup(userGroupId);
		getFavoriteDao().deleteFavoriteByUserGroupId(userGroupId);
		return null;
	}
	
	public IFavoriteDao getFavoriteDao() {
		return (IFavoriteDao) getDaoManagerFactory().getManagerImpl(FavoriteDaoImpl.class);
	}

	public long getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(long userGroupId) {
		this.userGroupId = userGroupId;
	}

}
