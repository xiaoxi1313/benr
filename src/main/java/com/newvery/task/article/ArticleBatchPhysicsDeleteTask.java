package com.newvery.task.article;

import java.util.HashMap;
import java.util.Map;

import com.newvery.exception.ServiceException;

/**
 * 批量物理删除
 * @author mi_xb
 *
 */
public class ArticleBatchPhysicsDeleteTask extends ArticleTask {
	private String[] articleIds;
	@Override
	public Object exec() throws ServiceException {
		if (articleIds != null && articleIds.length > 0) {
			Map query = new HashMap();
			query.put("articleIdList", articleIds);
			
			getArticleDao().batchPhysicsDeleteArticleRecord(query);
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
