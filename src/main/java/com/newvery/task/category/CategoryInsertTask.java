package com.newvery.task.category;

import java.util.Date;

import com.newvery.exception.ServiceException;

public class CategoryInsertTask extends CategoryTask {

	@Override
	public Object exec() throws ServiceException {
		getCategory().setCreateTime(new Date());
		getCategory().setDeleted(false);
		
		return getCategoryDao().insertCategoryRecord(getCategory());
	}
}
