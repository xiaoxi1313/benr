package com.newvery.task.um;

import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.newvery.bean.BeanFactory;
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
import com.newvery.web.bean.Page;

public class UserGroupUpdateTask extends UserTask{

	private UserGroupRecord userGroup;
	
	private long[] favoriteIds;
	
	private long[] categoryIds;
	
	private long[] parentCategoryIds;
	
	@Override
	public Object exec() throws ServiceException {
		
		UserGroupRecord t = getUserDao().findUserGroupById(getUserGroup().getId());
		
		Date vipDate = TimeUtil.getFutrueDate(t.getVipValidateDate(), getUserGroup().getLastVipDays());
		getUserGroup().setVipValidateDate(vipDate);
		
		userGroup = getUserDao().updateUserGroup(getUserGroup());
		
		
		//删除用户现有的权限收藏夹
		List<UserFavoriteRecord> ufList = getFavoriteDao().findUserFavoriteByGroupId(userGroup.getId());
		for (UserFavoriteRecord uf : ufList) {
			getFavoriteDao().deleteUserFavorite(uf.getId());
		}
		
		//添加新的权限收藏夹
		if(favoriteIds != null && favoriteIds.length > 0) {
			for(long fid : favoriteIds) {
				UserFavoriteRecord userFavorite = new UserFavoriteRecord();
				
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
		
		
		/*删除现有记录
		 * Map query = new HashMap();
		query.put("userGroupId", userGroup.getId());
		List<CategoryRecord> categoryList = BeanFactory.getCategoryDao().findCategoryByPage(query, new Page(0xffffff));
		for (CategoryRecord categoryRecord : categoryList) {
			GroupCategoryRecord groupCategory = new GroupCategoryRecord();
			groupCategory.setCategoryId(categoryRecord.getId());
			groupCategory.setUserGroupId(userGroup.getId());
			getCategoryDao().deleteGroupCategory(groupCategory);
		}*/
		
		GroupCategoryRecord groupCategory = new GroupCategoryRecord();
		groupCategory.setUserGroupId(userGroup.getId());
		getCategoryDao().deleteGroupCategory(groupCategory);
		
		
		if(categoryIds == null || parentCategoryIds == null) {
			throw new ServiceException(-5,"传递的参数有误：分类未添加");
		}
		
		//将新的分类加入当前记录中
		if(categoryIds.length != parentCategoryIds.length) {
			throw new ServiceException(-5,"传递的参数有误：子分类与父分类数量不一致");
		}
		
		
		Set<String> insertCts = new HashSet<String>();
		for(int i = 0; i < categoryIds.length ; i ++ ) {
			long  cid = categoryIds[i];
			long  pcid = parentCategoryIds[i];
			GroupCategoryRecord gc = new GroupCategoryRecord();
			gc.setParentCategoryId(pcid);
			gc.setCategoryId(cid);
			if(cid > 0) {
				CategoryRecord c = getCategoryDao().findCategoryRecordByPK(cid);
				if(c.getParentId() != pcid) {
					throw new ServiceException(-5,"传递的参数有误:对应的父结点值有误");
				}
				gc.setCategoryId(cid);
			} 
			gc.setUserGroupId(userGroup.getId());
			
			String ctskey = gc.getParentCategoryId() + "_" + gc.getCategoryId();
			if(!insertCts.contains(ctskey)) {
				insertCts.add(ctskey);
				getCategoryDao().insertGroupCategory(gc);
			} 
			
			
		}
		
		/*
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
		}*/
		
		
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

	public long[] getParentCategoryIds() {
		return parentCategoryIds;
	}

	public void setParentCategoryIds(long[] parentCategoryIds) {
		this.parentCategoryIds = parentCategoryIds;
	}

}
