package com.newvery.task.article;

import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;

/**
 * 文章移到回收站
 * @author mi_xb
 *
 */
public class ArticleDeleteTask extends ArticleTask {

	@Override
	public Object exec() throws ServiceException {
		getArticleDao().deleteArticleRecord(getArticle().getId());
		
		// 用户文章数量-1
		ArticleRecord a = BeanFactory.getArticleDao().findArticleRecordByPK(getArticle().getId());
		getUserDao().updateUserArticleNum(a.getUserId(), a.getUser().getArticleNum() - 1);
		return null;
	}

}
