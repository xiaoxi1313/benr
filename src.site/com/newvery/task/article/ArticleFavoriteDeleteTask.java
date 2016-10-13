package com.newvery.task.article;

import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleFavoriteRecord;

public class ArticleFavoriteDeleteTask extends ArticleTask {
	
	private long userId;
	private long articleId;
	private long favoriteGroupId;
	
	private ArticleFavoriteRecord articleFavorite;
	
	@Override
	public Object exec() throws ServiceException {
		
		if(articleFavorite != null) {
			getArticleDao().deleteArticleFavorite(articleFavorite.getId());
		} else {
			getArticleDao().deleteArticleFavorite(articleId,userId);
			getArticleDao().deleteArticleGroupFavorite(articleId,favoriteGroupId);
		}
		
		
		return null;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getArticleId() {
		return articleId;
	}

	public void setArticleId(long articleId) {
		this.articleId = articleId;
	}

	public long getFavoriteGroupId() {
		return favoriteGroupId;
	}

	public void setFavoriteGroupId(long favoriteGroupId) {
		this.favoriteGroupId = favoriteGroupId;
	}

	public ArticleFavoriteRecord getArticleFavorite() {
		return articleFavorite;
	}

	public void setArticleFavorite(ArticleFavoriteRecord articleFavorite) {
		this.articleFavorite = articleFavorite;
	}
}
