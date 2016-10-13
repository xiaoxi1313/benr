package com.newvery.task.um;

import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserRecord;

public class UserDeleteTask extends UserTask {
	private UserRecord user;

	@Override
	public Object exec() throws ServiceException {
		getUserDao().deleteUser(user.getId());
		
		getFavoriteDao().deleteUserFavorite(user.getId());
		return null;
	}

	public UserRecord getUser() {
		return user;
	}

	public void setUser(UserRecord user) {
		this.user = user;
	}

	
	public IFavoriteDao getFavoriteDao() {
		return (IFavoriteDao)getDaoManagerFactory().getManagerImpl(FavoriteDaoImpl.class);
	}
}
