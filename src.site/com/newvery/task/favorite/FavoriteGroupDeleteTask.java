package com.newvery.task.favorite;

import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.article.impl.ArticleDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteGroupRecord;

/**
 * 删除文件夹分组
 * @author mi_xb
 *
 */
public class FavoriteGroupDeleteTask extends FavoriteTask {
	private FavoriteGroupRecord favoriteGroup;

	@Override
	public Object exec() throws ServiceException {
		getArticleDao().deleteArticleFavoriteGroupByfavoriteGroupId(favoriteGroup.getId());
		getFavoriteDao().deleteFavoriteGroupRecord(favoriteGroup.getId());
		
		return null;
	}
	
	public IArticleDao getArticleDao() {
		return (IArticleDao) getDaoManagerFactory().getManagerImpl(ArticleDaoImpl.class);
	}

	public FavoriteGroupRecord getFavoriteGroup() {
		return favoriteGroup;
	}

	public void setFavoriteGroup(FavoriteGroupRecord favoriteGroup) {
		this.favoriteGroup = favoriteGroup;
	}
}
