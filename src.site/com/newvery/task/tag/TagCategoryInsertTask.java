package com.newvery.task.tag;

import java.util.Date;

import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.TagCategoryRecord;

public class TagCategoryInsertTask extends TagTask {
	private TagCategoryRecord tagCategory;

	@Override
	public Object exec() throws ServiceException {
		TagCategoryRecord category = getTagDao().findTagCategoryRecordByName(tagCategory.getName());
		if (category != null) {
			throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "该名称已存在！");
		}
		
		tagCategory.setCreateTime(new Date());
		tagCategory.setDeleted(false);
		
		return getTagDao().insertTagCategoryRecord(tagCategory);
	}

	public TagCategoryRecord getTagCategory() {
		return tagCategory;
	}

	public void setTagCategory(TagCategoryRecord tagCategory) {
		this.tagCategory = tagCategory;
	}
}
