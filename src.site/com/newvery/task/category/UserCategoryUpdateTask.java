package com.newvery.task.category;

import com.newvery.exception.ServiceException;
import com.newvery.record.CategoryRecord;
import com.newvery.record.UserCategoryRecord;

public class UserCategoryUpdateTask extends CategoryTask {

	private long userId;
	
	private long[] categoryids;
	
	@Override
	public Object exec() throws ServiceException {
		
		UserCategoryRecord userCategory = new UserCategoryRecord();
		userCategory.setUserId(userId);
		getCategoryDao().deleteUserCategory(userCategory);
		
		if(categoryids != null && categoryids.length > 0) {
			
			for (long cid : categoryids) {
//				if(cid > 0) {
//					CategoryRecord c = getCategoryDao().findCategoryRecordByPK(cid);
//					if(c.getParentId() > 0) {
						userCategory.setParentCategoryId(cid);
						userCategory.setCategoryId(-1);
						getCategoryDao().insertUserCategory(userCategory);
//					}
//				}
			}
			
		}
		
		return null;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long[] getCategoryids() {
		return categoryids;
	}

	public void setCategoryids(long[] categoryids) {
		this.categoryids = categoryids;
	}
}
