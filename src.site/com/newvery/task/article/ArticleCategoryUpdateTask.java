package com.newvery.task.article;

import java.util.Date;

import com.newvery.dal.dao.category.ICategoryDao;
import com.newvery.dal.dao.category.impl.CategoryDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;
import com.newvery.record.CategoryRecord;

public class ArticleCategoryUpdateTask extends ArticleTask {

	@Override
	public Object exec() throws ServiceException {
		ArticleRecord a = getArticleDao().findArticleRecordByPK(getArticle().getId());
		
		CategoryRecord category = getCategoryDao().findCategoryRecordByPK(getArticle().getParentCategoryId());
		if(category != null) {
			getArticle().setParentCategoryName(category.getName());			//父类分类名称
		}
		
		category = getCategoryDao().findCategoryRecordByPK(getArticle().getChildCategoryId());
		if(category != null) {
			getArticle().setChildCategoryName(category.getName());			//子类分类名称
		}
		
		a.setParentCategoryId(getArticle().getParentCategoryId());
		a.setChildCategoryId(getArticle().getChildCategoryId());
		
		a.setParentCategoryName(getArticle().getParentCategoryName());
		a.setChildCategoryName(getArticle().getChildCategoryName());
		
		a.setModifyTime(new Date());
		
		a = getArticleDao().updateArticleRecord(a);
		
		return a;
	}

	public ICategoryDao getCategoryDao() {
		return (ICategoryDao) getDaoManagerFactory().getManagerImpl(CategoryDaoImpl.class);
	}
	
}