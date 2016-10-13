package com.newvery.task.article;

import com.newvery.exception.ServiceException;

/**
 * 物理删除文章
 * @author mi_xb
 *
 */
public class ArticlePhysicsDeleteTask extends ArticleTask {

	@Override
	public Object exec() throws ServiceException {
		getArticleDao().physicsDeleteArticleRecord(getArticle().getId());
		
		return null;
	}

}
