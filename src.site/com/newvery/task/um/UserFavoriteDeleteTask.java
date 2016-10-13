package com.newvery.task.um;

import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserFavoriteRecord;

public class UserFavoriteDeleteTask extends UserTask {
	private UserFavoriteRecord userFavorite;

	@Override
	public Object exec() throws ServiceException {
		UserFavoriteRecord uf = getFavoriteDao().findUserFavoriteByUserIdAndChildFavoriteId(userFavorite.getUserId(), userFavorite.getChildFavoriteId());
		if (uf != null) {
			getFavoriteDao().deleteUserFavorite(uf.getId());
		}
		return null;
	}

	public IFavoriteDao getFavoriteDao() {
		return (IFavoriteDao) getDaoManagerFactory().getManagerImpl(FavoriteDaoImpl.class);
	}
	
	public UserFavoriteRecord getUserFavorite() {
		return userFavorite;
	}

	public void setUserFavorite(UserFavoriteRecord userFavorite) {
		this.userFavorite = userFavorite;
	}
}
