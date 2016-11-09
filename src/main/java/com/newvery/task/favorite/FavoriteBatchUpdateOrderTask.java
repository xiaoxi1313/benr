package com.newvery.task.favorite;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteRecord;

/**
 * 批量排序
 * @author mi_xb
 *
 */
public class FavoriteBatchUpdateOrderTask extends FavoriteTask {
	private String[] orderFavoriteId;
	
	@Override
	public Object exec() throws ServiceException {
		if (orderFavoriteId != null && orderFavoriteId.length > 0) {
			for (int i=0; i<orderFavoriteId.length; i++) {
				long id = Long.parseLong(orderFavoriteId[i]);
				FavoriteRecord favorite = getFavoriteDao().findFavoriteRecordByPK(id);
				favorite.setPosition(i + 1);
				favorite.setModifyTime(new Date());
				
				getFavoriteDao().updateFavoriteRecord(favorite);
			}
		}
		return null;
	}

	public String[] getOrderFavoriteId() {
		return orderFavoriteId;
	}

	public void setOrderFavoriteId(String[] orderFavoriteId) {
		this.orderFavoriteId = orderFavoriteId;
	}
}
