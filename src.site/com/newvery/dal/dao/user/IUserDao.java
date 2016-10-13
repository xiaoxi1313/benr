package com.newvery.dal.dao.user;

import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.AssignCategoryRecord;
import com.newvery.record.UserGroupRecord;
import com.newvery.record.UserLogRecord;
import com.newvery.record.UserRecord;
import com.newvery.web.bean.Page;

public interface IUserDao {
	public UserRecord findUserById(long id) throws ServiceException;

	public UserRecord insertUser(UserRecord user) throws ServiceException; 
	
	public UserRecord findUserByEmail(String email) throws ServiceException; 
	
	public UserRecord findUserByUserName(String userName) throws ServiceException;
	
	public void updateLoginDate(UserRecord user) throws ServiceException;
	
	public void updateForgotPasswordInfo(UserRecord user) throws ServiceException;
	
	public void updateUserName(long userId,String userName) throws ServiceException;
	
	public void updateUserArticleNum(long userId, int articleNum) throws ServiceException;
	
	public void deleteUser(long id) throws ServiceException;
	
	public void batchDeleteUserRecord(Map query) throws ServiceException ;
	
	public int countUserBySearch(Map query) throws ServiceException;
	
	/**
	 * 查询人员总数
	 * @param query
	 * @return
	 * @throws ServiceException
	 */
	public int countUserByPage(Map query) throws ServiceException; 
	
	/**
	 * 查询人员分页数据
	 * @param query
	 * @param page
	 * @return
	 * @throws ServiceException
	 */
	public List<UserRecord> findUserByPage(Map query, Page page) throws ServiceException;
	
	public List<UserRecord> findAllUser() throws ServiceException;
	
	public List<UserRecord> findUserByRoleId(long roleId) throws ServiceException;
	
	/**
	 * 查找最近发过帖子的录入员
	 * @param num ：要查找的数量
	 * @return
	 * @throws ServiceException
	 */
	public List<UserRecord> findRecentLuryByNum(int num) throws ServiceException;
	
	public void updateUser(UserRecord user) throws ServiceException;
	
	/*User Log*/
	public void insertUserLog(UserLogRecord log) throws ServiceException;
	public int countLoginlistByAdminSearch(Map query) throws ServiceException;
	public List<UserLogRecord> findLoginlistByAdminSearch(Map query,Page page) throws ServiceException;
	
	
	
	//=========用户群组概念
	public UserGroupRecord findUserGroupById(long id) throws ServiceException;
	public UserGroupRecord insertUserGroup(UserGroupRecord user) throws ServiceException;
	public UserGroupRecord updateUserGroup(UserGroupRecord user) throws ServiceException; 
	public int countUserGroupByPage(Map query) throws ServiceException; 
	public List<UserGroupRecord> findUserGroupByPage(Map query, Page page) throws ServiceException;
	public void updateGroupAdminUserId(Map query) throws ServiceException;
	public int countGroupMembers(long userGroupId) throws ServiceException;

	public void deleteUserGroup(long userGroupId)throws ServiceException;
	
	//录入员分类设置
	public int countUserAssignCategory(long userId) throws ServiceException;
	public void insertAssignCategory(AssignCategoryRecord assignCategory) throws ServiceException;
	public List<AssignCategoryRecord> findUserAssignCategoryByPage(long userId,Page page) throws ServiceException;
	public void deleteAssignCategoryByUserId(long userId) throws ServiceException;
}
