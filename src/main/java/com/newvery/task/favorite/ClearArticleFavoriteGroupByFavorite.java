package com.newvery.task.favorite;

import java.util.List;

import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.article.impl.ArticleDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteGroupRecord;

/**
 * 清空收藏夹下的文章分组信息
 * @author mi_xb
 *
 */
public class ClearArticleFavoriteGroupByFavorite extends FavoriteTask {

	@Override
	public Object exec() throws ServiceException {
		List<FavoriteGroupRecord> gList = getFavoriteDao().findFavoriteGroupRecordByFavoriteId(getFavorite().getId());
		for (FavoriteGroupRecord group : gList) {
			getArticleDao().deleteArticleFavoriteGroupByfavoriteGroupId(group.getId());
		}
		return null;
	}

	public IArticleDao getArticleDao() {
		return (IArticleDao) getDaoManagerFactory().getManagerImpl(ArticleDaoImpl.class);
	}
}
