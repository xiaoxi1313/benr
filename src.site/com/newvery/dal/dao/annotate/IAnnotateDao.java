package com.newvery.dal.dao.annotate;

import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;

public interface IAnnotateDao {
	public AnnotateRecord insertAnnotate(AnnotateRecord annotate) throws ServiceException;
	
	public AnnotateRecord updateAnnotate(AnnotateRecord annotate) throws ServiceException;
	
	public AnnotateRecord findAnnotateByPK(long id) throws ServiceException;
	
	public void deleteAnnotate(long id) throws ServiceException;
	
	public List<AnnotateRecord> findAnnotateByArticleId(long articleId) throws ServiceException;
	
	public List<AnnotateRecord> findAnnotate(Map query) throws ServiceException; 
	
	public List<AnnotateRecord> listTodayAnnotate(long userId, int type) throws ServiceException;
}
