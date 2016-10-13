package com.newvery.web.action.tag;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.TagCategoryRecord;
import com.newvery.record.TagRecord;
import com.newvery.task.tag.TagBatchDeleteTask;
import com.newvery.task.tag.TagCategoryDeleteTask;
import com.newvery.task.tag.TagCategoryInsertTask;
import com.newvery.task.tag.TagCategoryUpdateTask;
import com.newvery.task.tag.TagDeleteTask;
import com.newvery.task.tag.TagInsertTask;
import com.newvery.task.tag.TagUpdateTask;
import com.newvery.utils.StringUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.response.TagResponse;
import com.newvery.web.servlet.BaseResponse;

/**
 * 标签管理
 * @author mi_xb
 *
 */
public class TagManageAction extends BaseWebAction {

	private static final long serialVersionUID = -1943272223932755060L;
	private List<TagCategoryRecord> tagCategoryList = new ArrayList<TagCategoryRecord>();
	private List<TagRecord> tagList = new ArrayList<TagRecord>();
	private Page page = new Page();
	private TagRecord tag;
	private TagCategoryRecord tagCategory;
	private long tagCategoryId;
	
	private String oderByCondition;
	private String orderById;
	
	private Map<String, String> params = new HashMap<String, String>();
	
	public String manage() throws Exception {
		tagCategoryList = BeanFactory.getTagDao().findTagCategoryRecord();
		
		if (tagCategoryId == 0) {
			tagCategoryId = -1;
		}
		Map query = new HashMap();
		if (tag != null && tag.getName() != null && !"".equals(tag.getName())) {
			query.put("name", tag.getName());
			params.put("tag.name", tag.getName());
			tagCategoryId = -1;
		}
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
			
			params.put("orderById", orderById);
			params.put("oderByCondition", oderByCondition);
		}
		
		if (tagCategoryId > 0) {
			params.put("tagCategoryId", String.valueOf(tagCategoryId));
			query.put("categoryId", tagCategoryId);
		}
		
		int count = BeanFactory.getTagDao().countTagByPage(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			tagList = BeanFactory.getTagDao().findTagByPage(query, page);
		}
		
		return "manage";
	}
	
	public String list() throws Exception {
		if (tagCategoryId == 0) {
			tagCategoryList = BeanFactory.getTagDao().findTagCategoryRecord();
			TagCategoryRecord tc = tagCategoryList.get(0);
			tagCategoryId = tc.getId();
		}
		Map query = new HashMap();
		if (tag != null && tag.getName() != null && !"".equals(tag.getName())) {
			query.put("name", tag.getName());
			params.put("tag.name", tag.getName());
		}
		query.put("categoryId", tagCategoryId);
		int count = BeanFactory.getTagDao().countTagByPage(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			tagList = BeanFactory.getTagDao().findTagByPage(query, page);
		}
		
		return "list";
	}
	
	public String save() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			tag.setUserId(getCurrentUser().getId());
			
			TagInsertTask task = new TagInsertTask();
			task.setTag(tag);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String delete() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			TagDeleteTask task = new TagDeleteTask();
			task.setTag(tag);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
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
		BaseResponse result = new BaseResponse();
		try {
			String[] tagIds = getRequest().getParameterValues("tagIds");
			TagBatchDeleteTask task = new TagBatchDeleteTask();
			task.setTagIds(tagIds);
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
			TagUpdateTask task = new TagUpdateTask();
			task.setTag(tag);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String saveCategory() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			tagCategory.setUserId(getCurrentUser().getId());
			TagCategoryInsertTask task = new TagCategoryInsertTask();
			task.setTagCategory(tagCategory);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String updateCategory() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			TagCategoryUpdateTask task = new TagCategoryUpdateTask();
			task.setTagCategory(tagCategory);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String deleteCategory() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			TagCategoryDeleteTask task = new TagCategoryDeleteTask();
			task.setTagCategory(tagCategory);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 返回所有标签，供查询
	 * @return
	 * @throws Exception
	 */
	private String q;
	public String listAllTag() throws Exception {
		TagResponse result = new TagResponse();
		try {
			Map query = new HashMap();
			if(StringUtil.isNull(q) != null) {
				query.put("name", q.trim());
			}
			tagList = BeanFactory.getTagDao().findTagByPage(query, new Page(0xffffff));
			result.setTagList(tagList);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}

	public List<TagCategoryRecord> getTagCategoryList() {
		return tagCategoryList;
	}

	public void setTagCategoryList(List<TagCategoryRecord> tagCategoryList) {
		this.tagCategoryList = tagCategoryList;
	}

	public List<TagRecord> getTagList() {
		return tagList;
	}

	public void setTagList(List<TagRecord> tagList) {
		this.tagList = tagList;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public TagRecord getTag() {
		return tag;
	}

	public void setTag(TagRecord tag) {
		this.tag = tag;
	}

	public long getTagCategoryId() {
		return tagCategoryId;
	}

	public void setTagCategoryId(long tagCategoryId) {
		this.tagCategoryId = tagCategoryId;
	}

	public TagCategoryRecord getTagCategory() {
		return tagCategory;
	}

	public void setTagCategory(TagCategoryRecord tagCategory) {
		this.tagCategory = tagCategory;
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

	public Map<String, String> getParams() {
		return params;
	}

	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}
}
