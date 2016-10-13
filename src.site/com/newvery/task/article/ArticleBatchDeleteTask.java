package com.newvery.task.article;

import java.util.HashMap;
import java.util.Map;

import com.newvery.exception.ServiceException;

/**
 * 批量删除
 * @author mi_xb
 *
 */
public class ArticleBatchDeleteTask extends ArticleTask {
	private String[] articleIds;
	@Override
	public Object exec() throws ServiceException {
		if (articleIds != null && articleIds.length > 0) {
			Map query = new HashMap();
			query.put("articleIdList", articleIds);
			
			getArticleDao().batchDeleteArticleRecord(query);
		}
		return null;
	}
	
	public String[] getArticleIds() {
		return articleIds;
	}
	public void setArticleIds(String[] articleIds) {
		this.articleIds = articleIds;
	}

}
