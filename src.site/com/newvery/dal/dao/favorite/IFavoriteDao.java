package com.newvery.dal.dao.favorite;

import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.FavoriteGroupRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserShareFavoriteRecord;
import com.newvery.web.bean.Page;

public interface IFavoriteDao {
	/* 分类 */
	public long insertFavoriteRecord(FavoriteRecord favorite) throws ServiceException;
	public FavoriteRecord updateFavoriteRecord(FavoriteRecord favorite) throws ServiceException;
	public void updateArticle(long id, int articleNum) throws ServiceException;
	public void deleteFavoriteRecord(long favoriteId) throws ServiceException;
	public void deleteFavoriteByUserId(long userId) throws ServiceException;
	public List<FavoriteRecord> findFavoriteRecord() throws ServiceException;
	public List<FavoriteRecord> findChildrenByParentId(long parentId) throws ServiceException;
	public FavoriteRecord findFavoriteRecordByPK(long id) throws ServiceException;
	
	public FavoriteRecord findFavoriteRecordByPKWithGroup(long id) throws ServiceException;
	
	public FavoriteRecord findFavoriteRecordByPKWithChildren(long id) throws ServiceException;
	
	public FavoriteRecord findFavoriteRecordByName(String name) throws ServiceException;
	
	public int countFavoriteRecord(String favoriteName) throws ServiceException;
	
	public List<FavoriteRecord> findAllParetnFavorite() throws ServiceException;
	
	public List<FavoriteRecord> findAllParetnFavoriteByUserId(long userId) throws ServiceException;
	
	public List<FavoriteRecord> findAllParetnFavoriteWithChildren() throws ServiceException;
	
	public List<FavoriteRecord> findAllParetnFavoriteWithChildrenByUserId(Map query) throws ServiceException;
	
	public List<FavoriteRecord> findFavoriteByParentId(long parentId) throws ServiceException;
	
	public List<FavoriteRecord> findFavoriteByCommonUserId(long userId) throws ServiceException;
	
	/**
	 * 查找最近更新过的子收藏夹
	 * @param num
	 * @return
	 * @throws ServiceException
	 */
	public List<FavoriteRecord> findRecentChildrenByNum(int num) throws ServiceException;
	
	/**
	 * 查询收藏夹总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countFavoriteByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询收藏夹分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<FavoriteRecord> findFavoriteByPage(Map query, Page page) throws ServiceException;
	
	/**
	 * 查询一级收藏夹总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countParentFavoriteByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询一级收藏夹分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<FavoriteRecord> findParentFavoriteByPage(Map query, Page page) throws ServiceException;
	
	public List<FavoriteRecord> findParentFavoriteWithChildrenByPage(Map query, Page page) throws ServiceException;
	
	/**
	 * 根据userId查询一级收藏夹
	 * @param userId
	 * @return
	 * @throws ServiceException
	 */
	public List<FavoriteRecord> findParentFavoriteByUserId(long userId) throws ServiceException;
	
	/*UserFavorite*/
	public UserFavoriteRecord insertUserFavorite(UserFavoriteRecord userFavorite) throws ServiceException;
	public void deleteUserFavorite(long id) throws ServiceException;
	public List<UserFavoriteRecord> findUserFavoriteByUserId(long userId) throws ServiceException;
	
	
	public List<UserFavoriteRecord> findUserFavoriteByGroupId(long groupId) throws ServiceException;
	
	public UserFavoriteRecord findUserFavoriteByUserIdAndChildFavoriteId(long userId, long childFavoriteId) throws ServiceException;
	
	/*FavoriteGroup*/
	public FavoriteGroupRecord insertFavoriteGroupRecord(FavoriteGroupRecord favoriteGroup) throws ServiceException;
	public FavoriteGroupRecord updateFavoriteGroupRecord(FavoriteGroupRecord favoriteGroup) throws ServiceException;
	public void deleteFavoriteGroupRecord(long favoriteGroupId) throws ServiceException;
	public List<FavoriteGroupRecord> findFavoriteGroupRecordByUserId(long userId) throws ServiceException;
	public List<FavoriteGroupRecord> findFavoriteGroupRecordByFavoriteId(long favoriteId) throws ServiceException;
	
	public void deleteFavoriteByUserGroupId(long userGroupId) throws ServiceException;
	public FavoriteGroupRecord findFavoriteGroupById(long id) throws ServiceException;
	
	
	public List<FavoriteRecord> findMyShareFavoriteList(Map query) throws ServiceException;
	public void insertUserShareFavorite(UserShareFavoriteRecord userShare) throws ServiceException;
	public boolean checkUserShareFavorite(UserShareFavoriteRecord userShare) throws ServiceException;
	public List<UserShareFavoriteRecord> listShareFavoriteByUser(long UserId) throws ServiceException;
}
