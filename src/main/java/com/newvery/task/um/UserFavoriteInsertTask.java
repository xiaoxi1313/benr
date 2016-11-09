package com.newvery.task.um;

import java.util.Date;

import com.newvery.ErrorCode;
import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserFavoriteRecord;

public class UserFavoriteInsertTask extends UserTask {
	private UserFavoriteRecord userFavorite;

	@Override
	public Object exec() throws ServiceException {
		UserFavoriteRecord uf = getFavoriteDao().findUserFavoriteByUserIdAndChildFavoriteId(userFavorite.getUserId(), userFavorite.getChildFavoriteId());
		if (uf != null) {
			throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "该收藏夹已分配！");
		}
		
		userFavorite.setDeleted(false);
		userFavorite.setCreateTime(new Date());
		userFavorite = getFavoriteDao().insertUserFavorite(userFavorite);
		return userFavorite;
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
