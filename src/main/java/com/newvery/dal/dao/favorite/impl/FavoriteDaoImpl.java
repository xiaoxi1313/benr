package com.newvery.dal.dao.favorite.impl;

import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteGroupRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserShareFavoriteRecord;
import com.newvery.web.bean.Page;

public class FavoriteDaoImpl extends BaseDao implements IFavoriteDao {
	
	/**
	 * Favorite
	 */
	@Override
	public long insertFavoriteRecord(FavoriteRecord favorite) throws ServiceException {
		return getSqlTemplate().insert("insertFavorite", favorite);
	}

	@Override
	public FavoriteRecord updateFavoriteRecord(FavoriteRecord favorite) throws ServiceException {
		getSqlTemplate().update("updateFavorite", favorite);
		return favorite;
	}

	@Override
	public void deleteFavoriteRecord(long favoriteId) throws ServiceException {
		getSqlTemplate().delete("deleteFavorite", favoriteId);
	}

	@Override
	public List<FavoriteRecord> findFavoriteRecord() throws ServiceException {
		return getSqlTemplate().selectList("listFavorite");
	}

	@Override
	public FavoriteRecord findFavoriteRecordByPK(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findFavoriteByPK", id);
	}
	
	@Override
	public FavoriteRecord findFavoriteRecordByPKWithGroup(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findFavoriteByPKWithGroup", id);
	}
	
	@Override
	public FavoriteRecord findFavoriteRecordByPKWithChildren(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findFavoriteByPKWithChildren", id);
	}

	@Override
	public int countFavoriteRecord(String favoriteName) throws ServiceException {
		return getSqlTemplate().selectOne("countFavoriteRecord", favoriteName);
	}
	
	@Override
	public int countFavoriteByPage(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countFavoriteByPage", query);
	}

	@Override
	public List<FavoriteRecord> findFavoriteByPage(Map query, Page page)
			throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findFavoriteByPage", query);
	}

	@Override
	public int countParentFavoriteByPage(Map query) throws ServiceException {
		query.put("isParent", 1);
		return getSqlTemplate().selectOne("countFavoriteByPage", query);
	}

	@Override
	public List<FavoriteRecord> findParentFavoriteByPage(Map query, Page page) throws ServiceException {
		query.put("isParent", 1);
		query.put("page", page);
		return getSqlTemplate().selectList("findFavoriteByPage", query);
	}
	
	@Override
	public List<FavoriteRecord> findParentFavoriteWithChildrenByPage(Map query, Page page) throws ServiceException {
		query.put("isParent", 1);
		query.put("page", page);
		return getSqlTemplate().selectList("findFavoriteWithChildrenByPage", query);
	}

	@Override
	public List<FavoriteRecord> findChildrenByParentId(long parentId) throws ServiceException {
		return getSqlTemplate().selectList("listFavoriteByParentId", parentId);
	}

	@Override
	public List<FavoriteRecord> findAllParetnFavorite() throws ServiceException {
		return getSqlTemplate().selectList("listAllParentFavorite");
	}
	
	@Override
	public List<FavoriteRecord> findAllParetnFavoriteByUserId(long userId) throws ServiceException {
		return getSqlTemplate().selectList("listAllParentFavoriteByUserId", userId);
	}
	
	@Override
	public List<FavoriteRecord> findAllParetnFavoriteWithChildren() throws ServiceException {
		return getSqlTemplate().selectList("listAllParentFavoriteWithChildren");
	}
	
	@Override
	public List<FavoriteRecord> findAllParetnFavoriteWithChildrenByUserId(Map query) throws ServiceException {
		return getSqlTemplate().selectList("listAllParentFavoriteWithChildrenByUserId", query);
	}

	@Override
	public List<FavoriteRecord> findFavoriteByParentId(long parentId) throws ServiceException {
		return getSqlTemplate().selectList("listFavoriteByParentId", parentId);
	}
	
	@Override
	public List<FavoriteRecord> findParentFavoriteByUserId(long userId) throws ServiceException {
		return getSqlTemplate().selectList("listAllParentFavoriteByUserId", userId);
	}
	
	@Override
	public List<FavoriteRecord> findRecentChildrenByNum(int num) throws ServiceException {
		return getSqlTemplate().selectList("listRecentChildrenByNum", num);
	}

	@Override
	public FavoriteRecord findFavoriteRecordByName(String name) throws ServiceException {
		return getSqlTemplate().selectOne("findFavoriteByName", name);
	}

	@Override
	public void updateArticle(long id, int articleNum) throws ServiceException {
		FavoriteRecord favorite = new FavoriteRecord();
		favorite.setId(id);
		favorite.setArticleNum(articleNum);
		
		getSqlTemplate().update("updateFavoriteArticleNum", favorite);
	}

	
	/*UserFavorite*/
	
	@Override
	public UserFavoriteRecord insertUserFavorite(UserFavoriteRecord userFavorite)throws ServiceException {
		getSqlTemplate().insert("insertUserFavorite", userFavorite);
		return userFavorite;
	}

	@Override
	public void deleteUserFavorite(long id) throws ServiceException {
		getSqlTemplate().update("deleteUserFavorite", id);
	}

	@Override
	public List<UserFavoriteRecord> findUserFavoriteByUserId(long userId)throws ServiceException {
		return getSqlTemplate().selectList("findUserFavoriteByUserId", userId);
	}

	@Override
	public List<UserFavoriteRecord> findUserFavoriteByGroupId(long groupId) throws ServiceException {
		return getSqlTemplate().selectList("findUserFavoriteByGroupId", groupId);
	}
	
	@Override
	public List<FavoriteRecord> findFavoriteByCommonUserId(long userId)throws ServiceException {
		return getSqlTemplate().selectList("listFavoriteByCommonUserId", userId);
	}

	@Override
	public UserFavoriteRecord findUserFavoriteByUserIdAndChildFavoriteId(long userId, long childFavoriteId) throws ServiceException {
		UserFavoriteRecord uf = new UserFavoriteRecord();
		uf.setUserId(userId);
		uf.setChildFavoriteId(childFavoriteId);
		
		return getSqlTemplate().selectOne("findUserFavoriteByUserIdAndChildFavoriteId", uf);
	}

	@Override
	public FavoriteGroupRecord insertFavoriteGroupRecord(FavoriteGroupRecord favoriteGroup) throws ServiceException {
		getSqlTemplate().insert("insertFavoriteGroup", favoriteGroup);
		return favoriteGroup;
	}

	@Override
	public FavoriteGroupRecord updateFavoriteGroupRecord(FavoriteGroupRecord favoriteGroup) throws ServiceException {
		getSqlTemplate().update("updateFavoriteGroup", favoriteGroup);
		return favoriteGroup;
	}

	@Override
	public void deleteFavoriteGroupRecord(long favoriteGroupId) throws ServiceException {
		getSqlTemplate().update("deleteFavoriteGroup", favoriteGroupId);
	}

	@Override
	public List<FavoriteGroupRecord> findFavoriteGroupRecordByUserId(long userId) throws ServiceException {
		return getSqlTemplate().selectList("listFavoriteGroupByUserId", userId);
	}
	
	@Override
	public List<FavoriteGroupRecord> findFavoriteGroupRecordByFavoriteId(long favoriteId) throws ServiceException {
		return getSqlTemplate().selectList("listFavoriteGroupByFavoriteId", favoriteId);
	}

	@Override
	public void deleteFavoriteByUserGroupId(long userGroupId) throws ServiceException {
		getSqlTemplate().delete("deleteFavoriteByUserGroupId", userGroupId);
	}
	
	@Override
	public FavoriteGroupRecord findFavoriteGroupById(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findFavoriteGroupByPK", id);
	}
	
	@Override
	public List<FavoriteRecord> findMyShareFavoriteList(Map query) throws ServiceException {
		return getSqlTemplate().selectList("findMyShareFavoriteList", query);
	}
	
	@Override
	public void insertUserShareFavorite(UserShareFavoriteRecord userShare) throws ServiceException {
		getSqlTemplate().insert("insertuserShareFavorite",userShare);
	}
	
	@Override
	public boolean checkUserShareFavorite(UserShareFavoriteRecord userShare) throws ServiceException {
		int t = getSqlTemplate().selectOne("checkUserShareFavorite", userShare) ;
		return t > 0;
	}
	
	@Override
	public List<UserShareFavoriteRecord> listShareFavoriteByUser(long UserId) throws ServiceException {
		return getSqlTemplate().selectList("listShareFavoriteByUser", UserId);
	}
	
	@Override
	public void deleteFavoriteByUserId(long userId) throws ServiceException {
		getSqlTemplate().delete("deleteFavoriteByUserId", userId);
	}
}
