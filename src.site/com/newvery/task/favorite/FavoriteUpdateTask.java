package com.newvery.task.favorite;

import java.util.Date;

import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteRecord;

public class FavoriteUpdateTask extends FavoriteTask {

	@Override
	public Object exec() throws ServiceException {
		FavoriteRecord f = getFavoriteDao().findFavoriteRecordByName(getFavorite().getName());
		if (f != null && !f.getName().equals(getFavorite().getName())) {
			throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "该收藏夹名已存在！");
		}
		
		f = getFavoriteDao().findFavoriteRecordByPK(getFavorite().getId());
		f.setName(getFavorite().getName());
		f.setAlias(getFavorite().getAlias());
		f.setModifyTime(new Date());
		
		if (getFavorite().getImg() != null && !"".equals(getFavorite().getImg())) {
			f.setImg(getFavorite().getImg());
		}
		
		getFavoriteDao().updateFavoriteRecord(f);
		
		return f;
	}

}
