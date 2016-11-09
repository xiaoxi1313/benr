package com.newvery.dal.dao.comment;

import java.util.List;

import com.newvery.exception.ServiceException;
import com.newvery.record.CommentRecord;

public interface ICommentDao {
	public CommentRecord insertComment(CommentRecord comment) throws ServiceException;
	public void deleteComment(long id) throws ServiceException;
	public List<CommentRecord> findCommentByArticleId(long articleId) throws ServiceException;
	public List<CommentRecord> findParentCommentByArticleId(long articleId) throws ServiceException;
	public List<CommentRecord> findCommentByParentId(long parentId) throws ServiceException;
}
