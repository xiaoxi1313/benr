package com.newvery.web.action.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.CategoryRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.GroupCategoryRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserGroupRecord;
import com.newvery.record.UserRecord;
import com.newvery.task.um.UpdateUserVisitFlagTask;
import com.newvery.task.um.UserGroupDeleteTask;
import com.newvery.task.um.UserGroupInsertTask;
import com.newvery.task.um.UserGroupUpdateTask;
import com.newvery.utils.StringUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.response.GroupAdminCheckResponse;
import com.newvery.web.servlet.BaseResponse;

public class UserGroupManageAction extends BaseWebAction {

	private static final long serialVersionUID = 7287319596224505270L;
	
	private Page page = new Page();
	
	private List<UserGroupRecord> userGroupList;
	private String groupName;
	
	private UserGroupRecord userGroup;
	
	private List<FavoriteRecord> favoriteList;
	private List<UserRecord> userList;
	private List<CategoryRecord> categoryList;
	
	public String list() throws Exception {
		
		Map query = new HashMap();
		
		if(StringUtil.isNull(groupName) != null ) {
			query.put("groupName", groupName);
		}
		
		int count = BeanFactory.getUserDao().countUserGroupByPage(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			userGroupList = BeanFactory.getUserDao().findUserGroupByPage(query, page);
			for (UserGroupRecord userGroup : userGroupList) {
				userGroup.setMembers(BeanFactory.getUserDao().countGroupMembers(userGroup.getId()));
			}
		}
		
		favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavorite();
		categoryList = BeanFactory.getCategoryDao().findAllParetnCategory();
		
		return "list";
	}

	
	private void buildquerycategory() throws ServiceException {
		if(getCurrentUser().getRole().getId() == 1 ||getCurrentUser().getRole().getId() == 6) {
			Map q = new HashMap();
			q.put("adminOnly", 1);
			q.put("userId", getCurrentUser().getId());
			favoriteList = BeanFactory.getFavoriteDao().findFavoriteByPage(q, new Page(0xffffff));
		} else if(getCurrentUser().getRole().getId() == 2 ) {
			Map q = new HashMap();
			q.put("userId", getCurrentUser().getId());
			favoriteList = BeanFactory.getFavoriteDao().findFavoriteByPage(q, new Page(0xffffff));
		}
		else {
			favoriteList = new ArrayList<FavoriteRecord>();
			List<UserFavoriteRecord> userFavorites = BeanFactory.getFavoriteDao().findUserFavoriteByGroupId(getCurrentUser().getUserGroup().getId());
			for (UserFavoriteRecord userFavoriteRecord : userFavorites) {
				favoriteList.add(userFavoriteRecord.getParentFavorite());
			}
		}
	}
	
	public String detail() throws Exception {
		
		userGroup = BeanFactory.getUserDao().findUserGroupById(getCurrentUser().getUserGroup().getId());
		userGroup.setMembers(BeanFactory.getUserDao().countGroupMembers(userGroup.getId()));
		return "detail";
		
	}
	
	
	private String orderById;
	private String oderByCondition;
	private int memberType;
	public String members() throws Exception {
		
		Map query = new HashMap();
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
		}
		
		query.put("userGroupId", getCurrentUser().getUserGroup().getId());
		
		if(memberType > 0) {
			query.put("memberType", memberType);
		}
		
		
		page.setNumPerPage(Page.getMaxResult());
		userList = BeanFactory.getUserDao().findUserByPage(query, page);
		return "members";
	}
	
	
	/**
	 * 检查某个用户组下是否存在管理员
	 * @return
	 */
	public String checkGroupAdmin() throws Exception {
		
		GroupAdminCheckResponse result = new GroupAdminCheckResponse();
		try {
			
			Map query = new HashMap();
			query.put("userGroupId", getUserGroupId());
			page.setNumPerPage(Page.getMaxResult());
			userList = BeanFactory.getUserDao().findUserByPage(query, page);
			boolean flag = false;
			long adminUserId = 0;
			for (UserRecord user : userList) {
				if(user.isGroupAdmin()) {
					flag = true;
					adminUserId = user.getId();
					break;
				}
			}
			
			result.setFlag(flag);
			result.setAdminUserId(adminUserId);
			result.setUserList(userList);
			
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}

	private long[] fid;				//收藏夹
	private long[] pcid;			//父目录值
	private long[] cid;				//分类目录
	public String save() throws Exception {
		BaseResponse result = new BaseResponse();
		
		try {
			UserGroupInsertTask task = new UserGroupInsertTask();
			task.setUserGroup(getUserGroup());
			
			task.setFavoriteIds(fid);
			
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		
		return null;
	}
	
	public String update() throws Exception {
		BaseResponse result = new BaseResponse();
		
		try {
			UserGroupUpdateTask task = new UserGroupUpdateTask();
			task.setUserGroup(getUserGroup());
			task.setFavoriteIds(fid);
			task.setCategoryIds(cid);
			task.setParentCategoryIds(pcid);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	private long userGroupId;
	public String delete() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			UserGroupDeleteTask task = new UserGroupDeleteTask();
			task.setUserGroupId(userGroupId);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	
	private boolean visitFloder;
	private boolean visitChart;
	private long userId;
	public String updateUserVisit() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			UpdateUserVisitFlagTask task = new UpdateUserVisitFlagTask();
			task.setUserId(userId);
			task.setVisitChart(visitChart);
			task.setVisitFloder(visitFloder);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	public String getGroupCategory() throws Exception {
		
		List<GroupCategoryRecord> groupCategoryList = BeanFactory.getCategoryDao().findGroupCategory(userGroup.getId());
		
		categoryList = new ArrayList<CategoryRecord>();
		for (GroupCategoryRecord groupCategoryRecord : groupCategoryList) {
			
			CategoryRecord c = new CategoryRecord();
			if(groupCategoryRecord.getCategory() == null || groupCategoryRecord.getCategory().getId() == Constants.ALL_CHILDREN_CATEGORY) {
				c.setName("全部");
			} else {
				c.setName(groupCategoryRecord.getCategory().getName());
			}
			c.setParentCategory(groupCategoryRecord.getParentCategory());
			categoryList.add(c);
		}
		
		ajax(categoryList);
		return null;
		
	}
	
	public Page getPage() {
		return page;
	}


	public void setPage(Page page) {
		this.page = page;
	}


	public List<UserGroupRecord> getUserGroupList() {
		return userGroupList;
	}


	public void setUserGroupList(List<UserGroupRecord> userGroupList) {
		this.userGroupList = userGroupList;
	}


	public String getGroupName() {
		return groupName;
	}


	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}


	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}


	public UserGroupRecord getUserGroup() {
		return userGroup;
	}


	public void setUserGroup(UserGroupRecord userGroup) {
		this.userGroup = userGroup;
	}


	public long getUserGroupId() {
		return userGroupId;
	}


	public void setUserGroupId(long userGroupId) {
		this.userGroupId = userGroupId;
	}


	public long[] getFid() {
		return fid;
	}


	public void setFid(long[] fid) {
		this.fid = fid;
	}


	public List<UserRecord> getUserList() {
		return userList;
	}


	public void setUserList(List<UserRecord> userList) {
		this.userList = userList;
	}


	public String getOrderById() {
		return orderById;
	}


	public void setOrderById(String orderById) {
		this.orderById = orderById;
	}


	public String getOderByCondition() {
		return oderByCondition;
	}


	public void setOderByCondition(String oderByCondition) {
		this.oderByCondition = oderByCondition;
	}


	public int getMemberType() {
		return memberType;
	}


	public void setMemberType(int memberType) {
		this.memberType = memberType;
	}


	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}


	public boolean isVisitFloder() {
		return visitFloder;
	}


	public void setVisitFloder(boolean visitFloder) {
		this.visitFloder = visitFloder;
	}


	public boolean isVisitChart() {
		return visitChart;
	}


	public void setVisitChart(boolean visitChart) {
		this.visitChart = visitChart;
	}


	public long getUserId() {
		return userId;
	}


	public void setUserId(long userId) {
		this.userId = userId;
	}


	public List<CategoryRecord> getCategoryList() {
		return categoryList;
	}


	public void setCategoryList(List<CategoryRecord> categoryList) {
		this.categoryList = categoryList;
	}


	public long[] getCid() {
		return cid;
	}


	public void setCid(long[] cid) {
		this.cid = cid;
	}


	public long[] getPcid() {
		return pcid;
	}


	public void setPcid(long[] pcid) {
		this.pcid = pcid;
	}
	
	
}
