package com.newvery.task.article;

import java.util.Date;
import java.util.UUID;

import com.newvery.bean.BeanFactory;
import com.newvery.dal.dao.category.ICategoryDao;
import com.newvery.dal.dao.category.impl.CategoryDaoImpl;
import com.newvery.dal.dao.tag.ITagDao;
import com.newvery.dal.dao.tag.impl.TagDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleTagRecord;
import com.newvery.record.CategoryRecord;
import com.newvery.record.TagRecord;
import com.newvery.record.UserRecord;

public class ArticleInsertTask extends ArticleTask {
	private String[] tagIds;
	
	@Override
	public Object exec() throws ServiceException {
		getArticle().setStatus(1);
		getArticle().setDeleted(false);
		//getArticle().setCreateTime(new Date());
		getArticle().setSerial(UUID.randomUUID().toString());
		
		CategoryRecord category = getCategoryDao().findCategoryRecordByPK(getArticle().getParentCategoryId());
		if(category != null) {
			getCategoryDao().updateArticle(getArticle().getParentCategoryId(), category.getArticleNum() + 1);
			getArticle().setParentCategoryName(category.getName());			//父类分类名称
		}
		
		category = getCategoryDao().findCategoryRecordByPK(getArticle().getChildCategoryId());
		if(category != null) {
			getCategoryDao().updateArticle(getArticle().getChildCategoryId(), category.getArticleNum() + 1);
			getArticle().setChildCategoryName(category.getName());			//子类分类名称
		}
		
		
		setArticle(getArticleDao().insertArticleRecord(getArticle()));
		
		// 标签
		if (tagIds != null && tagIds.length > 0) {
			for (String tagIdStr : tagIds) {
				long tagId = Long.parseLong(tagIdStr);
				TagRecord tag = BeanFactory.getTagDao().findTagRecordByPK(tagId);
				tag.setArticleNum(tag.getArticleNum() + 1);
				tag.setModifyTime(new Date());
				
				getTagDao().updateTagRecord(tag);
				
				ArticleTagRecord at = new ArticleTagRecord();
				at.setArticleId(getArticle().getId());
				at.setCreateTime(new Date());
				at.setDeleted(false);
				at.setTagId(tag.getId());
				at.setUserId(getArticle().getUserId());
				
				getArticleDao().insertArticleTag(at);
			}
		}
		
		// 文章数 +1
		UserRecord user = getUserDao().findUserById(getArticle().getUserId());
		getUserDao().updateUserArticleNum(user.getId(), user.getArticleNum() + 1);
		
		
		return getArticle();
	}
	
	public ITagDao getTagDao() {
		return (ITagDao)getDaoManagerFactory().getManagerImpl(TagDaoImpl.class);
	}
	
	public ICategoryDao getCategoryDao() {
		return (ICategoryDao) getDaoManagerFactory().getManagerImpl(CategoryDaoImpl.class);
	}
	
	public String[] getTagIds() {
		return tagIds;
	}

	public void setTagIds(String[] tagIds) {
		this.tagIds = tagIds;
	}
}
