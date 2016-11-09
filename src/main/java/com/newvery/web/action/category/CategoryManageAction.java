package com.newvery.web.action.category;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.AssignCategoryRecord;
import com.newvery.record.CategoryRecord;
import com.newvery.task.category.CategoryBatchDeleteTask;
import com.newvery.task.category.CategoryDeleteTask;
import com.newvery.task.category.CategoryInsertTask;
import com.newvery.task.category.CategoryUpdateTask;
import com.newvery.task.category.UserCategoryUpdateTask;
import com.newvery.utils.StringUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.servlet.BaseResponse;

public class CategoryManageAction extends BaseWebAction {

	private static final long serialVersionUID = -270846269277643670L;
	private List<CategoryRecord> parentList = new ArrayList<CategoryRecord>();
	private List<CategoryRecord> childList = new ArrayList<CategoryRecord>();
	private CategoryRecord category;
	private CategoryRecord parent;
	private Page page = new Page();
	private long parentId;
	private int showType = 0;
	
	private String oderByCondition;
	private String orderById;
	
	private Map<String, String> params = new HashMap<String, String>();
	
	private Map<String, List<CategoryRecord>> gridCategroyMap;

	public String manage() throws Exception {
		Map query = new HashMap();
		query.put("isParent", 1);
		if (category != null && category.getName() != null && !"".equals(category.getName())) {
			query.put("name", category.getName());
			params.put("name", category.getName());
		}
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
			
			params.put("orderById", orderById);
			params.put("oderByCondition", oderByCondition);
		}
		
		int count = BeanFactory.getCategoryDao().countParentCategoryByPage(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			
			
			//按照表格格式进行数据整理
			if(getShowType() == 1) {
				page.setNumPerPage(0xffffff);
				parentList = BeanFactory.getCategoryDao().findParentCategoryByPage(query, page);
				gridCategroyMap = new HashMap<String, List<CategoryRecord>>();
				
				for (CategoryRecord c : parentList) {
					c.setChildren(BeanFactory.getCategoryDao().findCategoryByParentId(c.getId()));
					if(StringUtil.isNull(c.getTagName()) == null) {
						c.setTagName("未分组");
					}
					if(gridCategroyMap.get(c.getTagName()) == null) {
						gridCategroyMap.put(c.getTagName(), new ArrayList<CategoryRecord>());
					} 
					gridCategroyMap.get(c.getTagName()).add(c);
				}
			} else {
				parentList = BeanFactory.getCategoryDao().findParentCategoryByPage(query, page);
			}
		}
		
		if(getShowType() == 1) {
			return "manage_grid";
		} 
		return "manage";
	}
	
	
	public String assigncategory () throws Exception {
		
		int count = BeanFactory.getUserDao().countUserAssignCategory(getCurrentUser().getId());
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			
			/*if(getShowType() == 1) {
				page.setNumPerPage(0xffffff);
				
				parentList = new ArrayList<CategoryRecord>();
				List<AssignCategoryRecord> assignCategoryList = BeanFactory.getUserDao().findUserAssignCategoryByPage(getCurrentUser().getId(), page);
				for (AssignCategoryRecord assignCategoryRecord : assignCategoryList) {
					parentList.add(assignCategoryRecord.getCategory());
				}
				
			} */
			
			parentList = new ArrayList<CategoryRecord>();
			List<AssignCategoryRecord> assignCategoryList = BeanFactory.getUserDao().findUserAssignCategoryByPage(getCurrentUser().getId(), page);
			for (AssignCategoryRecord assignCategoryRecord : assignCategoryList) {
				parentList.add(assignCategoryRecord.getCategory());
			}
		}
		
		if(getShowType() == 1) {
			return "manage_grid";
		} 
		return "manage";
	}
	
	public String saveParent() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			category.setParentId(0);
			CategoryInsertTask task = new CategoryInsertTask();
			task.setCategory(category);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String getChildren() throws Exception {
		if (parentId > 0) {
			parent = BeanFactory.getCategoryDao().findCategoryRecordByPK(parentId);
			Map query = new HashMap();
			query.put("parentId", parentId);
			
			params.put("parentId", String.valueOf(parentId));
			if (category != null && category.getName() != null && !"".equals(category.getName())) {
				query.put("name", category.getName());
				
				params.put("name", category.getName());
			}
			
			int count = BeanFactory.getCategoryDao().countCategoryByPage(query);
			if (count > 0) {
				page.setNumPerPage(Constants.USER_PAGE_SIZE);
				page.setTotalNum(count);
				childList = BeanFactory.getCategoryDao().findCategoryByPage(query, page);
			}
		}
		return "children";
	}
	
	public String saveChild() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			category.setParentId(parentId);
			CategoryInsertTask task = new CategoryInsertTask();
			task.setCategory(category);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String delete() throws Exception {
		CategoryDeleteTask task = new CategoryDeleteTask();
		task.setCategory(category);
		
		BeanFactory.getSecurityExecutor().exec(task);
		return "list";
	}
	
	/**
	 * 批量删除
	 * @return
	 * @throws Exception
	 */
	public String batchDelete() throws Exception {
		String[] categoryIds = getRequest().getParameterValues("categoryIds");
		if (categoryIds != null && categoryIds.length > 0) {
			CategoryBatchDeleteTask task = new CategoryBatchDeleteTask();
			task.setCategoryIds(categoryIds);
			
			BeanFactory.getSecurityExecutor().exec(task);
		}
		if (category != null && category.getParentId() > 0) {
			return "getChildren";
		}
		return "list";
	}
	
	public String update() throws Exception {
		CategoryUpdateTask task = new CategoryUpdateTask();
		task.setCategory(category);
		BeanFactory.getSecurityExecutor().exec(task);
		
		return "list";
	}
	
	public String updateAjax() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			CategoryUpdateTask task = new CategoryUpdateTask();
			task.setCategory(category);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	private long[] cid;
	public String updateUserCategory() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			UserCategoryUpdateTask task = new UserCategoryUpdateTask();
			task.setUserId(getCurrentUser().getId());
			task.setCategoryids(cid);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}

	public CategoryRecord getCategory() {
		return category;
	}

	public void setCategory(CategoryRecord category) {
		this.category = category;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public List<CategoryRecord> getParentList() {
		return parentList;
	}

	public void setParentList(List<CategoryRecord> parentList) {
		this.parentList = parentList;
	}

	public List<CategoryRecord> getChildList() {
		return childList;
	}

	public void setChildList(List<CategoryRecord> childList) {
		this.childList = childList;
	}

	public long getParentId() {
		return parentId;
	}

	public void setParentId(long parentId) {
		this.parentId = parentId;
	}

	public CategoryRecord getParent() {
		return parent;
	}

	public void setParent(CategoryRecord parent) {
		this.parent = parent;
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

	public long[] getCid() {
		return cid;
	}

	public void setCid(long[] cid) {
		this.cid = cid;
	}

	public int getShowType() {
		return showType;
	}

	public void setShowType(int showType) {
		this.showType = showType;
	}

	public Map<String, List<CategoryRecord>> getGridCategroyMap() {
		return gridCategroyMap;
	}

	public Map<String, String> getParams() {
		return params;
	}

	public void setParams(Map<String, String> params) {
		this.params = params;
	}
}