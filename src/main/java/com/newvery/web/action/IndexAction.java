package com.newvery.web.action;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.dal.dao.queryCondition.impl.QueryConditionDeleteTask;
import com.newvery.dal.dao.queryCondition.impl.QueryConditionInsertTask;
import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;
import com.newvery.record.ArticleRecord;
import com.newvery.record.CategoryRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.QueryConditionRecord;
import com.newvery.record.TagRecord;
import com.newvery.record.UserCategoryRecord;
import com.newvery.record.UserRecord;
import com.newvery.task.article.ArticleBatchDeleteTask;
import com.newvery.task.article.ArticleBatchExportTask;
import com.newvery.task.article.ArticleDeleteTask;
import com.newvery.utils.StringUtil;
import com.newvery.utils.TimeUtil;
import com.newvery.web.bean.Page;
import com.newvery.web.servlet.BaseResponse;

public class IndexAction extends BaseWebAction implements SessionAware {

	private static final long serialVersionUID = 2022519931943099464L;
	private List<ArticleRecord> articleList;
	private ArticleRecord article;
	private Page page = new Page(12);
	private Map<String, String> params = new HashMap<String, String>();
	
	private List<UserRecord> userList;
	private List<TagRecord> tagList;
	private String[] userIds;
	private String beginDate;
	private String endDate;
	
	private List<UserRecord> luryList;
	private List<AnnotateRecord> hotTagList;
	private List<AnnotateRecord> trendTagList;
	private List<FavoriteRecord> childFavoriteList;
	
	private String oderByCondition;
	private String orderById;
	
	private List<QueryConditionRecord> queryConditionList;
	private QueryConditionRecord queryCondition;

	private UserRecord user;
	
	private FavoriteRecord favorite;
	private List<FavoriteRecord> favoriteList;
	
	//导出
    private InputStream pdfStream;  //输出流变量
    private String pdfFileName; //下载文件名
    
    private int displayType;		//显示类型 1：列表   2：网格
    private int userSelectDateType;				//1:当天， 2:昨天，3：前天,4更早（前三天后面的所有）
    private long categoryId;
    
    private String articleIds;
    
    private long[] childCategoryId;
    private long[] parentCategoryId;
    
    private List<TagRecord> leastTagList;
    
    private List<CategoryRecord> fast3CategoryList;					//三个快捷分类
    private List<CategoryRecord> userCategoryList;					//用户可以看到分类
    
    private List<UserCategoryRecord> customerUserCategoryList;
    
	@Override
	public String execute() throws Exception {
		Map query = new HashMap();
		
		if (article != null && article.getStatus() > 0) {
			query.put("status", article.getStatus());
			params.put("article.status", article.getStatus() + "");
		}
		
		if (article != null && article.getUserId() > 0) {
			query.put("userId", article.getUserId());
			params.put("article.userId", article.getUserId() + "");
		}
		
		if (userIds != null && userIds.length > 0) {
			query.put("userIds", userIds);
			params.put("userIds", userIds + "");
		}
		
		if (beginDate != null && !"".equals(beginDate)) {
			query.put("startDate", beginDate);
			params.put("beginDate", beginDate);
		}
		
		if (endDate != null && !"".equals(endDate)) {
			query.put("endDate", endDate);
			params.put("endDate", endDate);
		}
		
		if (article != null && article.getParentCategoryId() > 0) {
			query.put("parentCategoryId", article.getParentCategoryId());
			params.put("article.parentCategoryId", article.getParentCategoryId() + "");
		}
		if(article != null && StringUtil.isNull(article.getTitle()) != null) {
			query.put("title", article.getTitle().trim());
			params.put("article.title", article.getTitle().trim());
		}
		
		if (article != null && article.getChildCategoryId() > 0) {
			query.put("childCategoryId", article.getChildCategoryId());
			params.put("article.childCategoryId", article.getChildCategoryId() + "");
		}
		
		if (oderByCondition != null && !"".equals(oderByCondition)) {
			query.put("orderBy", oderByCondition);
			params.put("oderByCondition", oderByCondition);
		}
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
			
			params.put("orderById", orderById);
			params.put("oderByCondition", oderByCondition);
		}
			
		//query.put("userId", getCurrentUser().getId());
		int count = BeanFactory.getArticleDao().countArticleByPage(query);
		getSession().put(Constants.LIST_ARTICLE_QUERY_SESSION, query);
		if (count > 0) {
			page.setTotalNum(count);
			articleList = BeanFactory.getArticleDao().findArticleByPage(query, page);
			for (ArticleRecord ar : articleList) {
				ar.setHot3TagList(BeanFactory.getArticleDao().findLast3BuyArticle(ar.getId()));
			}
		}
		
		// 查询列表的录入员用户
		userList = BeanFactory.getUserDao().findUserByRoleId(Constants.ROLE_LURUYUAN);
		tagList = BeanFactory.getTagDao().findTagRecordByUserIdAndStatus(getCurrentUser().getId(), Constants.TAG_STATUS_NEW);
		
		// 右侧录入员列表
		luryList = BeanFactory.getUserDao().findRecentLuryByNum(3);
		
		hotTagList = BeanFactory.getAnnotateDao().listTodayAnnotate(getCurrentUser().getId(), Constants.ANNOTATE_TYPE_HOT_TAG);
		trendTagList = BeanFactory.getAnnotateDao().listTodayAnnotate(getCurrentUser().getId(), Constants.ANNOTATE_TYPE_TREND_TAG);
		
		Map q = new HashMap();
		q.put("userId", getCurrentUser().getId());
		childFavoriteList = BeanFactory.getFavoriteDao().findFavoriteByPage(q, new Page(5));
		
		queryConditionList = BeanFactory.getQueryConditionDao().findQueryCondition(getCurrentUser().getId(), Constants.QUERY_CONDITION_INDEX);
		return super.execute();
	}
	
	/**
	 * 普通用户的首页
	 * @return
	 * @throws Exception
	 */
	private long tagId;
	public String userIndex() throws Exception {
		favoriteList = BeanFactory.getFavoriteDao().findFavoriteByCommonUserId(getCurrentUser().getId());
		//if (favoriteList == null || favoriteList.size() == 0) {
		//	return SUCCESS;
		//}
		
		//if (favorite == null || favorite.getId() == 0) {
		//	favorite = favoriteList.get(0);
		//}
		
		//if ("".equals(favorite.getName())) {
		//	favorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(favorite.getId());
		//}
		
		Map query = new HashMap();
		
		
		
		//if (favorite != null && favorite.getId() > 0) {
		
		if(StringUtil.isNull(beginDate) == null || StringUtil.isNull(endDate) == null) {
			switch(userSelectDateType) {
			case 1:
				userSelectDateType = 1;
				beginDate = TimeUtil.format(new Date(), TimeUtil.FORMAT_DATE_ONLY);
				break;
			case 2:
				beginDate = TimeUtil.format(TimeUtil.getFutrueDate(new Date(), -1), TimeUtil.FORMAT_DATE_ONLY);
				endDate = beginDate;
				break;
			case 3:
				beginDate = TimeUtil.format(TimeUtil.getFutrueDate(new Date(), -2), TimeUtil.FORMAT_DATE_ONLY);
				endDate = beginDate;
				break;
			case 4:
				endDate = TimeUtil.format(TimeUtil.getFutrueDate(new Date(), -3), TimeUtil.FORMAT_DATE_ONLY);
				break;
			default:
				//userSelectDateType = 4;
				//endDate = TimeUtil.format(TimeUtil.getFutrueDate(new Date(), -3), TimeUtil.FORMAT_DATE_ONLY);
				userSelectDateType = 2;
				beginDate = TimeUtil.format(TimeUtil.getFutrueDate(new Date(), -1), TimeUtil.FORMAT_DATE_ONLY);
				endDate = beginDate;
				break;
			}
			
			query.put("startDate", beginDate);
			query.put("endDate", endDate);
			
		} else {
			userSelectDateType = -1;
			
			if (beginDate != null && !"".equals(beginDate)) {
				query.put("startDate", beginDate);
				params.put("beginDate", String.valueOf(beginDate));
			}
			
			if (endDate != null && !"".equals(endDate)) {
				query.put("endDate", endDate);
				params.put("endDate", String.valueOf(endDate));
			}
		}
		
		if(getTagId() > 0) {
			query.put("tagId", getTagId());
			params.put("tagId", String.valueOf(getTagId()));
		}
		
		List<Long> childCategoryIds = new ArrayList<Long>();
		StringBuffer csb = new StringBuffer();
		boolean firstFlag = false;
		if(childCategoryId != null) {
			for (Long cid : childCategoryId) {
				if(cid > 0) {
					childCategoryIds.add(cid);
					if(!firstFlag) {
						csb.append(cid);
						firstFlag = true;
					} else {
						csb.append("&childCategoryId=").append(cid);
					}
				}
			}
		}
		
		
		List<Long> parentCategoryIds = new ArrayList<Long>();
		StringBuffer sb = new StringBuffer();
		firstFlag = false;
		if(parentCategoryId != null) {
			for (Long pid : parentCategoryId) {
				if(pid > 0) {
					parentCategoryIds.add(pid);
					if(!firstFlag) {
						sb.append(pid);
						firstFlag = true;
					} else {
						sb.append("&parentCategoryId=").append(pid);
					}
				}
			}
		}
		
		if(childCategoryIds.size() > 0) {
			query.put("childCategoryIds", childCategoryIds);
			params.put("childCategoryId", csb.toString());
		} 
		if(parentCategoryIds.size() >0 ) {
			if(parentCategoryIds.size() == 1) {
				query.put("parentCategoryId", parentCategoryIds.get(0));
				params.put("parentCategoryId", String.valueOf(parentCategoryIds.get(0)));
			} else {
				query.put("parentCategoryIds", parentCategoryIds);
				params.put("parentCategoryId", sb.toString());
			}
		} else {
			query.put("allowCategoryGroupId", getCurrentUser().getUserGroup().getId());
		}
		
		params.put("userSelectDateType", String.valueOf(userSelectDateType));
		
			
		if (article != null && article.getTitle() != null && !"".equals(article.getTitle())) {
			query.put("title", article.getTitle());
			params.put("title",article.getTitle());
		}
	
		getSession().put(Constants.LIST_ARTICLE_QUERY_SESSION, query);
		int count = BeanFactory.getArticleDao().countFavoriteArticleByPage(query);
		if (count > 0) {
			page.setTotalNum(count);
			articleList = BeanFactory.getArticleDao().findFavoriteArticleByPage(query, page);
			for (ArticleRecord ar : articleList) {
				ar.setHot3TagList(BeanFactory.getArticleDao().findLast3BuyArticle(ar.getId()));
			}
		}
		//}
			
		Map m = new HashMap();
		//m.put("status", Constants.TAG_STATUS_NEW);
		leastTagList = BeanFactory.getTagDao().findTagByPage(m, new Page(0xffffff));	
			
		Map categoryQuery = new HashMap();
		categoryQuery.put("userId", getCurrentUser().getId());
		fast3CategoryList = BeanFactory.getCategoryDao().findCategoryByPage(categoryQuery, new Page(10));
		
		customerUserCategoryList = BeanFactory.getCategoryDao().findUserCategoryRecordByUserId(getCurrentUser().getId());
		if(customerUserCategoryList == null) {
			customerUserCategoryList = new ArrayList<UserCategoryRecord>(1);
		}
		if(customerUserCategoryList.size() == 0) {
			customerUserCategoryList.add(new UserCategoryRecord());
		}
		
		
		for (UserCategoryRecord userCategoryRecord : customerUserCategoryList) {
			userCategoryRecord.setAllowCategoryList(userCategoryList);
		}
		
		categoryQuery = new HashMap();
		categoryQuery.put("userGroupId", getCurrentUser().getUserGroup().getId());
		userCategoryList = BeanFactory.getCategoryDao().findCategoryByPage(categoryQuery, new Page(0xfffff));
		
		
		return SUCCESS;
	}
	
	/**
	 * 保存查询条件
	 * @return
	 * @throws Exception
	 */
	public String savaQuery() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			
			if (article != null && article.getStatus() > 0) {
				queryCondition.setStatus(article.getStatus());
			}
			
			if (article != null && article.getUserId() > 0) {
				queryCondition.setQueryUserId(article.getUserId());
			}
			
			if (beginDate != null && !"".equals(beginDate)) {
				queryCondition.setBeginDate(TimeUtil.parse(beginDate, TimeUtil.FORMAT_DATE_ONLY));
			}
			
			if (endDate != null && !"".equals(endDate)) {
				queryCondition.setEndDate(TimeUtil.parse(endDate, TimeUtil.FORMAT_DATE_ONLY));
			}
			
			if (article != null && article.getParentCategoryId() > 0) {
				queryCondition.setParentCategoryId(article.getParentCategoryId());
			}
			
			if (article != null && article.getChildCategoryId() > 0) {
				queryCondition.setChildCategoryId(article.getChildCategoryId());
			}
			
			queryCondition.setUserId(getCurrentUser().getId());
			queryCondition.setType(Constants.QUERY_CONDITION_INDEX);
			
			QueryConditionInsertTask task = new QueryConditionInsertTask();
			task.setQueryCondition(queryCondition);
			BeanFactory.getSecurityExecutor().exec(task);
			
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 删除查询条件
	 * @return
	 * @throws Exception
	 */
	public String deleteQuery() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			if (queryCondition != null && queryCondition.getId() > 0) {
				QueryConditionDeleteTask task = new QueryConditionDeleteTask();
				task.setQueryCondition(queryCondition);
				
				BeanFactory.getSecurityExecutor().exec(task);
			}
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	public String getQueryString() {
		StringBuffer sb = new StringBuffer("?");
		boolean firstFlag = false;
		for(Map.Entry<String, String> e : params.entrySet()) {
			if(firstFlag) {
				sb.append("&").append(e.getKey()).append("=").append(e.getValue());
			} else {
				sb.append(e.getKey()).append("=").append(e.getValue());
				firstFlag = true;
			}
		}
		return sb.toString();
	}
	
	/**
	 * 批量删除
	 * @return
	 * @throws Exception
	 */
	public String batchDelete() throws Exception {
		String[] articleIds = getRequest().getParameterValues("articleIds");
		if (articleIds != null && articleIds.length > 0) {
			ArticleBatchDeleteTask task = new ArticleBatchDeleteTask();
			task.setArticleIds(articleIds);
			
			BeanFactory.getSecurityExecutor().exec(task);
		}
		
		return SUCCESS;
	}
	
	public String batchDeleteAjax() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			if (articleIds != null && !"".equals(articleIds.trim())) {
				String[] idArry = articleIds.trim().split(",");
				ArticleBatchDeleteTask task = new ArticleBatchDeleteTask();
				task.setArticleIds(idArry);
				
				BeanFactory.getSecurityExecutor().exec(task);
			}
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
	public String batchExport() throws Exception {
		try{
			String artIds = getRequest().getParameter("artIds");
			String[] articleIds = StringUtil.tokenizeToStringArray(artIds, ",");
			if (articleIds != null && articleIds.length > 0) {
				ArticleBatchExportTask task = new ArticleBatchExportTask();
				task.setArticleIds(articleIds);
				
				String zipName = (String) BeanFactory.getSecurityExecutor().exec(task);
				if(zipName!=null){
					// 第七步，将文件存到流中
					pdfStream = ServletActionContext.getServletContext().getResourceAsStream("/upload/pdf/zip/"+zipName);
					pdfFileName = zipName; // 设置下载的文件名
//					log.info("inputFile="+inputFile+";generatorFilePath="+generatorFilePath+";pdfFileName="+pdfFileName);
				}
			}
		}catch(ServiceException ex){
			ex.printStackTrace(); 
		}
		return SUCCESS;
	}
	
	/**
	 * 研究员文章列表
	 * @return
	 * @throws Exception
	 */
	public String listUserArticle() throws Exception {
		Map query = new HashMap();
		if (article != null && article.getTitle() != null && !"".equals(article.getTitle())) {
			query.put("title", article.getTitle());
		}
		
		if (article != null && article.getUserId() > 0) {
			user = BeanFactory.getUserDao().findUserById(article.getUserId());
			query.put("userId", article.getUserId());
		} else {
			query.put("userId", getCurrentUser().getId());
		}
		
		int count = BeanFactory.getArticleDao().countArticleByPage(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			articleList = BeanFactory.getArticleDao().findArticleByPage(query, page);
		}
		return "list";
	}
	
	/**
	 * 删除文章
	 * @return
	 * @throws Exception
	 */
	public String deleteArticle() throws Exception {
		BaseResponse result = new BaseResponse();
		try  {
			ArticleDeleteTask task = new ArticleDeleteTask();
			task.setArticle(article);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	public String main() throws Exception {
		return super.execute();
	}
	
	public String mainLuru() throws Exception {
		return super.execute();
	}

	public List<ArticleRecord> getArticleList() {
		return articleList;
	}

	public void setArticleList(List<ArticleRecord> articleList) {
		this.articleList = articleList;
	}

	public ArticleRecord getArticle() {
		return article;
	}

	public void setArticle(ArticleRecord article) {
		this.article = article;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public List<UserRecord> getUserList() {
		return userList;
	}

	public void setUserList(List<UserRecord> userList) {
		this.userList = userList;
	}

	public String[] getUserIds() {
		return userIds;
	}

	public void setUserIds(String[] userIds) {
		this.userIds = userIds;
	}

	public String getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(String beginDate) {
		this.beginDate = beginDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public List<TagRecord> getTagList() {
		return tagList;
	}

	public void setTagList(List<TagRecord> tagList) {
		this.tagList = tagList;
	}

	public List<UserRecord> getLuryList() {
		return luryList;
	}

	public void setLuryList(List<UserRecord> luryList) {
		this.luryList = luryList;
	}

	public List<AnnotateRecord> getHotTagList() {
		return hotTagList;
	}

	public void setHotTagList(List<AnnotateRecord> hotTagList) {
		this.hotTagList = hotTagList;
	}

	public List<FavoriteRecord> getChildFavoriteList() {
		return childFavoriteList;
	}

	public void setChildFavoriteList(List<FavoriteRecord> childFavoriteList) {
		this.childFavoriteList = childFavoriteList;
	}

	public List<AnnotateRecord> getTrendTagList() {
		return trendTagList;
	}

	public void setTrendTagList(List<AnnotateRecord> trendTagList) {
		this.trendTagList = trendTagList;
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

	public UserRecord getUser() {
		return user;
	}

	public void setUser(UserRecord user) {
		this.user = user;
	}

	public QueryConditionRecord getQueryCondition() {
		return queryCondition;
	}

	public void setQueryCondition(QueryConditionRecord queryCondition) {
		this.queryCondition = queryCondition;
	}

	public List<QueryConditionRecord> getQueryConditionList() {
		return queryConditionList;
	}

	public void setQueryConditionList(List<QueryConditionRecord> queryConditionList) {
		this.queryConditionList = queryConditionList;
	}

	public FavoriteRecord getFavorite() {
		return favorite;
	}

	public void setFavorite(FavoriteRecord favorite) {
		this.favorite = favorite;
	}

	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}

	public InputStream getPdfStream() {
		return pdfStream;
	}

	public void setPdfStream(InputStream pdfStream) {
		this.pdfStream = pdfStream;
	}

	public String getPdfFileName() {
		return pdfFileName;
	}

	public void setPdfFileName(String pdfFileName) {
		this.pdfFileName = pdfFileName;
	}

	public int getDisplayType() {
		return displayType;
	}

	public void setDisplayType(int displayType) {
		this.displayType = displayType;
	}

	public String getArticleIds() {
		return articleIds;
	}

	public void setArticleIds(String articleIds) {
		this.articleIds = articleIds;
	}

	public Map<String, String> getParams() {
		return params;
	}

	public void setParams(Map<String, String> params) {
		this.params = params;
	}

	public List<TagRecord> getLeastTagList() {
		return leastTagList;
	}

	public void setLeastTagList(List<TagRecord> leastTagList) {
		this.leastTagList = leastTagList;
	}

	public List<CategoryRecord> getFast3CategoryList() {
		return fast3CategoryList;
	}

	public void setFast3CategoryList(List<CategoryRecord> fast3CategoryList) {
		this.fast3CategoryList = fast3CategoryList;
	}

	public int getUserSelectDateType() {
		return userSelectDateType;
	}

	public void setUserSelectDateType(int userSelectDateType) {
		this.userSelectDateType = userSelectDateType;
	}

	public List<CategoryRecord> getUserCategoryList() {
		return userCategoryList;
	}

	public void setUserCategoryList(List<CategoryRecord> userCategoryList) {
		this.userCategoryList = userCategoryList;
	}

	public List<UserCategoryRecord> getCustomerUserCategoryList() {
		return customerUserCategoryList;
	}

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public long[] getChildCategoryId() {
		return childCategoryId;
	}

	public void setChildCategoryId(long[] childCategoryId) {
		this.childCategoryId = childCategoryId;
	}

	public long[] getParentCategoryId() {
		return parentCategoryId;
	}

	public void setParentCategoryId(long[] parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}

	public long getTagId() {
		return tagId;
	}

	public void setTagId(long tagId) {
		this.tagId = tagId;
	}

}
