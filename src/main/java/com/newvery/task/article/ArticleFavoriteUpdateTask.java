package com.newvery.task.article;

import java.util.Date;

import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleFavoriteRecord;

/**
 * 文章加入收藏夹--修改
 * @author mi_xb
 *
 */
public class ArticleFavoriteUpdateTask extends ArticleTask {
	private ArticleFavoriteRecord articleFavorite;
	
	@Override
	public Object exec() throws ServiceException {
		ArticleFavoriteRecord af = new ArticleFavoriteRecord();
		af.setUserId(articleFavorite.getUserId());
		af.setArticleId(articleFavorite.getArticleId());
		af.setChildFavoriteId(articleFavorite.getChildFavoriteId());
		af = getArticleDao().findArticleFavorite(af);
		
		
		
		if (articleFavorite.getChildFavoriteId() == 0) {
			return af;
		}
		if(af != null) {
			
			// 相关收藏夹文章数 - 1
//			FavoriteRecord parent = getFavoriteDao().findFavoriteRecordByPK(af.getParentFavoriteId());
//			if (parent != null) {
//				getFavoriteDao().updateArticle(parent.getId(), parent.getArticleNum() - 1);
//			}
//			
//			FavoriteRecord child = getFavoriteDao().findFavoriteRecordByPK(af.getChildFavoriteId());
//			if (child != null) {
//				getFavoriteDao().updateArticle(child.getId(), child.getArticleNum() - 1);
//			}
//			
//			
//			// 相关收藏夹文章数 + 1
//			parent = getFavoriteDao().findFavoriteRecordByPK(af.getParentFavoriteId());
//			if (parent != null) {
//				getFavoriteDao().updateArticle(parent.getId(), parent.getArticleNum() + 1);
//			}
//			
//			child = getFavoriteDao().findFavoriteRecordByPK(af.getChildFavoriteId());
//			if (child != null) {
//				getFavoriteDao().updateArticle(child.getId(), child.getArticleNum() + 1);
//			}
//			
//			af.setParentFavoriteId(articleFavorite.getParentFavoriteId());
//			af.setChildFavoriteId(articleFavorite.getChildFavoriteId());
//			af.setModifyTime(new Date());
//			
//			af = getArticleDao().updateArticleFavorite(af);
			
			return af;
			
		} else {
			af = new ArticleFavoriteRecord();
			af.setUserId(articleFavorite.getUserId());
			af.setArticleId(articleFavorite.getArticleId());
			af.setParentFavoriteId(articleFavorite.getParentFavoriteId());
			af.setChildFavoriteId(articleFavorite.getChildFavoriteId());
			af.setModifyTime(new Date());
			af = getArticleDao().insertArticleFavorite(af);
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
