package com.newvery.task.article;

import java.util.Date;

import com.newvery.bean.BeanFactory;
import com.newvery.dal.dao.category.ICategoryDao;
import com.newvery.dal.dao.category.impl.CategoryDaoImpl;
import com.newvery.dal.dao.tag.ITagDao;
import com.newvery.dal.dao.tag.impl.TagDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;
import com.newvery.record.ArticleTagRecord;
import com.newvery.record.CategoryRecord;
import com.newvery.record.TagRecord;

public class ArticleUpdateTask extends ArticleTask {
	private String[] tagIds;
	
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
		
		a.setTitle(getArticle().getTitle());
		a.setChildCategoryId(getArticle().getChildCategoryId());
		a.setContent(getArticle().getContent());
		a.setModifyTime(new Date());
		a.setSummary(getArticle().getSummary());
		a.setParentCategoryId(getArticle().getParentCategoryId());
		a.setTitleImage(getArticle().getTitleImage());
		a.setSourceLink(getArticle().getSourceLink());
		a.setCreateTime(getArticle().getCreateTime());
		a.setParentCategoryName(getArticle().getParentCategoryName());
		a.setChildCategoryName(getArticle().getChildCategoryName());
		
		setArticle(getArticleDao().updateArticleRecord(a));
		
		/**List<ArticleTagRecord> articleTagList = getArticleDao().findArticleTagByArticleId(getArticle().getId());
		for (ArticleTagRecord at : articleTagList) {
			if (tagIds != null && tagIds.length > 0) {
				for (String tagIdStr : tagIds) {
					long tagId = Long.parseLong(tagIdStr);
					if () {
						
					}
				}
			}
		}*/
		
		// 删除原有标签
		getArticleDao().deleteArticleTagByArticleId(getArticle().getId());
		
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
