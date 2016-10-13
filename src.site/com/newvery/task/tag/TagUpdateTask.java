package com.newvery.task.tag;

import java.util.Date;

import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.TagRecord;

public class TagUpdateTask extends TagTask {

	@Override
	public Object exec() throws ServiceException {
		TagRecord t = getTagDao().findTagRecordByName(getTag().getName());
		if (t != null && t.getId() != getTag().getId()) {
			throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "该标签名称已存在！");
		}
		
		t = getTagDao().findTagRecordByPK(getTag().getId());
		t.setName(getTag().getName());
		t.setAlias(getTag().getAlias());
		t.setModifyTime(new Date());
		t.setTooltip(getTag().getTooltip());
		if (getTag().getCategoryId() > 0) {
			t.setCategoryId(getTag().getCategoryId());
		}
		
		getTagDao().updateTagRecord(t);
		
		return t;
	}

}
