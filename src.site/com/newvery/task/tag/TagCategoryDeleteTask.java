package com.newvery.task.tag;

import com.newvery.exception.ServiceException;
import com.newvery.record.TagCategoryRecord;

public class TagCategoryDeleteTask extends TagTask {
	private TagCategoryRecord tagCategory;

	@Override
	public Object exec() throws ServiceException {
		getTagDao().deleteTagCategoryRecord(tagCategory.getId());
		return null;
	}

	public TagCategoryRecord getTagCategory() {
		return tagCategory;
	}

	public void setTagCategory(TagCategoryRecord tagCategory) {
		this.tagCategory = tagCategory;
	}
}
