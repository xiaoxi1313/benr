package com.newvery.task.tag;

import com.newvery.exception.ServiceException;

public class TagDeleteTask extends TagTask {

	@Override
	public Object exec() throws ServiceException {
		getTagDao().deleteTagRecord(getTag().getId());
		getTagDao().deleteTagArticle(getTag().getId());
		return null;
	}

}
