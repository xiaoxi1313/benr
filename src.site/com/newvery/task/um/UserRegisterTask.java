package com.newvery.task.um;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.newvery.dal.dao.article.IArticleDao;
import com.newvery.dal.dao.article.impl.ArticleDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.AdminRole;
import com.newvery.record.UserRecord;

public class UserRegisterTask extends UserTask{

	private UserRecord user;
	private long roleId;
	
	@Override
	public Object exec() throws ServiceException {
		//构建user对象
		user.setArticleNum(0);
		user.setRegisterDate(new Date());
		user.setModifyTime(new Date());
		user.setDeleted(false);
		user.setLocked(false);
		
		user = getUserDao().insertUser(user);
		
		// 权限
		AdminRole ar = new AdminRole();
		ar.setAdmin_id(user.getId());
		ar.setRole_id(roleId);
		ar.setCreateTime(new Date());
		getPermissionDao().insertAdminRole(ar);
		
		
		//更新为组管理员
		if(user.isGroupAdmin()) {
			Map query = new HashMap();
			query.put("groupAdminUserId", user.getId());
			query.put("id", user.getUserGroup().getId());
			getUserDao().updateGroupAdminUserId(query);
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
	
	public IArticleDao getArticleDao() {
		return (IArticleDao) getDaoManagerFactory().getManagerImpl(ArticleDaoImpl.class);
	}
}
