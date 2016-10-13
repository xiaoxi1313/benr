package com.newvery.task.favorite;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteGroupRecord;

public class FavoriteGroupUpdateTask extends FavoriteTask {
	private FavoriteGroupRecord favoriteGroup;

	@Override
	public Object exec() throws ServiceException {
		FavoriteGroupRecord f = getFavoriteDao().findFavoriteGroupById(favoriteGroup.getId());
		f.setName(favoriteGroup.getName());
		f.setModifyTime(new Date());
		
		f = getFavoriteDao().updateFavoriteGroupRecord(f);
		return f;
	}

	public FavoriteGroupRecord getFavoriteGroup() {
		return favoriteGroup;
	}

	public void setFavoriteGroup(FavoriteGroupRecord favoriteGroup) {
		this.favoriteGroup = favoriteGroup;
	}
}
