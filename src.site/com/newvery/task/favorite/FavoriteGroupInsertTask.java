package com.newvery.task.favorite;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteGroupRecord;

public class FavoriteGroupInsertTask extends FavoriteTask {
	private FavoriteGroupRecord favoriteGroup;
	
	@Override
	public Object exec() throws ServiceException {
		favoriteGroup.setDeleted(false);
		favoriteGroup.setCreateTime(new Date());
		
		getFavoriteDao().insertFavoriteGroupRecord(favoriteGroup);
		return favoriteGroup;
	}
	public FavoriteGroupRecord getFavoriteGroup() {
		return favoriteGroup;
	}
	public void setFavoriteGroup(FavoriteGroupRecord favoriteGroup) {
		this.favoriteGroup = favoriteGroup;
	}
}
