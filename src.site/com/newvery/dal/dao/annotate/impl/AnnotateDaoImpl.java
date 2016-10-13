package com.newvery.dal.dao.annotate.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.annotate.IAnnotateDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;

public class AnnotateDaoImpl extends BaseDao implements IAnnotateDao {

	@Override
	public AnnotateRecord insertAnnotate(AnnotateRecord annotate) throws ServiceException {
		getSqlTemplate().insert("insertAnnotate", annotate);
		return annotate;
	}

	@Override
	public void deleteAnnotate(long id) throws ServiceException {
		getSqlTemplate().update("deleteAnnotate", id);
	}

	@Override
	public List<AnnotateRecord> findAnnotateByArticleId(long articleId) throws ServiceException {
		return getSqlTemplate().selectList("findAnnotateByArticleId", articleId);
	}

	@Override
	public List<AnnotateRecord> findAnnotate(Map query) throws ServiceException {
		return getSqlTemplate().selectList("findAnnotate", query);
	}

	@Override
	public AnnotateRecord updateAnnotate(AnnotateRecord annotate) throws ServiceException {
		getSqlTemplate().update("updateAnnotate", annotate);
		return annotate;
	}

	@Override
	public List<AnnotateRecord> listTodayAnnotate(long userId, int type) throws ServiceException {
		Map query = new HashMap();
		query.put("userId", userId);
		query.put("type", type);
		
		return getSqlTemplate().selectList("listTodayAnnotate", query);
	}

	@Override
	public AnnotateRecord findAnnotateByPK(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findAnnotateById", id);
	}

}
