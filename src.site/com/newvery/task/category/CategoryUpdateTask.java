package com.newvery.task.category;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.CategoryRecord;

public class CategoryUpdateTask extends CategoryTask {

	@Override
	public Object exec() throws ServiceException {
		CategoryRecord c = getCategoryDao().findCategoryRecordByPK(getCategory().getId());
		c.setAlias(getCategory().getAlias());
		c.setName(getCategory().getName());
		c.setModifyTime(new Date());
		c.setTagName(getCategory().getTagName());
		c = getCategoryDao().updateCategoryRecord(c);
		return c;
	}

}
