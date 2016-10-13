package com.newvery.task.category;

import java.util.List;

import com.newvery.exception.ServiceException;
import com.newvery.record.CategoryRecord;

public class CategoryDeleteTask extends CategoryTask {

	@Override
	public Object exec() throws ServiceException {
		if (getCategory().getParentId() == 0) {
			List<CategoryRecord> list = getCategoryDao().findChildrenByParentId(getCategory().getId());
			for (CategoryRecord c : list) {
				getCategoryDao().deleteCategoryRecord(c.getId());
			}
		}
		
		getCategoryDao().deleteCategoryRecord(getCategory().getId());
		return null;
	}
}
