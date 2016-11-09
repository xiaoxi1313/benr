package com.newvery.task.article;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;

/**
 * 文章移出回收站
 * @author mi_xb
 *
 */
public class ArticleRemoveRecycleTask extends ArticleTask {

	@Override
	public Object exec() throws ServiceException {
		ArticleRecord a = getArticleDao().findArticleRecordByPK(getArticle().getId());
		a.setDeleted(false);
		a.setModifyTime(new Date());
		getArticleDao().updateArticleRecord(a);
		
		// 用户文章数量+1
		getUserDao().updateUserArticleNum(a.getUserId(), a.getUser().getArticleNum() + 1);
		return null;
	}

}
