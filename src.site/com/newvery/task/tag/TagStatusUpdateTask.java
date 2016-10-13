package com.newvery.task.tag;

import com.newvery.exception.ServiceException;
import com.newvery.record.TagRecord;

public class TagStatusUpdateTask extends TagTask {
	private int status;
	private long tagId;
	@Override
	public Object exec() throws ServiceException {
		TagRecord t = getTagDao().updateTagStatus(tagId, status);
		return t;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public long getTagId() {
		return tagId;
	}
	public void setTagId(long tagId) {
		this.tagId = tagId;
	}

}
