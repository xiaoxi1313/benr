package com.newvery.web.action.favorite;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;
import com.newvery.record.FavoriteGroupRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserRecord;
import com.newvery.record.UserShareFavoriteRecord;
import com.newvery.task.favorite.ShareUserFavoriteTask;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.servlet.BaseResponse;

public class UserShareFavoriteAction  extends BaseWebAction {
	private static final long serialVersionUID = 1L;

	private int year;
	private List<FavoriteRecord> favoriteList;
	
	private List<ArticleRecord> unGroupedArticleList;
	
	private List<ArticleRecord> articleList;
	
	private List<FavoriteRecord> childFavoriteList;
	
	private FavoriteRecord parentFavorite;
	private FavoriteRecord childFavorite;
	
	private List<UserRecord> userList;
	
	@Override
	public String execute() throws Exception {
		//得到我的分享文件夹
		
		//判断当前用户是否为组管理员
		if(getCurrentUser().isGroupAdmin()) {
			Map q = new HashMap();
			q.put("userId", getCurrentUser().getId());
			favoriteList = BeanFactory.getFavoriteDao().findAllParetnFavoriteWithChildrenByUserId(q);
			
			Map query = new HashMap();
			query.put("userGroupId", getCurrentUser().getUserGroup().getId());
			userList = BeanFactory.getUserDao().findUserByPage(query, new Page(0xffffff));
		} else {
			
			List<UserShareFavoriteRecord> userShareFavoriteList = BeanFactory.getFavoriteDao().listShareFavoriteByUser(getCurrentUser().getId());
			
			//组合文件夹分类，通过map进行
			Map<FavoriteRecord, List<FavoriteRecord>> map = new HashMap<FavoriteRecord, List<FavoriteRecord>>();
			for (UserShareFavoriteRecord uf : userShareFavoriteList) {
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
			
		}
		
		if(favoriteList == null || favoriteList.size() == 0) {
			return SUCCESS;
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
			return SUCCESS;
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
		
		
		
		return super.execute();
	}

	private long userId[];
	public String shareFavorite() {
		BaseResponse result = new BaseResponse();
		
		try {
			ShareUserFavoriteTask task = new ShareUserFavoriteTask();
			task.setUserId(userId);
			task.setParentFavoriteId(parentFavorite.getId());
			task.setChildFavoriteId(childFavorite.getId());
			task.setShareUserId(getCurrentUser().getId());
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		
		return null;
	}
	
	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}

	public List<ArticleRecord> getUnGroupedArticleList() {
		return unGroupedArticleList;
	}

	public void setUnGroupedArticleList(List<ArticleRecord> unGroupedArticleList) {
		this.unGroupedArticleList = unGroupedArticleList;
	}

	public List<ArticleRecord> getArticleList() {
		return articleList;
	}

	public void setArticleList(List<ArticleRecord> articleList) {
		this.articleList = articleList;
	}

	public List<FavoriteRecord> getChildFavoriteList() {
		return childFavoriteList;
	}

	public void setChildFavoriteList(List<FavoriteRecord> childFavoriteList) {
		this.childFavoriteList = childFavoriteList;
	}

	public FavoriteRecord getParentFavorite() {
		return parentFavorite;
	}

	public void setParentFavorite(FavoriteRecord parentFavorite) {
		this.parentFavorite = parentFavorite;
	}

	public FavoriteRecord getChildFavorite() {
		return childFavorite;
	}

	public void setChildFavorite(FavoriteRecord childFavorite) {
		this.childFavorite = childFavorite;
	}

	public List<UserRecord> getUserList() {
		return userList;
	}

	public void setUserList(List<UserRecord> userList) {
		this.userList = userList;
	}

	public long[] getUserId() {
		return userId;
	}

	public void setUserId(long[] userId) {
		this.userId = userId;
	}
	
}
