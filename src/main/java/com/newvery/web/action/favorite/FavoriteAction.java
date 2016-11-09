package com.newvery.web.action.favorite;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;
import com.newvery.record.ArticleFavoriteGroupRecord;
import com.newvery.record.ArticleFavoriteRecord;
import com.newvery.record.ArticleRecord;
import com.newvery.record.FavoriteGroupRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserRecord;
import com.newvery.task.article.ArticleBatchAddAnnotateTask;
import com.newvery.task.article.ArticleFavoriteDeleteTask;
import com.newvery.task.article.ArticleFavoriteGroupInsertTask;
import com.newvery.task.favorite.ClearArticleFavoriteGroupByFavorite;
import com.newvery.task.favorite.FavoriteBatchUpdateArticleOrderTask;
import com.newvery.task.favorite.FavoriteBatchUpdateOrderTask;
import com.newvery.task.favorite.FavoriteCompleteTask;
import com.newvery.task.favorite.FavoriteDeleteArticleTask;
import com.newvery.task.favorite.FavoriteDeleteTask;
import com.newvery.task.favorite.FavoriteGroupDeleteTask;
import com.newvery.task.favorite.FavoriteGroupInsertTask;
import com.newvery.task.favorite.FavoriteGroupUpdateTask;
import com.newvery.task.favorite.FavoriteInsertTask;
import com.newvery.task.favorite.FavoriteUpdateTask;
import com.newvery.utils.FileUtils;
import com.newvery.utils.StringUtil;
import com.newvery.utils.TimeUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.response.FavoriteResponse;
import com.newvery.web.servlet.BaseResponse;

/**
 * 收藏夹
 * @author mi_xb
 *
 */
public class FavoriteAction extends BaseWebAction {

	private static final long serialVersionUID = 5401133425915518528L;
	private List<FavoriteRecord> favoriteList;
	private List<FavoriteRecord> childFavoriteList;
	private FavoriteRecord favorite;
	private Page page = new Page();
	private long parentId;
	private long childId;
	private List<ArticleRecord> articleList;
	
	private FavoriteRecord parentFavorite;
	private FavoriteRecord childFavorite;
	
	private AnnotateRecord annotate;
	private ArticleRecord article;
	private ArticleFavoriteRecord articleFavorite;
	
	private File avatar; //上传的文件
    private String avatarFileName; //文件名称
    private String avatarContentType; //文件类型
	
	private long userId;
	
	private int completed;
	
	private int showType;		//展示类型  1：列表   2：网格
	
	private FavoriteGroupRecord favoriteGroup;
	
	private List<ArticleRecord> unGroupedArticleList;
	
	private int year;		//年份-查询条件
	private Set<Integer> userFavoriteYears;
	
	private List<UserRecord> memberList;
	
	public String list() throws Exception {
		if (userId > 0) {
			favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavoriteByUserId(userId);
		} else {
			favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavoriteByUserId(getCurrentUser().getId());
		}
		
		if (favoriteList == null || favoriteList.size() == 0) {
			return "list";
		}
		if (parentFavorite == null || parentFavorite.getId() == 0) {
			if (childFavorite != null && childFavorite.getId() > 0) {
				childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(childFavorite.getId());
				parentFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(childFavorite.getParentId());
			} else {
				parentFavorite = favoriteList.get(0);
			}
		} else {
			if (parentFavorite.getName() == null || "".equals(parentFavorite.getName())) {
				parentFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(parentFavorite.getId());
			}
		}
		
		childFavoriteList = BeanFactory.getFavoriteDao().findChildrenByParentId(parentFavorite.getId());
		
		if (childFavoriteList == null || childFavoriteList.size() == 0) {
			return "list";
		}
		
		if (childFavorite == null || childFavorite.getId() == 0) {
			childFavorite = childFavoriteList.get(0);
		}
		
		if (childFavorite.getName() == null || "".equals(childFavorite.getName())) {
			childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(childFavorite.getId());
		}
		
		articleList = BeanFactory.getArticleDao().findArticleByFavoriteId(childFavorite.getId());
		return "list";
	}
	
	public String save() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			String userFileDir = "/upload/favorite";
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
			favorite.setUserId(getCurrentUser().getId());
			favorite.setImg(avatarPath);
			FavoriteInsertTask task = new FavoriteInsertTask();
			task.setYear(year);
			task.setFavorite(favorite);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		
        
		return null;
	}
	
	public String child() throws Exception {
		if (parentId > 0) {
			favorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(parentId);
		} else {
			List<FavoriteRecord> parentList = BeanFactory.getFavoriteDao().findAllParetnFavorite();
			if (parentList != null && parentList.size() > 0) {
				favorite = parentList.get(0);
				parentId = favorite.getId();
			}
		}
		favoriteList = BeanFactory.getFavoriteDao().findChildrenByParentId(parentId);
		
		if (childFavorite == null || childFavorite.getId() == 0) {
			if (favoriteList != null && favoriteList.size() > 0) {
				childFavorite = favoriteList.get(0);
			}
		}
		
		if (childFavorite.getName() == null || "".equals(childFavorite.getName())) {
			childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(childFavorite.getId());
		}
		
		if (childFavorite != null) {
			articleList = BeanFactory.getArticleDao().findArticleByFavoriteId(childFavorite.getId());
		}
		
		return "child";
	}
	
	public String delete() throws Exception {
		FavoriteDeleteTask task = new FavoriteDeleteTask();
		task.setFavorite(favorite);
		
		BeanFactory.getSecurityExecutor().exec(task);
		
		return "delete";
	}
	
	public String deleteAjax() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			FavoriteDeleteTask task = new FavoriteDeleteTask();
			task.setFavorite(favorite);
			
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
			String userFileDir = "/upload/favorite";
			String realpath = org.apache.struts2.ServletActionContext.getServletContext().getRealPath(userFileDir);
	        
	        
	        String avatarPath = null;
	        if (avatar != null) {
	        	String fileName = favorite.getId() + "." + FileUtils.getFileExtension(avatarFileName);
		        avatarPath = userFileDir + "/" + fileName;
	        	
	        	
	            File savefile = new File(new File(realpath), fileName);
	            if (!savefile.getParentFile().exists()) {
	            	savefile.getParentFile().mkdirs();
	            }
	            org.apache.commons.io.FileUtils.copyFile(avatar, savefile);
	        }
			if(null!=avatarPath){
				favorite.setImg(avatarPath);
			}
			
			FavoriteUpdateTask task = new FavoriteUpdateTask();
			task.setFavorite(favorite);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	/**
	 * 给文章批量添加备注
	 * @return
	 * @throws Exception
	 */
	public String addTag() throws Exception {
		annotate.setUserId(getCurrentUser().getId());
		String[] articleIds = getRequest().getParameterValues("articleIds");
		if (articleIds != null && articleIds.length > 0) {
			ArticleBatchAddAnnotateTask task = new ArticleBatchAddAnnotateTask();
			task.setAnnotate(annotate);
			task.setArticleIds(articleIds);
			
			BeanFactory.getSecurityExecutor().exec(task);
		}
		
		return "delete";
	}
	
	/**
	 * 从收藏夹删除文章
	 * @return
	 * @throws Exception
	 */
	public String deleteArticle() throws Exception {
		articleFavorite.setUserId(getCurrentUser().getId());
		
		FavoriteDeleteArticleTask task = new FavoriteDeleteArticleTask();
		task.setArticleFavorite(articleFavorite);
		
		BeanFactory.getSecurityExecutor().exec(task);
		return "delete";
	}
	
	/**
	 * 排序收藏夹
	 * @return
	 * @throws Exception
	 */
	public String orderFavorite() throws Exception {
		String[] orderFavoriteId = getRequest().getParameterValues("orderFavoriteId");
		
		if (orderFavoriteId != null && orderFavoriteId.length > 0) {
			FavoriteBatchUpdateOrderTask task = new FavoriteBatchUpdateOrderTask();
			task.setOrderFavoriteId(orderFavoriteId);
			
			BeanFactory.getSecurityExecutor().exec(task);
		}
		return "delete";
	}
	
	/**
	 * 排序收藏夹 - ajax返回
	 * @return
	 * @throws Exception
	 */
	public String orderFavoriteAjax() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			String[] orderFavoriteId = getRequest().getParameterValues("orderFavoriteId");
			
			if (orderFavoriteId != null && orderFavoriteId.length > 0) {
				FavoriteBatchUpdateOrderTask task = new FavoriteBatchUpdateOrderTask();
				task.setOrderFavoriteId(orderFavoriteId);
				
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
	 * 排序收藏夹内文章
	 * @return
	 * @throws Exception
	 */
	public String orderArticle() throws Exception {
		String[] articleIds = getRequest().getParameterValues("articleIds");
		if (articleIds != null && articleIds.length > 0) {
			FavoriteBatchUpdateArticleOrderTask task = new FavoriteBatchUpdateArticleOrderTask();
			task.setArticleIds(articleIds);
			task.setChildFavoriteId(childId);
			task.setUserId(getCurrentUser().getId());
			
			BeanFactory.getSecurityExecutor().exec(task);
		}
		return "delete";
	}
	
	/**
	 * 取所有父收藏夹
	 * @return
	 * @throws Exception
	 */
	public String getAllParentFavorite() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavorite();
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
	private String fromShare;
	public String getFavoriteListByParentId() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			if (parentId > 0) {
				
				if(fromShare != null) {
					favoriteList = BeanFactory.getFavoriteDao().findChildrenByParentId(parentId);
				} else if(getCurrentUser().getRole().getId() == 1 || getCurrentUser().getRole().getId() == 2 ||getCurrentUser().getRole().getId() == 6) {
					favoriteList = BeanFactory.getFavoriteDao().findChildrenByParentId(parentId);
				} else {
					favoriteList = new ArrayList<FavoriteRecord>();
					List<UserFavoriteRecord> userFavorites = BeanFactory.getFavoriteDao().findUserFavoriteByGroupId(getCurrentUser().getUserGroup().getId());
					for (UserFavoriteRecord userFavoriteRecord : userFavorites) {
						if(userFavoriteRecord.getParentFavoriteId() == parentId) {
							favoriteList.add(userFavoriteRecord.getChildFavorite());
						}
					}
				}
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
	 * 文件夹 完成/取消完成
	 * @return
	 * @throws Exception
	 */
	public String complete() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			if (favorite != null && favorite.getId() > 0) {
				FavoriteCompleteTask task = new FavoriteCompleteTask();
				task.setFavorite(favorite);
				if (completed == 0) {
					task.setCompleted(false);
				} else {
					task.setCompleted(true);
				}
				
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
	 * 本然项目列表
	 * @return
	 * @throws Exception
	 */
	public String benrFavorite() throws Exception {
		
		List<UserFavoriteRecord> userFavoriteList =  new ArrayList<UserFavoriteRecord>();
		
		if("member".equals(getRequest().getParameter("st"))) {
			Map q = new HashMap();
			q.put("userGroupId", getCurrentUser().getUserGroup().getId());
			memberList = BeanFactory.getUserDao().findUserByPage(q, new Page(0xffffff));
			
			//成员文件夹2015-06-08改进
			long memberId = memberList.get(0).getId();
			if("member".equals(getRequest().getParameter("st")) && getRequest().getParameter("memberId") != null) {
				
				
				if(getRequest().getParameter("memberId") != null) {
					memberId = Long.valueOf(getRequest().getParameter("memberId"));
				}
			}
			userId = memberId;
			return this.myFavoriteList();
		}
		
		if("member".equals(getRequest().getParameter("st")) && getRequest().getParameter("memberId") != null) {
			
			long memberId = memberList.get(0).getId();
			if(getRequest().getParameter("memberId") != null) {
				memberId = Long.valueOf(getRequest().getParameter("memberId"));
			}
			userFavoriteList = BeanFactory.getFavoriteDao().findUserFavoriteByUserId(memberId);
			
			/*
			Map qc = new HashMap();
			if(year > 0) {
				qc.put("year", year);
			}
			qc.put("userId", memberId);
			favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavoriteWithChildrenByUserId(qc);
			for (FavoriteRecord f : favoriteList) {
				//if(f.getParentId() > 0) {
					UserFavoriteRecord uf = new UserFavoriteRecord();
					uf.setChildFavorite(f);
					uf.setParentFavorite(BeanFactory.getFavoriteDao().findFavoriteRecordByPK(f.getParentId()));
					
					userFavoriteList.add(uf);
				//}
			}*/
			
			
		} else {
			userFavoriteList = BeanFactory.getFavoriteDao().findUserFavoriteByGroupId(getCurrentUser().getUserGroup().getId());
		}
		
		
		//组合文件夹分类，通过map进行
		Map<FavoriteRecord, List<FavoriteRecord>> map = new HashMap<FavoriteRecord, List<FavoriteRecord>>();
		userFavoriteYears = new HashSet<Integer>();
		for (UserFavoriteRecord uf : userFavoriteList) {
			userFavoriteYears.add(TimeUtil.getYear(uf.getParentFavorite().getCreateTime()));
			if(year > 0 && TimeUtil.getYear(uf.getParentFavorite().getCreateTime()) != year) {
				continue;
			}
			if(map.get(uf.getParentFavorite()) != null) {
				map.get(uf.getParentFavorite()).add(uf.getChildFavorite());
			} else {
				map.put(uf.getParentFavorite(), new ArrayList<FavoriteRecord>());
				map.get(uf.getParentFavorite()).add(uf.getChildFavorite());
			}
			
		}
		for(Entry<FavoriteRecord, List<FavoriteRecord>> entry : map.entrySet()) {
			entry.getKey().setChildren(entry.getValue());
		}
		
		favoriteList = new ArrayList<FavoriteRecord>(map.keySet());
		
		Collections.sort(favoriteList, new Comparator() {

			@Override
			public int compare(Object o1, Object o2) {
				FavoriteRecord f1 = (FavoriteRecord)o1; 
				FavoriteRecord f2 = (FavoriteRecord)o2;
				if(f1.getPosition() == f2.getPosition()) {
					return f1.getId() <= f2.getId() ? -1 : 1;
				}
				return f1.getPosition() <= f2.getPosition() ? -1 : 1;
			}
		});
		
		if (parentFavorite == null || parentFavorite.getId() == 0) {
			if (favoriteList != null && favoriteList.size() > 0) {
				parentFavorite = favoriteList.get(0);
			}
		} else {
			parentFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPKWithChildren(parentFavorite.getId());
		}

		if (childFavorite == null || childFavorite.getId() == 0) {
			if (parentFavorite != null && parentFavorite.getChildren() != null && parentFavorite.getChildren().size() > 0) {
				childFavorite = parentFavorite.getChildren().get(0);
			}
		} else {
			childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPKWithGroup(childFavorite.getId());
		}
		
		if(childFavorite != null) {
			// 标题筛选条件
			if (article != null && article.getTitle() != null && !"".equals(article.getTitle().trim())) {
				if (childFavorite != null && childFavorite.getFavoriteGroupList() != null && childFavorite.getFavoriteGroupList().size() > 0) {
					for (FavoriteGroupRecord group : childFavorite.getFavoriteGroupList()) {
						if (group.getArticleList() != null && group.getArticleList().size() > 0) {
							Iterator<ArticleRecord> iterator = group.getArticleList().iterator();  
							while (iterator.hasNext()) {
								ArticleRecord a = iterator.next();
								if (!a.getTitle().contains(article.getTitle().trim())) {
									iterator.remove();
								}
							}
						}
					}
				}
			}
			
			unGroupedArticleList = BeanFactory.getArticleDao().findArticleByFavoriteId(childFavorite.getId());
			Iterator<ArticleRecord> iterator = unGroupedArticleList.iterator();  
			while (iterator.hasNext()) {
				ArticleRecord a = iterator.next();
				a.setHot3TagList(BeanFactory.getArticleDao().findLast3BuyArticle(a.getId()));
				boolean grouped = false;
				if (childFavorite.getFavoriteGroupList() != null) {
					for (FavoriteGroupRecord fg : childFavorite.getFavoriteGroupList()) {
						for (ArticleRecord ar : fg.getArticleList()) {
							if (a.getId() == ar.getId()) {
								grouped = true;
							}
						}
					}
					if (grouped) {
						iterator.remove();
					}
				}
			}
			
			//加入未分组
			if(unGroupedArticleList.size() > 0) {
				if(childFavorite.getFavoriteGroupList() == null) {
					childFavorite.setFavoriteGroupList(new ArrayList<FavoriteGroupRecord>());
				}
				
				FavoriteGroupRecord g = new FavoriteGroupRecord();
				g.setId(0);
				g.setArticleList(unGroupedArticleList);
				g.setName("未分组");
				childFavorite.getFavoriteGroupList().add(g);
			}
		}
		
		
		
		if (showType == 2) {
			return "origin_project_grid";
		} else {
			return "origin_project";
		}
	}
	
	/**
	 * 我的收藏 -- 用户
	 * @return
	 * @throws Exception
	 */
	public String myFavoriteList() throws Exception {
//		if (year <= 0) {
//			Calendar a = Calendar.getInstance();
//			year = a.get(Calendar.YEAR);
//		}
		Map query = new HashMap();
		
		if(year > 0) {
			query.put("year", year);
		}
		if(userId > 0) {
			query.put("userId", userId);
		} else {
			query.put("userId", getCurrentUser().getId());
		}
		
		
		favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavoriteWithChildrenByUserId(query);
		
		if (favoriteList == null || favoriteList.size() == 0) {
			return "my_favorite_list";
		}
		if (parentFavorite == null || parentFavorite.getId() == 0) {
			if (childFavorite != null && childFavorite.getId() > 0) {
				childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPKWithGroup(childFavorite.getId());
				parentFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPKWithChildren(childFavorite.getParentId());
			} else {
				parentFavorite = favoriteList.get(0);
			}
		} else {
			if (parentFavorite.getName() == null || "".equals(parentFavorite.getName())) {
				parentFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPKWithChildren(parentFavorite.getId());
			}
		}
		
		childFavoriteList = parentFavorite.getChildren();
		
		if (childFavoriteList == null || childFavoriteList.size() == 0) {
			return "my_favorite_list";
		}
		
		if (childFavorite == null || childFavorite.getId() == 0) {
			childFavorite = childFavoriteList.get(0);
		}
		
		if (childFavorite.getName() == null || "".equals(childFavorite.getName())) {
			childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPKWithGroup(childFavorite.getId());
		}
		
		unGroupedArticleList = BeanFactory.getArticleDao().findArticleByFavoriteId(childFavorite.getId());
		Iterator<ArticleRecord> iterator = unGroupedArticleList.iterator();  
		while (iterator.hasNext()) {
			ArticleRecord a = iterator.next();
			//a.setHot3TagList(BeanFactory.getArticleDao().findLast3BuyArticle(a.getId()));
			boolean grouped = false;
			for (FavoriteGroupRecord fg : childFavorite.getFavoriteGroupList()) {
				for (ArticleRecord ar : fg.getArticleList()) {
					if (a.getId() == ar.getId()) {
						grouped = true;
					}
				}
			}
			if (grouped) {
				iterator.remove();
			}
		}
		
		//加入未分组
		if(unGroupedArticleList.size() > 0) {
			if(childFavorite.getFavoriteGroupList() == null) {
				childFavorite.setFavoriteGroupList(new ArrayList<FavoriteGroupRecord>());
			}
			
			FavoriteGroupRecord g = new FavoriteGroupRecord();
			g.setId(0);
			g.setArticleList(unGroupedArticleList);
			g.setName("未分组");
			childFavorite.getFavoriteGroupList().add(g);
		}
		//articleList = BeanFactory.getArticleDao().findArticleByFavoriteId(childFavorite.getId());
		
		//查看其它研究员
		if(userId > 0) {
			userFavoriteYears = new HashSet<Integer>();
			List<FavoriteRecord> flist = BeanFactory.getFavoriteDao().findParentFavoriteByUserId(userId);
			for (FavoriteRecord uf : flist) {
				userFavoriteYears.add(TimeUtil.getYear(uf.getCreateTime()));
			}
			if (showType == 2) {
				return "origin_project_grid";
			} else {
				return "origin_project";
			}
		} else {
			return "my_favorite_list";
		}
		
	}
	
	/**
	 * 添加收藏夹分组
	 * @return
	 * @throws Exception
	 */
	public String addFavoriteGroup() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			favoriteGroup.setUserId(getCurrentUser().getId());
			
			FavoriteGroupInsertTask task = new FavoriteGroupInsertTask();
			task.setFavoriteGroup(favoriteGroup);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 给子文件夹下的文章分组、排序
	 * @return
	 * @throws Exception
	 */
	public String groupArticle() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			// 清除原有关系
			ClearArticleFavoriteGroupByFavorite clearTask = new ClearArticleFavoriteGroupByFavorite();
			clearTask.setFavorite(childFavorite);
			
			BeanFactory.getSecurityExecutor().exec(clearTask);
			
			String[] groupIdStrs = getRequest().getParameterValues("g");
			for (String groupIdStr : groupIdStrs) {
				int groupId = Integer.parseInt(groupIdStr);
				if (groupId > 0) {
					String articleIdStr = getRequest().getParameter("aid_" + groupId);
					String[] articleIds = articleIdStr.split(";");
					for (String articleStr : articleIds) {
						if(StringUtil.isNull(articleStr) != null) {
							ArticleFavoriteGroupRecord afg = new ArticleFavoriteGroupRecord();
							afg.setArticleId(Integer.parseInt(articleStr));
							afg.setFavoriteGroupId(groupId);
							
							ArticleFavoriteGroupInsertTask task = new ArticleFavoriteGroupInsertTask();
							task.setArticleFavoriteGroup(afg);
							BeanFactory.getSecurityExecutor().exec(task);
						}
						
					}
				}
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		} catch(NumberFormatException e) {
			e.printStackTrace();
		}
		
		ajax(result);
		return null;
	} 
	
	/**
	 * 修改收藏夹分组
	 * @return
	 * @throws Exception
	 */
	public String updateFavoriteGroup() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			FavoriteGroupUpdateTask task = new FavoriteGroupUpdateTask();
			task.setFavoriteGroup(favoriteGroup);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 删除收藏夹分组
	 * @return
	 * @throws Exception
	 */
	public String deleteFavoriteGroup() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			FavoriteGroupDeleteTask task = new FavoriteGroupDeleteTask();
			task.setFavoriteGroup(favoriteGroup);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 删除用户的文章、文件夹关系
	 * @return
	 * @throws Exception
	 */
	public String deleteArticleFavorite() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			//articleFavorite.setUserId(getCurrentUser().getId());
			//articleFavorite = BeanFactory.getArticleDao().findArticleFavorite(articleFavorite);
	
			ArticleFavoriteDeleteTask task = new ArticleFavoriteDeleteTask();
			task.setArticleId(articleFavorite.getArticleId());
			task.setUserId(getCurrentUser().getId());
			task.setFavoriteGroupId(favoriteGroup.getId());
			BeanFactory.getSecurityExecutor().exec(task);
			
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}

	/**
	 * 取所有父收藏夹
	 * @return
	 * @throws Exception
	 */
	public String getParentFavoriteList() throws Exception {
		FavoriteResponse result = new FavoriteResponse();
		try {
			Map query = new HashMap();
			if (year > 0) {
				query.put("year", year);
			}
			query.put("userId", getCurrentUser().getId());
			favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavoriteWithChildrenByUserId(query);
			result.setFavoriteList(favoriteList);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}

	public FavoriteRecord getFavorite() {
		return favorite;
	}

	public void setFavorite(FavoriteRecord facorite) {
		this.favorite = facorite;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public long getParentId() {
		return parentId;
	}

	public void setParentId(long parentId) {
		this.parentId = parentId;
	}

	public long getChildId() {
		return childId;
	}

	public void setChildId(long childId) {
		this.childId = childId;
	}

	public List<ArticleRecord> getArticleList() {
		return articleList;
	}

	public void setArticleList(List<ArticleRecord> articleList) {
		this.articleList = articleList;
	}

	public FavoriteRecord getChildFavorite() {
		return childFavorite;
	}

	public void setChildFavorite(FavoriteRecord childFavorite) {
		this.childFavorite = childFavorite;
	}

	public FavoriteRecord getParentFavorite() {
		return parentFavorite;
	}

	public void setParentFavorite(FavoriteRecord parentFavorite) {
		this.parentFavorite = parentFavorite;
	}

	public List<FavoriteRecord> getChildFavoriteList() {
		return childFavoriteList;
	}

	public void setChildFavoriteList(List<FavoriteRecord> childFavoriteList) {
		this.childFavoriteList = childFavoriteList;
	}

	public AnnotateRecord getAnnotate() {
		return annotate;
	}

	public void setAnnotate(AnnotateRecord annotate) {
		this.annotate = annotate;
	}

	public ArticleRecord getArticle() {
		return article;
	}

	public void setArticle(ArticleRecord article) {
		this.article = article;
	}

	public ArticleFavoriteRecord getArticleFavorite() {
		return articleFavorite;
	}

	public void setArticleFavorite(ArticleFavoriteRecord articleFavorite) {
		this.articleFavorite = articleFavorite;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
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

	public int getCompleted() {
		return completed;
	}

	public void setCompleted(int completed) {
		this.completed = completed;
	}

	public int getShowType() {
		return showType;
	}

	public void setShowType(int showType) {
		this.showType = showType;
	}

	public FavoriteGroupRecord getFavoriteGroup() {
		return favoriteGroup;
	}

	public void setFavoriteGroup(FavoriteGroupRecord favoriteGroup) {
		this.favoriteGroup = favoriteGroup;
	}

	public List<ArticleRecord> getUnGroupedArticleList() {
		return unGroupedArticleList;
	}

	public void setUnGroupedArticleList(List<ArticleRecord> unGroupedArticleList) {
		this.unGroupedArticleList = unGroupedArticleList;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public List<UserRecord> getMemberList() {
		return memberList;
	}

	public void setMemberList(List<UserRecord> memberList) {
		this.memberList = memberList;
	}

	public Set<Integer> getUserFavoriteYears() {
		return userFavoriteYears;
	}

	public void setUserFavoriteYears(Set<Integer> userFavoriteYears) {
		this.userFavoriteYears = userFavoriteYears;
	}

	public String getFromShare() {
		return fromShare;
	}

	public void setFromShare(String fromShare) {
		this.fromShare = fromShare;
	}

}
