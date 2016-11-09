package com.newvery.web.action.member;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.AssignCategoryRecord;
import com.newvery.record.CategoryRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.RoleRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserGroupRecord;
import com.newvery.record.UserLogRecord;
import com.newvery.record.UserRecord;
import com.newvery.task.um.UserAssignCategoryTask;
import com.newvery.task.um.UserBatchDeleteTask;
import com.newvery.task.um.UserDeleteTask;
import com.newvery.task.um.UserFavoriteDeleteTask;
import com.newvery.task.um.UserFavoriteInsertTask;
import com.newvery.task.um.UserPermissionUpdateTask;
import com.newvery.task.um.UserRegisterTask;
import com.newvery.task.um.UserUpdateTask;
import com.newvery.utils.FileUtils;
import com.newvery.utils.StringUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.response.CategoryResponse;
import com.newvery.web.response.UserFavoriteResponse;
import com.newvery.web.servlet.BaseResponse;

public class UserManageAction extends BaseWebAction {

	private static final long serialVersionUID = 7287319596224505270L;
	private List<RoleRecord> roleList = new ArrayList<RoleRecord>();
	private List<UserRecord> userList = new ArrayList<UserRecord>();
	private List<UserLogRecord> logList = new ArrayList<UserLogRecord>();
	private Page page = new Page();
	private UserRecord user;
	private long roleId;
	private UserLogRecord userLog;
	
	private int totalUserNum;	//用户总数
	
	private String oderByCondition;
	private String orderById;
	
	private long userId;
	private long parentFavoriteId;
	private long childFavoriteId;
	private UserFavoriteRecord userFavorite = new UserFavoriteRecord();
	private List<UserFavoriteRecord> userFavoriteList;
	
	private List<FavoriteRecord> favoriteList;

	private int vipAddDays;			//会员续期
	
	private File avatar; //上传的文件
    private String avatarFileName; //文件名称
    private String avatarContentType; //文件类型
    
    private int memberType;				//会员类型，0，本然成员，1：用户
    private Map<String, String> params = new HashMap<String, String>();
    
    private List<UserGroupRecord> groupList;
	
	public String list() throws Exception {
		roleList = BeanFactory.getPermissionDao().findRoleRecord();
		
		Map query = new HashMap();
		totalUserNum = BeanFactory.getUserDao().countUserByPage(query);
		if (user != null && !"".equals(user.getUserName())) {
			query.put("userName", user.getUserName());
			params.put("user.userName", user.getUserName());
		}
		if (roleId > 0) {
			query.put("roleId", roleId);
			params.put("roleId", String.valueOf(roleId));
		}
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
		}
		
		int count = BeanFactory.getUserDao().countUserByPage(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			userList = BeanFactory.getUserDao().findUserByPage(query, page);
		}
		
		groupList = BeanFactory.getUserDao().findUserGroupByPage(new HashMap(), new Page(0xffffff));
		
		roleList = BeanFactory.getPermissionDao().findRoleRecord();
		return "list";
	}
	
	public String add() throws Exception {
		roleList = BeanFactory.getPermissionDao().findRoleRecord();
		return "add";
	}
	
	public String save() throws Exception {
		String userFileDir = "/upload/user";
		String realpath = org.apache.struts2.ServletActionContext.getServletContext().getRealPath(userFileDir);
        
        
        String avatarPath = null;
        if (avatar != null) {
        	String fileName = java.util.UUID.randomUUID().toString() + "." + FileUtils.getFileExtension(avatarFileName);
	        avatarPath = userFileDir + "/" + fileName;
        	
        	
            File savefile = new File(new File(realpath), fileName);
            if (!savefile.getParentFile().exists()) {
            	savefile.getParentFile().mkdirs();
            }
            org.apache.commons.io.FileUtils.copyFile(avatar, savefile);
        }
        user.setIcon(avatarPath);
		
		UserRegisterTask task = new UserRegisterTask();
		task.setUser(user);
		task.setRoleId(roleId);
		
		BeanFactory.getSecurityExecutor().exec(task);
		return "save";
	}
	
	
	private long changeGroupUserId;
	/**
	 * 修改
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			String userFileDir = "/upload/user";
			String realpath = org.apache.struts2.ServletActionContext.getServletContext().getRealPath(userFileDir);
	        
	        
	        String avatarPath = null;
	        if (avatar != null) {
	        	String fileName = user.getId() + "." + FileUtils.getFileExtension(avatarFileName);
		        avatarPath = userFileDir + "/" + fileName;
	        	
	        	
	            File savefile = new File(new File(realpath), fileName);
	            if (!savefile.getParentFile().exists()) {
	            	savefile.getParentFile().mkdirs();
	            }
	            org.apache.commons.io.FileUtils.copyFile(avatar, savefile);
	        }
	        user.setIcon(avatarPath);
			UserUpdateTask task = new UserUpdateTask();
			task.setRoleId(roleId);
			task.setUser(user);
			task.setChangeGroupUserId(changeGroupUserId);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 删除用户
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			UserDeleteTask task = new UserDeleteTask();
			task.setUser(user);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 批量删除
	 * @return
	 * @throws Exception
	 */
	public String batchDelete() throws Exception {
		String[] userIds = getRequest().getParameterValues("userIds");
		if (userIds != null && userIds.length > 0) {
			UserBatchDeleteTask task = new UserBatchDeleteTask();
			task.setUserIds(userIds);
			
			BeanFactory.getSecurityExecutor().exec(task);
		}
		
		return "save";
	}
	
	/**
	 * 查看用户登录日志
	 * @return
	 * @throws Exception
	 */
	public String log() throws Exception {
		Map query = new HashMap();
		if (userLog != null && userLog.getUser() != null && userLog.getUser().getUserName() != null && !"".equals(userLog.getUser().getUserName())) {
			query.put("userName", userLog.getUser().getUserName());
		}
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
		}
		
		int count = BeanFactory.getUserDao().countLoginlistByAdminSearch(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			logList = BeanFactory.getUserDao().findLoginlistByAdminSearch(query, page);
		}
		return "log";
	}
	
	private List<CategoryRecord> parentCategoryList;
	
	/**
	 * 查看全部成员
	 * @return
	 * @throws Exception
	 */
	public String allMember() throws Exception {
		//userList = BeanFactory.getUserDao().findAllUser();
		Map query = new HashMap();
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
		}
		
		query.put("memberType", memberType);
		
		page.setNumPerPage(Page.getMaxResult());
		userList = BeanFactory.getUserDao().findUserByPage(query, page);
		
		favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavorite();
		parentCategoryList = BeanFactory.getCategoryDao().findAllParetnCategory();
		return "allMember";
	}
	
	/**
	 * 普通用户获得收藏夹信息
	 * @return
	 * @throws Exception
	 */
	public String getUserFavorite() throws Exception {
		UserFavoriteResponse result =  new UserFavoriteResponse();
		try {
			if (user != null && user.getId() > 0) {
				user = BeanFactory.getUserDao().findUserById(user.getId());
				
				// 显示剩余时间
				user.setVipDates(user.getVipRemains());
				
				result.setUser(user);
				
				userFavoriteList = BeanFactory.getFavoriteDao().findUserFavoriteByUserId(user.getId());
				result.setUserFavoriteList(userFavoriteList);
			}
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	public String getGroupFavorite() throws Exception {
		UserFavoriteResponse result =  new UserFavoriteResponse();
		try {
			userFavoriteList = BeanFactory.getFavoriteDao().findUserFavoriteByGroupId(user.getUserGroup().getId());
			result.setUserFavoriteList(userFavoriteList);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		
		return null;
	}
	
	/**
	 * 保存用户收藏夹权限
	 * @return
	 * @throws Exception
	 */
	public String saveUserFavorite() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			userFavorite = new UserFavoriteRecord();
			userFavorite.setUserId(userId);
			userFavorite.setParentFavoriteId(parentFavoriteId);
			userFavorite.setChildFavoriteId(childFavoriteId);
			
			UserFavoriteInsertTask task = new UserFavoriteInsertTask();
			task.setUserFavorite(userFavorite);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 删除用户收藏夹权限
	 * @return
	 * @throws Exception
	 */
	public String deleteUserFavorite() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			userFavorite = new UserFavoriteRecord();
			userFavorite.setUserId(userId);
			userFavorite.setChildFavoriteId(childFavoriteId);
			
			UserFavoriteDeleteTask task = new UserFavoriteDeleteTask();
			task.setUserFavorite(userFavorite);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 修改用户权限
	 * @return
	 * @throws Exception
	 */
	private long[] fid;
	public String updateUserPermission() throws Exception {
		UserPermissionUpdateTask task = new UserPermissionUpdateTask();
		task.setVipAddDays(vipAddDays);
		task.setUser(user);
		task.setRoleId(roleId);
		task.setFavoriteIds(fid);
		BeanFactory.getSecurityExecutor().exec(task);
		return "allMemberRedirect";
	}
	
	//设置录入员可以管理的分类 
	
	public String getAssignCategory() throws Exception {
		CategoryResponse result = new CategoryResponse();
		
		List<AssignCategoryRecord> assignCategoryList = BeanFactory.getUserDao().findUserAssignCategoryByPage(getUserId(),new Page(0xffffff));
		List<CategoryRecord> categoryList = new ArrayList<CategoryRecord>();
		for (AssignCategoryRecord assignCategoryRecord : assignCategoryList) {
			categoryList.add(assignCategoryRecord.getCategory());
		}
		result.setCategoryList(categoryList);
		ajax(result);
		return null;
	}
	
	private long[] cid;
	public String updateAssignCategory() throws Exception {
		UserAssignCategoryTask task = new UserAssignCategoryTask();
		task.setUserId(getUserId());
		task.setCategoryIds(getCid());
		BeanFactory.getSecurityExecutor().exec(task);
		return "updateAssign";
	}

	public List<RoleRecord> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<RoleRecord> roleList) {
		this.roleList = roleList;
	}

	public List<UserRecord> getUserList() {
		return userList;
	}

	public void setUserList(List<UserRecord> userList) {
		this.userList = userList;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
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

	public List<UserLogRecord> getLogList() {
		return logList;
	}

	public void setLogList(List<UserLogRecord> logList) {
		this.logList = logList;
	}

	public UserLogRecord getUserLog() {
		return userLog;
	}

	public void setUserLog(UserLogRecord userLog) {
		this.userLog = userLog;
	}

	public int getTotalUserNum() {
		return totalUserNum;
	}

	public void setTotalUserNum(int totalUserNum) {
		this.totalUserNum = totalUserNum;
	}

	public String getOderByCondition() {
		return oderByCondition;
	}

	public void setOderByCondition(String oderByCondition) {
		this.oderByCondition = oderByCondition;
	}

	public String getOrderById() {
		return orderById;
	}

	public void setOrderById(String orderById) {
		this.orderById = orderById;
	}

	public List<UserFavoriteRecord> getUserFavoriteList() {
		return userFavoriteList;
	}

	public void setUserFavoriteList(List<UserFavoriteRecord> userFavoriteList) {
		this.userFavoriteList = userFavoriteList;
	}

	public void setUserFavorite(UserFavoriteRecord userFavorite) {
		this.userFavorite = userFavorite;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getParentFavoriteId() {
		return parentFavoriteId;
	}

	public void setParentFavoriteId(long parentFavoriteId) {
		this.parentFavoriteId = parentFavoriteId;
	}

	public long getChildFavoriteId() {
		return childFavoriteId;
	}

	public void setChildFavoriteId(long childFavoriteId) {
		this.childFavoriteId = childFavoriteId;
	}

	public int getVipAddDays() {
		return vipAddDays;
	}

	public void setVipAddDays(int vipAddDays) {
		this.vipAddDays = vipAddDays;
	}

	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}

	public long[] getFid() {
		return fid;
	}

	public void setFid(long[] fid) {
		this.fid = fid;
	}

	public File getAvatar() {
		return avatar;
	}

	public void setAvatar(File avatar) {
		this.avatar = avatar;
	}

	public String getAvatarFileName() {
		return avatarFileName;
	}

	public void setAvatarFileName(String avatarFileName) {
		this.avatarFileName = avatarFileName;
	}

	public String getAvatarContentType() {
		return avatarContentType;
	}

	public void setAvatarContentType(String avatarContentType) {
		this.avatarContentType = avatarContentType;
	}

	public int getMemberType() {
		return memberType;
	}

	public void setMemberType(int memberType) {
		this.memberType = memberType;
	}

	public List<UserGroupRecord> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<UserGroupRecord> groupList) {
		this.groupList = groupList;
	}

	public long getChangeGroupUserId() {
		return changeGroupUserId;
	}

	public void setChangeGroupUserId(long changeGroupUserId) {
		this.changeGroupUserId = changeGroupUserId;
	}

	public Map<String, String> getParams() {
		return params;
	}

	public List<CategoryRecord> getParentCategoryList() {
		return parentCategoryList;
	}

	public void setParentCategoryList(List<CategoryRecord> parentCategoryList) {
		this.parentCategoryList = parentCategoryList;
	}

	public long[] getCid() {
		return cid;
	}

	public void setCid(long[] cid) {
		this.cid = cid;
	}
}
