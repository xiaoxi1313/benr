package com.newvery.task.favorite;

import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.article.impl.ArticleDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleFavoriteRecord;

/**
 * 批量修改收藏夹内文章排序
 * @author mi_xb
 *
 */
public class FavoriteBatchUpdateArticleOrderTask extends FavoriteTask {
	private String[] articleIds;
	private long childFavoriteId;
	private long userId;
	
	@Override
	public Object exec() throws ServiceException {
		if (articleIds != null && articleIds.length > 0) {
			for (int i=0; i<articleIds.length; i++) {
				long articleId = Long.parseLong(articleIds[i]);
				ArticleFavoriteRecord af = new ArticleFavoriteRecord();
				af.setUserId(userId);
				af.setChildFavoriteId(childFavoriteId);
				af.setArticleId(articleId);
				
				af = getArticleDao().findArticleFavorite(af);
				
				if (af != null) {
					af.setPosition(i + 1);
					getArticleDao().updateArticleFavorite(af);
				}
			}
		}
		return null;
	}
	
	public IArticleDao getArticleDao() {
		return (IArticleDao) getDaoManagerFactory().getManagerImpl(ArticleDaoImpl.class);
	}

	public String[] getArticleIds() {
		return articleIds;
	}

	public void setArticleIds(String[] articleIds) {
		this.articleIds = articleIds;
	}

	public long getChildFavoriteId() {
		return childFavoriteId;
	}

	public void setChildFavoriteId(long childFavoriteId) {
		this.childFavoriteId = childFavoriteId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}
}
