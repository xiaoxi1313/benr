package com.newvery.task.favorite;

import com.newvery.exception.ServiceException;

public class FavoriteDeleteTask extends FavoriteTask {

	@Override
	public Object exec() throws ServiceException {
		getFavoriteDao().deleteFavoriteRecord(getFavorite().getId());
		return null;
	}

}
