package com.newvery.task.article;

import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleFavoriteGroupRecord;

/**
 * 新建文章分组关系
 * @author mi_xb
 *
 */
public class ArticleFavoriteGroupInsertTask extends ArticleTask {
	private ArticleFavoriteGroupRecord articleFavoriteGroup;

	@Override
	public Object exec() throws ServiceException {
		
		ArticleFavoriteGroupRecord a = getArticleDao().selectFavoriteGroupSingleOjbect(articleFavoriteGroup.getArticleId(), articleFavoriteGroup.getFavoriteGroupId());
		if(a == null) {
			articleFavoriteGroup = getArticleDao().insertArticleFavoriteGroup(articleFavoriteGroup);
		}
		return articleFavoriteGroup;
	}

	public ArticleFavoriteGroupRecord getArticleFavoriteGroup() {
		return articleFavoriteGroup;
	}

	public void setArticleFavoriteGroup(
			ArticleFavoriteGroupRecord articleFavoriteGroup) {
		this.articleFavoriteGroup = articleFavoriteGroup;
	}

}
