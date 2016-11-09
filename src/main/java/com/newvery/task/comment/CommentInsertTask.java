package com.newvery.task.comment;

import java.util.Date;

import com.newvery.exception.ServiceException;

public class CommentInsertTask extends CommentTask {

	@Override
	public Object exec() throws ServiceException {
		getComment().setCreateTime(new Date());
		getComment().setDeleted(false);
		getComment().setStatus(1);

		getCommentDao().insertComment(getComment());
		return getComment();
	}

}
