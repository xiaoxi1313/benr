package com.newvery.task.tag;

import java.util.Date;

import com.newvery.Constants;
import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.TagRecord;

public class TagInsertTask extends TagTask {

	@Override
	public Object exec() throws ServiceException {
		TagRecord t = getTagDao().findTagRecordByName(getTag().getName());
		if (t != null) {
			throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "名称已存在！");
		}
		
		getTag().setArticleNum(0);
		getTag().setCreateTime(new Date());
		getTag().setDeleted(false);
		getTag().setStatus(Constants.TAG_STATUS_NEW);
		
		return getTagDao().insertTagRecord(getTag());
	}
}
