package com.newvery.task.favorite;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.utils.TimeUtil;

public class FavoriteInsertTask extends FavoriteTask {

	private int year;
	
	@Override
	public Object exec() throws ServiceException {
		
		if(year > 0) {
			getFavorite().setCreateTime(TimeUtil.parse(year + "-01-01", TimeUtil.FORMAT_DATE_ONLY));
		} else {
			getFavorite().setCreateTime(new Date());
		}
		getFavorite().setDeleted(false);
		
		return getFavoriteDao().insertFavoriteRecord(getFavorite());
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

}
