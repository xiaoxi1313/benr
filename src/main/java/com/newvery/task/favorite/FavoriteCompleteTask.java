package com.newvery.task.favorite;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteRecord;

/**
 * 文件夹 完成/未完成
 * @author user
 *
 */
public class FavoriteCompleteTask extends FavoriteTask {
	private boolean completed;
	
	@Override
	public Object exec() throws ServiceException {
		FavoriteRecord f = getFavoriteDao().findFavoriteRecordByPK(getFavorite().getId());
		if (f != null) {
			f.setCompleted(completed);
			f.setModifyTime(new Date());
			
			getFavoriteDao().updateFavoriteRecord(f);
		}
		return f;
	}

	public boolean isCompleted() {
		return completed;
	}

	public void setCompleted(boolean completed) {
		this.completed = completed;
	}
}
