package com.newvery.task.um;

import java.util.Date;

import com.newvery.dal.dao.category.ICategoryDao;
import com.newvery.dal.dao.category.impl.CategoryDaoImpl;
import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.CategoryRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.GroupCategoryRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserGroupRecord;
import com.newvery.utils.TimeUtil;

public class UserGroupInsertTask extends UserTask{

	private UserGroupRecord userGroup;
	
	private long[] favoriteIds;
	
	private long[] categoryIds;
	
	@Override
	public Object exec() throws ServiceException {
		
		Date vipDate = TimeUtil.getFutrueDate(new Date(), getUserGroup().getLastVipDays());
		getUserGroup().setVipValidateDate(vipDate);
		
		userGroup = getUserDao().insertUserGroup(getUserGroup());
		
		
		//添加新的权限收藏夹
		if(favoriteIds != null && favoriteIds.length > 0) {
			for(long fid : favoriteIds) {
				UserFavoriteRecord userFavorite = new UserFavoriteRecord();
				
				if(fid > 0) {
					FavoriteRecord f = getFavoriteDao().findFavoriteRecordByPK(fid);
					if(f.getParentId() > 0) {
						userFavorite.setUserGroupId(userGroup.getId());
						userFavorite.setUserId(-1);
						userFavorite.setChildFavoriteId(fid);
						userFavorite.setParentFavoriteId(f.getParentId());
						userFavorite.setDeleted(false);
						userFavorite.setCreateTime(new Date());
						userFavorite = getFavoriteDao().insertUserFavorite(userFavorite);
					}
				}
				
			}
		}
		
		if(categoryIds != null && categoryIds.length > 0) {
			for (long  cid : categoryIds) {
				if(cid > 0) {
					CategoryRecord c = getCategoryDao().findCategoryRecordByPK(cid);
					if(c.getParentId() > 0) {
						GroupCategoryRecord gc = new GroupCategoryRecord();
						gc.setCategoryId(cid);
						gc.setParentCategoryId(c.getParentId());
						gc.setUserGroupId(userGroup.getId());
						getCategoryDao().insertGroupCategory(gc);
					}
				}
			}
		}
		
		return userGroup;
	}
	
	public IFavoriteDao getFavoriteDao() {
		return (IFavoriteDao) getDaoManagerFactory().getManagerImpl(FavoriteDaoImpl.class);
	}
	
	public ICategoryDao getCategoryDao() {
		return (ICategoryDao) getDaoManagerFactory().getManagerImpl(CategoryDaoImpl.class);
	}


	public UserGroupRecord getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroupRecord userGroup) {
		this.userGroup = userGroup;
	}


	public long[] getFavoriteIds() {
		return favoriteIds;
	}


	public void setFavoriteIds(long[] favoriteIds) {
		this.favoriteIds = favoriteIds;
	}

	public long[] getCategoryIds() {
		return categoryIds;
	}

	public void setCategoryIds(long[] categoryIds) {
		this.categoryIds = categoryIds;
	}

}
