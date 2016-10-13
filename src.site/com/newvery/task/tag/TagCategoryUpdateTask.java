package com.newvery.task.tag;

import java.util.Date;

import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.TagCategoryRecord;

public class TagCategoryUpdateTask extends TagTask {
	private TagCategoryRecord tagCategory;
	
	@Override
	public Object exec() throws ServiceException {
		TagCategoryRecord category = getTagDao().findTagCategoryRecordByName(tagCategory.getName());
		if (category != null && category.getId() != tagCategory.getId()) {
			throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "该名称已存在！");
		}
		
		tagCategory.setModifyTime(new Date());
		return getTagDao().updateTagCategoryRecord(tagCategory);
	}

	public TagCategoryRecord getTagCategory() {
		return tagCategory;
	}

	public void setTagCategory(TagCategoryRecord tagCategory) {
		this.tagCategory = tagCategory;
	}
}
