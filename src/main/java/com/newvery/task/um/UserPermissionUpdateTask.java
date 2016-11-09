package com.newvery.task.um;

import java.util.Date;
import java.util.List;

import com.newvery.dal.dao.favorite.IFavoriteDao;
import com.newvery.dal.dao.favorite.impl.FavoriteDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.AdminRole;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserGroupRecord;
import com.newvery.record.UserRecord;

public class UserPermissionUpdateTask extends UserTask {
	private long roleId;
	private int vipAddDays;
	
	private UserRecord user;
	
	private long[] favoriteIds;

	@Override
	public Object exec() throws ServiceException {
		if (user != null && user.getId() > 0) {
			user = getUserDao().findUserById(user.getId());
			
			user.setVipDates(user.getVipDates() + vipAddDays);
			user.setModifyTime(new Date());
			if(user.getUserGroup() == null) {
				user.setUserGroup(new UserGroupRecord());
			}
 			getUserDao().updateUser(user);
			
			if (roleId != user.getRole().getId()) {		// 权限修改
				AdminRole ar = getPermissionDao().findAdminRoleByAdmin(user.getId());
				getPermissionDao().deleteAdminRole(user.getId());
				
				ar = new AdminRole();
				ar.setAdmin_id(user.getId());
				ar.setRole_id(roleId);
				ar.setCreateTime(new Date());
				getPermissionDao().insertAdminRole(ar);
			}
			
			
			//删除用户现有的权限收藏夹
			List<UserFavoriteRecord> ufList = getFavoriteDao().findUserFavoriteByUserId(user.getId());
			for (UserFavoriteRecord uf : ufList) {
				getFavoriteDao().deleteUserFavorite(uf.getId());
			}
			
			//添加新的权限收藏夹
			if(favoriteIds != null && favoriteIds.length > 0) {
				for(long fid : favoriteIds) {
					UserFavoriteRecord userFavorite = new UserFavoriteRecord();
					
					FavoriteRecord f = getFavoriteDao().findFavoriteRecordByPK(fid);
					
					userFavorite.setUserId(user.getId());
					userFavorite.setChildFavoriteId(fid);
					userFavorite.setParentFavoriteId(f.getParentId());
					userFavorite.setDeleted(false);
					userFavorite.setCreateTime(new Date());
					userFavorite = getFavoriteDao().insertUserFavorite(userFavorite);
				}
			}
			
		}
		return null;
	}
	
	public IFavoriteDao getFavoriteDao() {
		return (IFavoriteDao) getDaoManagerFactory().getManagerImpl(FavoriteDaoImpl.class);
	}

	public long getRoleId() {
		return roleId;
	}

	public void setRoleId(long roleId) {
		this.roleId = roleId;
	}

	public int getVipAddDays() {
		return vipAddDays;
	}

	public void setVipAddDays(int vipAddDays) {
		this.vipAddDays = vipAddDays;
	}

	public UserRecord getUser() {
		return user;
	}

	public void setUser(UserRecord user) {
		this.user = user;
	}

	public long[] getFavoriteIds() {
		return favoriteIds;
	}

	public void setFavoriteIds(long[] favoriteIds) {
		this.favoriteIds = favoriteIds;
	}
}
