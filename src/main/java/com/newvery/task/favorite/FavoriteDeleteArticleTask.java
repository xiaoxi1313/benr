package com.newvery.task.favorite;

import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.article.impl.ArticleDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleFavoriteRecord;
import com.newvery.record.FavoriteRecord;

/**
 * 从收藏夹中删除文章
 * @author mi_xb
 *
 */
public class FavoriteDeleteArticleTask extends FavoriteTask {
	private ArticleFavoriteRecord articleFavorite;

	@Override
	public Object exec() throws ServiceException {
		articleFavorite = getArticleDao().findArticleFavorite(articleFavorite);
		if (articleFavorite != null && articleFavorite.getId() > 0) {
			getArticleDao().deleteArticleFavorite(articleFavorite.getId());
			
			// 关联收藏夹文章数 - 1
			FavoriteRecord parent = getFavoriteDao().findFavoriteRecordByPK(articleFavorite.getParentFavoriteId());
			if (parent != null) {
				getFavoriteDao().updateArticle(parent.getId(), parent.getArticleNum() - 1);
			}
			
			FavoriteRecord child = getFavoriteDao().findFavoriteRecordByPK(articleFavorite.getChildFavoriteId());
			if (child != null) {
				getFavoriteDao().updateArticle(child.getId(), child.getArticleNum() - 1);
			}
		}
		
		return null;
	}

	public IArticleDao getArticleDao() {
		return (IArticleDao) getDaoManagerFactory().getManagerImpl(ArticleDaoImpl.class);
	}

	public ArticleFavoriteRecord getArticleFavorite() {
		return articleFavorite;
	}

	public void setArticleFavorite(ArticleFavoriteRecord articleFavorite) {
		this.articleFavorite = articleFavorite;
	}
}
