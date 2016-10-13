package com.newvery.task.article;

import java.util.Date;

import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleFavoriteRecord;
import com.newvery.record.FavoriteRecord;

/**
 * 文章加入收藏夹
 * @author mi_xb
 *
 */
public class ArticleFavoriteTask extends ArticleTask {
	private ArticleFavoriteRecord articleFavorite;
	
	@Override
	public Object exec() throws ServiceException {
		ArticleFavoriteRecord af = new ArticleFavoriteRecord();
		af.setUserId(articleFavorite.getUserId());
		af.setArticleId(articleFavorite.getArticleId());
		af.setChildFavoriteId(articleFavorite.getChildFavoriteId());
		
		af = getArticleDao().findArticleFavorite(af);
		
		if (af.getId() > 0) {
			return af;
		}
		
		articleFavorite.setDeleted(false);
		articleFavorite.setCreateTime(new Date());
		
		getArticleDao().insertArticleFavorite(articleFavorite);
		
		// 相关收藏夹文章数 + 1
		FavoriteRecord parent = getFavoriteDao().findFavoriteRecordByPK(articleFavorite.getParentFavoriteId());
		if (parent != null) {
			getFavoriteDao().updateArticle(parent.getId(), parent.getArticleNum() + 1);
		}
		
		FavoriteRecord child = getFavoriteDao().findFavoriteRecordByPK(articleFavorite.getChildFavoriteId());
		if (child != null) {
			getFavoriteDao().updateArticle(child.getId(), child.getArticleNum() + 1);
		}
		return articleFavorite;
	}

	public IFavoriteDao getFavoriteDao() {
		return (IFavoriteDao) getDaoManagerFactory().getManagerImpl(FavoriteDaoImpl.class);
	}
	
	public ArticleFavoriteRecord getArticleFavorite() {
		return articleFavorite;
	}

	public void setArticleFavorite(ArticleFavoriteRecord articleFavorite) {
		this.articleFavorite = articleFavorite;
	}
}
