package com.newvery.web.action.article;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.newvery.Constants;
import com.newvery.ErrorCode;
import com.newvery.bean.BeanFactory;
import com.newvery.config.ConfigManager;
import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;
import com.newvery.record.ArticleFavoriteRecord;
import com.newvery.record.ArticleImageRecord;
import com.newvery.record.ArticlePraiseRecord;
import com.newvery.record.ArticleRecord;
import com.newvery.record.CategoryRecord;
import com.newvery.record.CommentRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.TagCategoryRecord;
import com.newvery.record.TagRecord;
import com.newvery.record.UserRecord;
import com.newvery.task.annotate.AnnotateInsertTask;
import com.newvery.task.annotate.AnnotateUpdateTask;
import com.newvery.task.article.ArticleBatchDeleteTask;
import com.newvery.task.article.ArticleBatchPhysicsDeleteTask;
import com.newvery.task.article.ArticleCategoryUpdateTask;
import com.newvery.task.article.ArticleDeleteTask;
import com.newvery.task.article.ArticleFavoriteDeleteTask;
import com.newvery.task.article.ArticleFavoriteTask;
import com.newvery.task.article.ArticleFavoriteUpdateTask;
import com.newvery.task.article.ArticleInsertTask;
import com.newvery.task.article.ArticlePhysicsDeleteTask;
import com.newvery.task.article.ArticlePraiseInsertTask;
import com.newvery.task.article.ArticleRemoveRecycleTask;
import com.newvery.task.article.ArticleStatusUpdateTask;
import com.newvery.task.article.ArticleSummaryUpdateTask;
import com.newvery.task.article.ArticleTagDeleteTask;
import com.newvery.task.article.ArticleTagInsertTask;
import com.newvery.task.article.ArticleUpdateTask;
import com.newvery.task.comment.CommentInsertTask;
import com.newvery.task.tag.TagInsertTask;
import com.newvery.utils.HtmlToPdf;
import com.newvery.utils.StringUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.response.AnnotateResponse;
import com.newvery.web.response.ArticleResponse;
import com.newvery.web.response.CategoryResponse;
import com.newvery.web.response.FavoriteResponse;
import com.newvery.web.response.NextArticleIdResponse;
import com.newvery.web.response.TagResponse;
import com.newvery.web.servlet.BaseResponse;

/**
 * 文章
 * @author mi_xb
 *
 */
public class ArticleAction extends BaseWebAction  implements SessionAware {
	Logger log = Logger.getLogger(ArticleAction.class);
	private static final long serialVersionUID = -881097675367584627L;
	private List<ArticleRecord> articleList;
	private ArticleRecord article;
	private Page page = new Page();
	private List<CategoryRecord> categoryList;
	private List<CategoryRecord> childCategoryList;
	private long parentCategoryId;
	
	private TagRecord tag;
	
	private List<ArticleImageRecord> imgList;
	
	private long parentFavoriteId;
	private List<FavoriteRecord> favoriteList;
	private ArticleFavoriteRecord articleFavorite;
	private List<ArticleFavoriteRecord> userArticleFavoriteList;
	
	private List<CommentRecord> commentList;
	private CommentRecord comment;
	
	private List<TagRecord> tagList = new ArrayList<TagRecord>();
	
	private AnnotateRecord annotate;		//批注
	private AnnotateRecord hotTag;			//热门标签
	private AnnotateRecord trendTag;		//趋势标签
	private List<TagCategoryRecord> tagCategoryList = new ArrayList<TagCategoryRecord>();
	
	private UserRecord user;
	
    private InputStream pdfStream;  //输出流变量
    private String pdfFileName; //下载文件名
    
    private List<ArticleRecord> aboutArticleList;
	
    private String oderByCondition;
	private String orderById;
	
	private int showType;		//显示方式  1：列表   2：网格
	
	private String articleTitle;
	
	private String insertArticleToken;
	
	private long articleId;
	private ArticlePraiseRecord articlePraise;	//点赞
	
	private ArticleRecord nextArticle;			//下一篇
	private ArticleRecord prevArticle;			//上一篇
	
	private Map<String, String> params = new HashMap<String, String>();
	
	/**
	 * 文章列表
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		Map query = new HashMap();
		if (article != null && article.getTitle() != null && !"".equals(article.getTitle())) {
			query.put("title", article.getTitle());
			
			params.put("article.title", article.getTitle());
		}
		
		if (article != null && article.getUserId() > 0) {
			query.put("userId", article.getUserId());
			user = BeanFactory.getUserDao().findUserById(article.getUserId());
			params.put("article.userId", String.valueOf(article.getUserId()));
		} else {
			query.put("userId", getCurrentUser().getId());
		}
		
		if (oderByCondition != null && !"".equals(oderByCondition)) {
			query.put("orderBy", oderByCondition);
			params.put("oderByCondition", oderByCondition);
		}
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
			
			params.put("orderBy", orderById);
			params.put("ascdesc", oderByCondition);
		}
		
		int count = BeanFactory.getArticleDao().countArticleByPage(query);
		if (count > 0) {
			page.setNumPerPage(12);
			page.setTotalNum(count);
			articleList = BeanFactory.getArticleDao().findArticleByPage(query, page);
		}
		return "list";
	}
	
	/**
	 * 文章列表
	 * @return
	 * @throws Exception
	 */
	public String search() throws Exception {
		
		
		
		articleTitle = StringUtil.isNull(articleTitle);
		if (null!=articleTitle) {
			if(null==article){
				article = new ArticleRecord();
			}
			params.put("articleTitle", articleTitle);
			
			if(getCurrentUser().getRole().getId() == 4 || getCurrentUser().getRole().getId() == 5) {
				
				Map userQuery = new HashMap();
				userQuery.put("title", articleTitle);
				userQuery.put("allowCategoryGroupId", getCurrentUser().getUserGroup().getId());
				int count = BeanFactory.getArticleDao().countFavoriteArticleByPage(userQuery);
				if (count > 0) {
					page.setNumPerPage(12);
					page.setTotalNum(count);
					articleList = BeanFactory.getArticleDao().findFavoriteArticleByPage(userQuery, page);
				}
				
			} else {
				Map query = new HashMap();
				article.setTitle(articleTitle);
				query.put("searchTitle", articleTitle);				//带标签名匹配的查询
				
				
				if(getCurrentUser().getRole().getId() != 1 && getCurrentUser().getRole().getId() != 2 && getCurrentUser().getRole().getId() != 6) {
					query.put("userId", getCurrentUser().getId());
				}
				
				int count = BeanFactory.getArticleDao().countArticleByPage(query);
				if (count > 0) {
					page.setNumPerPage(12);
					page.setTotalNum(count);
					articleList = BeanFactory.getArticleDao().findArticleByPage(query, page);
				}
			}
			
		}
		return "search";
	}
	
	public String forTag() throws Exception {
		Map query = new HashMap();
		if(tag != null && tag.getId() > 0) {
			params.put("tag.id", String.valueOf(tag.getId()));
			
			tag = BeanFactory.getTagDao().findTagRecordByPK(tag.getId());
			
			query.put("tagId", tag.getId());
			int count = BeanFactory.getArticleDao().countArticleByConditionForChartDistribution(query);
			if (count > 0) {
				page.setNumPerPage(12);
				page.setTotalNum(count);
				articleList = BeanFactory.getArticleDao().findArticleByConditionForChartDistribution(query,page);
			}
		}
		return "forTag";
	}
	
	public String insert() throws Exception {
		tagCategoryList = BeanFactory.getTagDao().findTagCategoryRecord();
		insertArticleToken = new Date().getTime() + "";
		getSession().put(Constants.INSERT_ARTICLE_TOKEN, insertArticleToken);
		
		return "input";
	}
	
	/**
	 * 预览
	 * @return
	 * @throws Exception
	 */
	public String preview() throws Exception {
		String[] tagIds = getRequest().getParameterValues("tagIds");
		if (tagIds != null && tagIds.length > 0) {
			for (String tagIdStr : tagIds) {
				long tagId = Long.parseLong(tagIdStr);
				TagRecord tag = BeanFactory.getTagDao().findTagRecordByPK(tagId);
				tagList.add(tag);
			}
		}
		return "preview";
	}
	
	public String jumpToNext() throws Exception {
		
		long nextid = BeanFactory.getArticleDao().getNextAritcleId(getArticle().getId());
		
		NextArticleIdResponse res = new NextArticleIdResponse();
		res.setAid(nextid);
		ajax(res);
		
		return null;
	}
	
	/**
	 * 保存新建文章
	 * @return
	 * @throws Exception
	 */
	public String save() throws Exception {
		ArticleResponse result = new ArticleResponse();
		try {
			if (!insertArticleToken.equals(getSession().get(Constants.INSERT_ARTICLE_TOKEN))) {
				throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "重复提交");
			}
			UserRecord user = getCurrentUser();
			article.setUserId(user.getId());
	
			String[] tagIds = getRequest().getParameterValues("tagIds");
			
			ArticleInsertTask task = new ArticleInsertTask();
			task.setTagIds(tagIds);
			task.setArticle(article);
			
			article = (ArticleRecord) BeanFactory.getSecurityExecutor().exec(task);
			result.setArticle(article);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 进入编辑页面
	 * @return
	 * @throws Exception
	 */
	public String edit() throws Exception {
		if (article != null && article.getId() > 0) {
			article = BeanFactory.getArticleDao().findArticleRecordByPK(article.getId());
			tagList = BeanFactory.getTagDao().findAllTagByArticleId(article.getId());
			tagCategoryList = BeanFactory.getTagDao().findTagCategoryRecord();
		}
		
		return "input";
	}
	
	/**
	 * 保存编辑
	 * @return
	 * @throws Exception
	 */
	public String update() throws Exception {
		ArticleResponse result = new ArticleResponse();
		try {
			String[] tagIds = getRequest().getParameterValues("tagIds");
			
			ArticleUpdateTask task = new ArticleUpdateTask();
			task.setArticle(article);
			task.setTagIds(tagIds);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		result.setArticle(article);
		
		ajax(result);
		return null;
	}
	
	/**
	 * 移到回收站
	 * @return
	 * @throws Exception
	 */
	public String delete() throws Exception {
		ArticleDeleteTask task = new ArticleDeleteTask();
		task.setArticle(article);
		
		BeanFactory.getSecurityExecutor().exec(task);
		if (article != null && article.getUserId() > 0) {
			user = BeanFactory.getUserDao().findUserById(article.getUserId());
			return "manageOther"; 
		} 
		return "manage";
	}
	
	/**
	 * 物理删除文章
	 * @return
	 * @throws Exception
	 */
	public String physicsDelete() throws Exception {
		ArticleResponse result = new ArticleResponse();
		try {
			ArticlePhysicsDeleteTask task = new ArticlePhysicsDeleteTask();
			task.setArticle(article);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 移出回收站
	 * @return
	 * @throws Exception
	 */
	public String removeRecycle() throws Exception {
		ArticleResponse result = new ArticleResponse();
		try {
			ArticleRemoveRecycleTask task = new ArticleRemoveRecycleTask();
			task.setArticle(article);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 批量移入回收站
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
		
		if (article != null && article.getUserId() > 0) {
			user = BeanFactory.getUserDao().findUserById(article.getUserId());
			return "manageOther"; 
		} 
		return "manage";
	}
	
	/**
	 * 批量物理删除
	 * @return
	 * @throws Exception
	 */
	public String batchPhysics() throws Exception {
		ArticleResponse result = new ArticleResponse();
		try {
			String[] articleIds = getRequest().getParameterValues("articleIds");
			if (articleIds != null && articleIds.length > 0) {
				ArticleBatchPhysicsDeleteTask task = new ArticleBatchPhysicsDeleteTask();
				task.setArticleIds(articleIds);
				
				BeanFactory.getSecurityExecutor().exec(task);
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 详情
	 * @return
	 * @throws Exception
	 */
	public String show() throws Exception {
		if (article.getId() > 0) {
			article = BeanFactory.getArticleDao().findArticleRecordByPK(article.getId());
			commentList = BeanFactory.getCommentDao().findParentCommentByArticleId(article.getId());
			tagList = BeanFactory.getTagDao().findAllTagByArticleId(article.getId());
			categoryList = BeanFactory.getCategoryDao().findAllParetnCategory();
			childCategoryList = BeanFactory.getCategoryDao().findChildrenByParentId(article.getParentCategoryId()); 
			tagCategoryList = BeanFactory.getTagDao().findTagCategoryRecord();
			Map query = new HashMap();
			query.put("articleId", article.getId());
			query.put("userId", getCurrentUser().getId());
			List<AnnotateRecord> annotateList = BeanFactory.getAnnotateDao().findAnnotateByArticleId(article.getId());
			for (AnnotateRecord a : annotateList) {
				if (a.getType() == Constants.ANNOTATE_TYPE_ANNOTATE) {
					annotate = a;
				}
				else if (a.getType() == Constants.ANNOTATE_TYPE_HOT_TAG) {
					hotTag = a;
				}
				else if (a.getType() == Constants.ANNOTATE_TYPE_TREND_TAG) {
					trendTag = a;
				}
			}
			
			Map sessionQuery = (Map)getSession().get(Constants.LIST_ARTICLE_QUERY_SESSION);
			if(sessionQuery != null) {
				Map requery = new HashMap(sessionQuery);
				requery.put("nextTime", getArticle().getCreateTime());
				//requery.put("nextId", getArticle().getId());
				List<ArticleRecord> temp = BeanFactory.getArticleDao().findArticleByPage(requery, new Page(1));
				if(temp != null && temp.size() > 0) {
					nextArticle = temp.get(0);
				}
			}
			
			if(sessionQuery != null) {
				Map requery = new HashMap(sessionQuery);
				requery.put("prevTime", getArticle().getCreateTime());
				//requery.put("prevId", getArticle().getId());
				List<ArticleRecord> temp = BeanFactory.getArticleDao().findArticleByPage(requery, new Page(1));
				if(temp != null && temp.size() > 0) {
					prevArticle = temp.get(0);
				}
			}
			
			// 是否修改状态
			if (article.getStatus() == Constants.ARTICLE_STATUS_INIT ||
					article.getStatus() == Constants.ARTICLE_STATUS_UNREADED) {
				if (getCurrentUser().getRole().getId() == Constants.ROLE_GAOJIYANJIUYUAN ||
						getCurrentUser().getRole().getId() == Constants.ROLE_YANJIUYUAN) {
					article.setStatus(Constants.ARTICLE_STATUS_READED_UNANNOTATED);
					
					ArticleStatusUpdateTask task = new ArticleStatusUpdateTask();
					task.setArticle(article);
					
					BeanFactory.getSecurityExecutor().exec(task);
				}
			}
			
			Page p = new Page();
			//p.setCurPage(1);
			//p.setNumPerPage(16);
			articleList = BeanFactory.getArticleDao().beforeAfterArticleList(article.getId());
			
			//关联文章
			/*query = new HashMap();
			query.put("id", article.getId());
			p = new Page();
			p.setCurPage(0);
			p.setNumPerPage(3);
			aboutArticleList = BeanFactory.getArticleDao().findAboutArticleByPage(query, p);
			*/
	
			userArticleFavoriteList = BeanFactory.getArticleDao().findArticleFavoriteByUserAndArticle(getCurrentUser().getId(),article.getId());
			
		}
		
		
		
//		if (getCurrentUser().getRole().getId() == Constants.ROLE_GAOJIYONGHU || getCurrentUser().getRole().getId() == Constants.ROLE_PUTONGYONGHU) {
//			return "user_show";
//		}
		return "show";
	}
	
	
	private String groupId;
	/**
	 * Ajax取类别列表
	 * @return
	 * @throws Exception
	 */
	public String getParentCategoryList() throws Exception {
		CategoryResponse result = new CategoryResponse();
		try {
			
			
			if(groupId != null) {
				Map categoryQuery = new HashMap();
				categoryQuery.put("userGroupId", getCurrentUser().getUserGroup().getId());
				categoryList = BeanFactory.getCategoryDao().findCategoryByPage(categoryQuery, new Page(0xfffff));
			} else {
				categoryList = BeanFactory.getCategoryDao().findAllParetnCategory();
			}
			
			
			result.setCategoryList(categoryList);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 根据paretnId获取类别列表
	 * @return
	 * @throws Exception
	 */
	public String getCategoryListByParentId() throws Exception {
		CategoryResponse result = new CategoryResponse();
		try {
			
			
//			if(groupId != null) {
//				Map categoryQuery = new HashMap();
//				categoryQuery.put("userGroupId", getCurrentUser().getUserGroup().getId());
//				categoryQuery.put("parentId", parentCategoryId);
//				categoryList = BeanFactory.getCategoryDao().findCategoryByPage(categoryQuery, new Page(0xfffff));
//				
//			} else {
				if (parentCategoryId > 0) {
					categoryList = BeanFactory.getCategoryDao().findCategoryByParentId(parentCategoryId);
				}
//			}
			result.setCategoryList(categoryList);
			
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 添加标签
	 * @return
	 * @throws Exception
	 */
	public String addTag() throws Exception {
		TagResponse result = new TagResponse();
		try {
			if (tag != null && StringUtil.isNull(tag.getName()) != null) {
				String tagName = StringUtil.isNull(tag.getName().trim());
				if(tagName.endsWith(",")){
					tagName = tagName.substring(0,tagName.length()-1);
					tag.setName(tagName);
				}
				
				TagRecord t = BeanFactory.getTagDao().findTagRecordByName(tag.getName().trim());
				if (t == null) {
					tag.setUserId(getCurrentUser().getId());
					TagInsertTask task = new TagInsertTask();
					task.setTag(tag);
					tag.setAlias(StringUtil.isNull(tag.getAlias())!=null?tag.getAlias():tag.getName());
					tag.setCreateTime(new Date());
					tag.setArticleNum(0);
					tag.setStatus(Constants.TAG_STATUS_NEW);
					t = (TagRecord) BeanFactory.getSecurityExecutor().exec(task);
				} 
				result.setTag(t);
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 添加标签及article关联关系
	 * @return
	 * @throws Exception
	 */
	public String addArticleTag() throws Exception {
		TagResponse result = new TagResponse();
		try {
			if (articleId>0 && tag != null && StringUtil.isNull(tag.getName()) != null) {
				ArticleRecord art = BeanFactory.getArticleDao().findArticleRecordByPK(articleId);
				if(null==art){
					throw new ServiceException(-401,"文章获取失败");
				}
				String tagName = StringUtil.isNull(tag.getName().trim());
				if(tagName.endsWith(",")){
					tagName = tagName.substring(0,tagName.length()-1);
					tag.setName(tagName);
				}
				
				TagRecord t = BeanFactory.getTagDao().findTagRecordByName(tag.getName().trim());
				if (t == null) {
					
					/*if(StringUtil.isNull(tag.getAlias()) ==null ) {
						throw new ServiceException(-401,"请输入标签别名");
					}*/
					if(tag.getCategoryId() == 0) {
						throw new ServiceException(-401,"请选择标签分类");
					}
					
					tag.setUserId(getCurrentUser().getId());
					tag.setCreateTime(new Date());
					tag.setArticleNum(0);
					tag.setStatus(Constants.TAG_STATUS_NEW);
				}else{
					tag = t;
				}
				ArticleTagInsertTask task = new ArticleTagInsertTask();
				task.setArticle(art);
				task.setTag(tag);
				t = (TagRecord) BeanFactory.getSecurityExecutor().exec(task);
				result.setTag(t);
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 添加标签及article关联关系
	 * @return
	 * @throws Exception
	 */
	public String deleteArticleTag() throws Exception {
		TagResponse result = new TagResponse();
		try {
			if (articleId>0 && tag != null && tag.getId()>0) {
				ArticleTagDeleteTask task = new ArticleTagDeleteTask();
				task.setArticleId(articleId);
				task.setTagId(tag.getId());
				BeanFactory.getSecurityExecutor().exec(task);
			}
			result.setErrorCode(1);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * Ajax取一级收藏夹列表
	 * @return
	 * @throws Exception
	 */
	public String getParentFavoriteList() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			favoriteList = BeanFactory.getFavoriteDao().findParentFavoriteByUserId(getCurrentUser().getId());
			result.setFavoriteList(favoriteList);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 根据paretnId获取收藏夹列表
	 * @return
	 * @throws Exception
	 */
	public String getFavoriteListByParentId() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			if (parentFavoriteId > 0) {
				favoriteList = BeanFactory.getFavoriteDao().findFavoriteByParentId(parentFavoriteId);
				result.setFavoriteList(favoriteList);
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 把文章加入收藏夹
	 * @return
	 * @throws Exception
	 */
	public String favorite() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			articleFavorite.setArticleId(article.getId());
			articleFavorite.setUserId(getCurrentUser().getId());
			
			ArticleFavoriteTask task = new ArticleFavoriteTask();
			task.setArticleFavorite(articleFavorite);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 把文章加入收藏夹--编辑
	 * @return
	 * @throws Exception
	 */
	public String favoriteUpdate() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			articleFavorite.setArticleId(article.getId());
			articleFavorite.setUserId(getCurrentUser().getId());
			
			ArticleFavoriteUpdateTask task = new ArticleFavoriteUpdateTask();
			task.setArticleFavorite(articleFavorite);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String deleteAritcleFavorite() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			ArticleFavoriteDeleteTask task = new ArticleFavoriteDeleteTask();
			task.setArticleFavorite(articleFavorite);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 评论、回复评论
	 * @return
	 * @throws Exception
	 */
	public String comment() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			UserRecord user = (UserRecord)ServletActionContext.getRequest().getSession().getAttribute(Constants.LOGIN_MEMBER_SESSION_NAME);
			comment.setUserId(user.getId());
			comment.setArticleId(article.getId());
			
			CommentInsertTask task = new CommentInsertTask();
			task.setComment(comment);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 添加批注
	 * @return
	 * @throws Exception
	 */
	public String annotate() throws Exception {
		AnnotateResponse result = new AnnotateResponse();
		try {
			annotate.setUserId(getCurrentUser().getId());
			
			AnnotateInsertTask task = new AnnotateInsertTask();
			task.setAnnotate(annotate);
			
			annotate = (AnnotateRecord) BeanFactory.getSecurityExecutor().exec(task);
			result.setAnnotate(annotate);
			} catch(ServiceException ex) {
				result.setErrorCode(ex.getErrorCode());
				result.setErrorMessage(ex.getMessage());
			}
		ajax(result);
		return null;
	}
	
	/**
	 * 修改批注
	 * @return
	 * @throws Exception
	 */
	public String annotateUpdate() throws Exception {
		AnnotateResponse result = new AnnotateResponse();
		try {
			AnnotateUpdateTask task = new AnnotateUpdateTask();
			task.setAnnotate(annotate);
			
			annotate = (AnnotateRecord) BeanFactory.getSecurityExecutor().exec(task);
			result.setAnnotate(annotate);
			} catch(ServiceException ex) {
				result.setErrorCode(ex.getErrorCode());
				result.setErrorMessage(ex.getMessage());
			}
		ajax(result);
		return null;
	}
	/**
	 * 文章导出
	 * @return
	 * @throws Exception
	 */
	private String exportTemplate;
	public String export() throws Exception {
		try{
			if (article.getId() > 0) {
				article = BeanFactory.getArticleDao().findArticleRecordByPK(article.getId());
				// 第一步，生成pdf文件
				String inputFile = ConfigManager.getInstance().getHomeUrl()+"articleprint_show.action?article.id="+article.getId() + "&templateName=" + exportTemplate;
				String generatorFilePath = ConfigManager.getInstance().getHomePath()+"upload/pdf/";
				String fileSaveName = article.getId()+".pdf";
				HtmlToPdf.htmlToPdf(inputFile, generatorFilePath, fileSaveName, null, null);
				
				// 第七步，将文件存到流中
				//pdfStream = ServletActionContext.getServletContext().getResourceAsStream("/upload/pdf/"+fileSaveName);
				pdfStream = new FileInputStream(generatorFilePath + fileSaveName);
				
				pdfFileName = article.getTitle()+".pdf"; // 设置下载的文件名
				log.info("inputFile="+inputFile+";generatorFilePath="+generatorFilePath+";pdfFileName="+pdfFileName);
			}
		}catch(Exception ex){
			ex.printStackTrace();
		}
		return SUCCESS;
	}
	
	/**
	 * 修改文章状态
	 * @return
	 * @throws Exception
	 */
	public String changeStatus() throws Exception {
		if (article !=null && article.getId() > 0 && article.getStatus() > 0) {
			ArticleStatusUpdateTask task = new ArticleStatusUpdateTask();
			task.setArticle(article);
			BeanFactory.getSecurityExecutor().exec(task);
		}
		
		if(article.getStatus() == 0) {
			long nextid = BeanFactory.getArticleDao().getNextAritcleId(getArticle().getId());
			if(nextid>0) {
				article.setId(nextid);
			}
			return "jumpTo";
		}
		
		return "index";
	}
	
	/**
	 * 修改文章分类
	 * @return
	 * @throws Exception
	 */
	public String categoryUpdate() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			ArticleCategoryUpdateTask task = new ArticleCategoryUpdateTask();
			task.setArticle(article);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 修改文章摘要
	 * @return
	 * @throws Exception
	 */
	public String updateSummary() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			ArticleSummaryUpdateTask task = new ArticleSummaryUpdateTask();
			task.setArticle(article);
			task.setSummary(article.getSummary());
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 点赞/踩
	 * @return
	 * @throws Exception
	 */
	public String praise() throws Exception {
		ArticleResponse result = new ArticleResponse();
		try {
			articlePraise.setUserId(getCurrentUser().getId());
			
			ArticlePraiseInsertTask task = new ArticlePraiseInsertTask();
			task.setArticlePraise(articlePraise);
			
			BeanFactory.getSecurityExecutor().exec(task);
			
			result.setArticle(BeanFactory.getArticleDao().findArticleRecordByPK(articlePraise.getArticleId()));
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 
	 * 回收站
	 * @return
	 * @throws Exception
	 */
	public String recycle() throws Exception {
		Map query = new HashMap();
		if (article != null && article.getTitle() != null && !"".equals(article.getTitle())) {
			query.put("title", article.getTitle());
			params.put("article.title", article.getTitle());
		}
		
		query.put("deleted", 1);
		
		if (oderByCondition != null && !"".equals(oderByCondition)) {
			query.put("orderBy", oderByCondition);
		}
		
		if(StringUtil.isNull(orderById) != null && StringUtil.isNull(oderByCondition) != null) {
			query.put("orderBy", orderById);
			query.put("ascdesc", oderByCondition);
		}
		
		int count = BeanFactory.getArticleDao().countArticleByPage(query);
		if (count > 0) {
			page.setNumPerPage(12);
			page.setTotalNum(count);
			articleList = BeanFactory.getArticleDao().findArticleByPage(query, page);
		}
		return "recycle";
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

	public List<CategoryRecord> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<CategoryRecord> categoryList) {
		this.categoryList = categoryList;
	}

	public long getParentCategoryId() {
		return parentCategoryId;
	}

	public void setParentCategoryId(long parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}

	public TagRecord getTag() {
		return tag;
	}

	public void setTag(TagRecord tag) {
		this.tag = tag;
	}

	public List<ArticleImageRecord> getImgList() {
		return imgList;
	}

	public void setImgList(List<ArticleImageRecord> imgList) {
		this.imgList = imgList;
	}

	public long getParentFavoriteId() {
		return parentFavoriteId;
	}

	public void setParentFavoriteId(long parentFavoriteId) {
		this.parentFavoriteId = parentFavoriteId;
	}

	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}

	public ArticleFavoriteRecord getArticleFavorite() {
		return articleFavorite;
	}

	public void setArticleFavorite(ArticleFavoriteRecord articleFavorite) {
		this.articleFavorite = articleFavorite;
	}

	public List<CommentRecord> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<CommentRecord> commentList) {
		this.commentList = commentList;
	}

	public CommentRecord getComment() {
		return comment;
	}

	public void setComment(CommentRecord comment) {
		this.comment = comment;
	}

	public List<TagRecord> getTagList() {
		return tagList;
	}

	public void setTagList(List<TagRecord> tagList) {
		this.tagList = tagList;
	}

	public AnnotateRecord getAnnotate() {
		return annotate;
	}

	public void setAnnotate(AnnotateRecord annotate) {
		this.annotate = annotate;
	}
	public List<TagCategoryRecord> getTagCategoryList() {
		return tagCategoryList;
	}

	public void setTagCategoryList(List<TagCategoryRecord> tagCategoryList) {
		this.tagCategoryList = tagCategoryList;
	}

	public AnnotateRecord getHotTag() {
		return hotTag;
	}

	public void setHotTag(AnnotateRecord hotTag) {
		this.hotTag = hotTag;
	}

	public AnnotateRecord getTrendTag() {
		return trendTag;
	}

	public void setTrendTag(AnnotateRecord trendTag) {
		this.trendTag = trendTag;
	}

	public UserRecord getUser() {
		return user;
	}

	public void setUser(UserRecord user) {
		this.user = user;
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
	public List<ArticleRecord> getAboutArticleList() {
		return aboutArticleList;
	}

	public void setAboutArticleList(List<ArticleRecord> aboutArticleList) {
		this.aboutArticleList = aboutArticleList;
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

	public int getShowType() {
		return showType;
	}

	public void setShowType(int showType) {
		this.showType = showType;
	}
	
	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public List<CategoryRecord> getChildCategoryList() {
		return childCategoryList;
	}

	public void setChildCategoryList(List<CategoryRecord> childCategoryList) {
		this.childCategoryList = childCategoryList;
	}

	public String getInsertArticleToken() {
		return insertArticleToken;
	}

	public void setInsertArticleToken(String insertArticleToken) {
		this.insertArticleToken = insertArticleToken;
	}
	public long getArticleId() {
		return articleId;
	}

	public void setArticleId(long articleId) {
		this.articleId = articleId;
	}

	public ArticlePraiseRecord getArticlePraise() {
		return articlePraise;
	}

	public void setArticlePraise(ArticlePraiseRecord articlePraise) {
		this.articlePraise = articlePraise;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public Map<String, String> getParams() {
		return params;
	}

	public void setParams(Map<String, String> params) {
		this.params = params;
	}

	public List<ArticleFavoriteRecord> getUserArticleFavoriteList() {
		return userArticleFavoriteList;
	}

	public void setUserArticleFavoriteList(
			List<ArticleFavoriteRecord> userArticleFavoriteList) {
		this.userArticleFavoriteList = userArticleFavoriteList;
	}

	public ArticleRecord getNextArticle() {
		return nextArticle;
	}

	public void setNextArticle(ArticleRecord nextArticle) {
		this.nextArticle = nextArticle;
	}

	public ArticleRecord getPrevArticle() {
		return prevArticle;
	}

	public void setPrevArticle(ArticleRecord prevArticle) {
		this.prevArticle = prevArticle;
	}

	public String getExportTemplate() {
		return exportTemplate;
	}

	public void setExportTemplate(String exportTemplate) {
		this.exportTemplate = exportTemplate;
	}
}
