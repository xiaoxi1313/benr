package com.newvery.task.category;

import java.util.HashMap;
import java.util.Map;

import com.newvery.exception.ServiceException;

public class CategoryBatchDeleteTask extends CategoryTask {
	private String[] categoryIds;

	@Override
	public Object exec() throws ServiceException {
		if (categoryIds != null && categoryIds.length > 0) {
			Map query = new HashMap();
			query.put("categoryIdList", categoryIds);
		
			getCategoryDao().batchDeleteCategory(query);
		}
		return null;
	}

	public String[] getCategoryIds() {
		return categoryIds;
	}

	public void setCategoryIds(String[] categoryIds) {
		this.categoryIds = categoryIds;
	}

}
