package com.newvery.task.tag;

import com.newvery.exception.ServiceException;

public class TagBatchDeleteTask extends TagTask {
	private String[] tagIds;

	@Override
	public Object exec() throws ServiceException {
		if (tagIds != null && tagIds.length > 0) {
			
			for (String t : tagIds) {
				long tagId = Long.valueOf(t);
				getTagDao().deleteTagRecord(tagId);
				getTagDao().deleteTagArticle(tagId);
			}
		}
		return null;
	}

	public String[] getTagIds() {
		return tagIds;
	}

	public void setTagIds(String[] tagIds) {
		this.tagIds = tagIds;
	}

}
