package com.newvery.dal.dao.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.user.IUserDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.AssignCategoryRecord;
import com.newvery.record.UserGroupRecord;
import com.newvery.record.UserLogRecord;
import com.newvery.record.UserRecord;
import com.newvery.web.bean.Page;

public class UserDaoImpl extends BaseDao implements IUserDao {

	public UserRecord findUserById(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findUserByPK", id);
	}
	
	@Override
	public UserRecord insertUser(UserRecord user) throws ServiceException {
		getSqlTemplate().insert("insertUser",user);
		return user;
	}
	
	@Override
	public int countUserBySearch(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countUserBySearch", query);
	}

	@Override
	public int countUserByPage(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countUserByPage", query);
	}

	@Override
	public List<UserRecord> findUserByPage(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findUserByPage", query);
	}
	
	@Override
	public List<UserRecord> findUserByRoleId(long roleId) throws ServiceException {
		return getSqlTemplate().selectList("listUserByRoleId", roleId);
	}

	
	@Override
	public void updateUserName(long userId, String userName) throws ServiceException {
		Map query = new HashMap();
		query.put("id", userId);
		query.put("userName", userName);
		getSqlTemplate().update("updateUserName", query);
	}
	
	@Override
	public void updateUserArticleNum(long userId, int articleNum) throws ServiceException {
		UserRecord user = new UserRecord();
		user.setId(userId);
		user.setArticleNum(articleNum);
		getSqlTemplate().update("updateArticleNum", user);
	}

	@Override
	public UserRecord findUserByEmail(String email) throws ServiceException {
		return getSqlTemplate().selectOne("findUserByEmail", email);
	}

	@Override
	public UserRecord findUserByUserName(String userName) throws ServiceException {
		return getSqlTemplate().selectOne("findUserByUserName", userName);
	}

	@Override
	public void updateLoginDate(UserRecord user) throws ServiceException {
		getSqlTemplate().update("updateLoginDate", user.getId());
	}
	
	@Override
	public void insertUserLog(UserLogRecord log)throws ServiceException {
		getSqlTemplate().insert("insertUserLogRecord",log);
	}

	@Override
	public int countLoginlistByAdminSearch(Map query)throws ServiceException {
		return getSqlTemplate().selectOne("countLoginlistByAdminSearch", query);
	}

	@Override
	public List<UserLogRecord> findLoginlistByAdminSearch(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findLoginlistByAdminSearch", query);
	}

	@Override
	public void updateForgotPasswordInfo(UserRecord user) throws ServiceException {
		getSqlTemplate().update("updateForgotPasswordInfo", user);
	}
	
	@Override
	public List<UserRecord> findAllUser() throws ServiceException {
		return getSqlTemplate().selectList("listAllUser");
	}
	
	@Override
	public void updateUser(UserRecord user) throws ServiceException {
		getSqlTemplate().update("updateUser", user);
	}

	@Override
	public List<UserRecord> findRecentLuryByNum(int num) throws ServiceException {
		return getSqlTemplate().selectList("listRecentLuruByNum", num);
	}

	@Override
	public void deleteUser(long id) throws ServiceException {
		getSqlTemplate().update("deleteUser", id);
	}

	@Override
	public void batchDeleteUserRecord(Map query) throws ServiceException {
		getSqlTemplate().update("batchDeleteUser", query);
	}
	
	//=========用户群组
	@Override
	public int countUserGroupByPage(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countGroupByPage", query);
	}
	@Override
	public UserGroupRecord findUserGroupById(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findUserGroupByPK", id);
	}
	@Override
	public List<UserGroupRecord> findUserGroupByPage(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findGroupByPage", query);
	}
	
	@Override
	public UserGroupRecord insertUserGroup(UserGroupRecord user) throws ServiceException {
		getSqlTemplate().insert("insertUserGroup", user);
		return user;
	}
	
	@Override
	public UserGroupRecord updateUserGroup(UserGroupRecord user) throws ServiceException {
		getSqlTemplate().update("updateUserGroup", user);
		return user;
	}
	
	@Override
	public void deleteUserGroup(long userGroupId) throws ServiceException {
		getSqlTemplate().delete("deleteUserGroup",userGroupId);
	}
	
	
	@Override
	public void updateGroupAdminUserId(Map query) throws ServiceException {
		getSqlTemplate().update("updateGroupAdminUserId",query);
	}
	
	@Override
	public int countGroupMembers(long userGroupId) throws ServiceException {
		return getSqlTemplate().selectOne("countGroupMembers", userGroupId);
	}
	
	//录入员分类设置
	@Override
	public int countUserAssignCategory(long userId) throws ServiceException {
		return getSqlTemplate().selectOne("countUserAssignCategory", userId);
	}
	
	@Override
	public void deleteAssignCategoryByUserId(long userId) throws ServiceException {
		getSqlTemplate().delete("deleteAssignCategoryByUserId",userId);
	}
	
	@Override
	public List<AssignCategoryRecord> findUserAssignCategoryByPage(long userId,Page page) throws ServiceException {
		Map query = new HashMap();
		query.put("userId", userId);
		query.put("page", page);
		return getSqlTemplate().selectList("findUserAssignCategoryByPage", query);
	}
	
	@Override
	public void insertAssignCategory(AssignCategoryRecord assignCategory) throws ServiceException {
		getSqlTemplate().insert("insertAssignCategory", assignCategory);
	}
}
