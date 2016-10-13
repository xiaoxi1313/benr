package com.newvery.task.favorite;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.UserShareFavoriteRecord;

public class ShareUserFavoriteTask extends FavoriteTask {

	private long parentFavoriteId;
	private long childFavoriteId;
	
	private long[] userId;
	
	private long shareUserId;				//分享人
	
	@Override
	public Object exec() throws ServiceException {
		
		List<Long> children = new ArrayList<Long>();
		
		if(childFavoriteId > 0) {//选中了具体某个子收藏夹
			children.add(childFavoriteId);
		} else {
			List<FavoriteRecord> clist = getFavoriteDao().findChildrenByParentId(parentFavoriteId);
			for (FavoriteRecord favoriteRecord : clist) {
				children.add(favoriteRecord.getId());
			}
		}
		
		for (Long cid : children) {
			UserShareFavoriteRecord userShare = new UserShareFavoriteRecord();
			userShare.setChildFavoriteId(cid);
			userShare.setParentFavoriteId(parentFavoriteId);
			userShare.setShareUserId(shareUserId);
			
			
			for (Long uid : userId) {
				userShare.setUserId(uid);
				
				//检查是否存在
				if(getFavoriteDao().checkUserShareFavorite(userShare) == false) {
					getFavoriteDao().insertUserShareFavorite(userShare);
				}
			}
		}
		
		
		
		return null;
	}

	public long getParentFavoriteId() {
		return parentFavoriteId;
	}

	public void setParentFavoriteId(long parentFavoriteId) {
		this.parentFavoriteId = parentFavoriteId;
	}

	public long getChildFavoriteId() {
		return childFavoriteId;
	}

	public void setChildFavoriteId(long childFavoriteId) {
		this.childFavoriteId = childFavoriteId;
	}

	public long[] getUserId() {
		return userId;
	}

	public void setUserId(long[] userId) {
		this.userId = userId;
	}

	public long getShareUserId() {
		return shareUserId;
	}

	public void setShareUserId(long shareUserId) {
		this.shareUserId = shareUserId;
	}

}
