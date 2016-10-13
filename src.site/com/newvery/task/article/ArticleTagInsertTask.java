package com.newvery.task.article;

import java.util.Date;

import com.newvery.Constants;
import com.newvery.ErrorCode;
import com.newvery.dal.dao.category.ICategoryDao;
import com.newvery.dal.dao.category.impl.CategoryDaoImpl;
import com.newvery.dal.dao.tag.ITagDao;
import com.newvery.dal.dao.tag.impl.TagDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleTagRecord;
import com.newvery.record.TagRecord;

public class ArticleTagInsertTask extends ArticleTask {
	private TagRecord tag;
	
	@Override
	public Object exec() throws ServiceException {
		if(tag.getId()>0){
			
			ArticleTagRecord atr = getArticleDao().findArticleTagByArticleAndTagId(getArticle().getId(), tag.getId());
			if(atr != null) {
				throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "文章已加入了当前标签！");
			}
			tag = getTagDao().findTagRecordByPK(tag.getId());
			getTagDao().updateArticleNum(tag.getId(), tag.getArticleNum()+1);
			
		}else{
			TagRecord t = getTagDao().findTagRecordByName(getTag().getName());
			if (t != null) {
				
				getTagDao().updateArticleNum(t.getId(), t.getArticleNum()+1);
				tag = t;
				//throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "名称已存在！");
			} else {
				getTag().setArticleNum(1);
				getTag().setCreateTime(new Date());
				getTag().setDeleted(false);
				getTag().setStatus(Constants.TAG_STATUS_NEW);
				tag = getTagDao().insertTagRecord(getTag());
			}
			
		}
		
		ArticleTagRecord at = new ArticleTagRecord();
		at.setArticleId(getArticle().getId());
		at.setCreateTime(new Date());
		at.setDeleted(false);
		at.setTagId(tag.getId());
		at.setUserId(getArticle().getUserId());
		getArticleDao().insertArticleTag(at);
		
		return getTag();
	}
	
	public ITagDao getTagDao() {
		return (ITagDao)getDaoManagerFactory().getManagerImpl(TagDaoImpl.class);
	}
	
	public ICategoryDao getCategoryDao() {
		return (ICategoryDao) getDaoManagerFactory().getManagerImpl(CategoryDaoImpl.class);
	}
	
	public TagRecord getTag() {
		return tag;
	}

	public void setTag(TagRecord tag) {
		this.tag = tag;
	}
}
