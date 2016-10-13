package com.newvery.task.um;

import java.util.HashMap;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.AdminRole;
import com.newvery.record.UserGroupRecord;
import com.newvery.record.UserRecord;
import com.newvery.utils.StringUtil;

public class UserUpdateTask extends UserTask {
	private UserRecord user;
	private long roleId;
	
	
	private long changeGroupUserId;
	
	@Override
	public Object exec() throws ServiceException {
		UserRecord u = getUserDao().findUserById(user.getId());
		u = getUserDao().findUserById(user.getId());
		
		u.setUserName(user.getUserName());
		u.setPassword(user.getPassword());
		u.setEmail(user.getEmail());
		u.setRealName(user.getRealName());
		u.setUserGroup(user.getUserGroup());
		u.setGroupAdmin(user.isGroupAdmin());
		
		if(StringUtil.isNull(user.getIcon()) != null) {
			u.setIcon(user.getIcon());
		}
		
		getUserDao().updateUser(u);
		
		
		getPermissionDao().deleteRoleByUserId(user.getId());
		
		// 权限
		AdminRole ar = new AdminRole();
		ar.setAdmin_id(user.getId());
		ar.setRole_id(roleId);
		getPermissionDao().insertAdminRole(ar);
		
		
		//更新为组管理员
		if(user.isGroupAdmin()) {
			UserGroupRecord ug = getUserDao().findUserGroupById(user.getUserGroup().getId());
			if(ug.getGroupAdminUserId() != user.getId()) {
				Map query = new HashMap();
				query.put("groupAdminUserId", user.getId());
				query.put("id", user.getUserGroup().getId());
				getUserDao().updateGroupAdminUserId(query);
				
				
				UserRecord changeUser = getUserDao().findUserById(ug.getGroupAdminUserId());
				if(changeUser != null) {
					changeUser.setGroupAdmin(false);
					getUserDao().updateUser(changeUser);
				}
				
			}
		} else {
			
			Map query = new HashMap();
			query.put("groupAdminUserId", changeGroupUserId);
			query.put("id", user.getUserGroup().getId());
			getUserDao().updateGroupAdminUserId(query);
			
			UserRecord changeUser = getUserDao().findUserById(changeGroupUserId);
			if(changeUser != null) {
				changeUser.setGroupAdmin(true);
				getUserDao().updateUser(changeUser);
			}
		}
		
		return user;
	}

	public UserRecord getUser() {
		return user;
	}

	public void setUser(UserRecord user) {
		this.user = user;
	}

	public long getRoleId() {
		return roleId;
	}

	public void setRoleId(long roleId) {
		this.roleId = roleId;
	}

	public long getChangeGroupUserId() {
		return changeGroupUserId;
	}

	public void setChangeGroupUserId(long changeGroupUserId) {
		this.changeGroupUserId = changeGroupUserId;
	}
}
