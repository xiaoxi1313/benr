package com.newvery.task.um;

import java.util.HashSet;
import java.util.Set;

import com.newvery.exception.ServiceException;
import com.newvery.record.AssignCategoryRecord;

public class UserAssignCategoryTask extends UserTask {
	
	private long userId;
	private long[] categoryIds;
	

	@Override
	public Object exec() throws ServiceException {
		
		if(categoryIds != null && categoryIds.length > 0) {
			
			getUserDao().deleteAssignCategoryByUserId(userId);
			
			
			Set<Long> existSet = new HashSet<Long>();
			for (long cid : categoryIds) {
				if(cid < 1) continue;
				if(!existSet.contains(cid)) {
					AssignCategoryRecord assignCategory = new AssignCategoryRecord();
					assignCategory.setCategoryId(cid);
					assignCategory.setUserId(userId);
					getUserDao().insertAssignCategory(assignCategory);
					
					existSet.add(cid);
				}
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


	public long[] getCategoryIds() {
		return categoryIds;
	}


	public void setCategoryIds(long[] categoryIds) {
		this.categoryIds = categoryIds;
	}

}
