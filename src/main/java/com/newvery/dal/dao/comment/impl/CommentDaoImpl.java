package com.newvery.dal.dao.comment.impl;

import java.util.List;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.comment.ICommentDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.CommentRecord;

public class CommentDaoImpl extends BaseDao implements ICommentDao {

	@Override
	public CommentRecord insertComment(CommentRecord comment) throws ServiceException {
		getSqlTemplate().insert("insertComment", comment);
		return comment;
	}

	@Override
	public void deleteComment(long id) throws ServiceException {
		getSqlTemplate().update("deleteCommentById", id);
	}

	@Override
	public List<CommentRecord> findCommentByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("findCommentByArticleId", articleId);
	}

	@Override
	public List<CommentRecord> findCommentByParentId(long parentId) throws ServiceException {
		return getSqlTemplate().selectList("findCommentByParentId", parentId);
	}

	@Override
	public List<CommentRecord> findParentCommentByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("findParentCommentByArticleId", articleId);
	}

}
