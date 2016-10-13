package com.newvery.web.action.chart;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.newvery.bean.BeanFactory;
import com.newvery.constant.QueryChartType;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;
import com.newvery.record.ChartDistributionRecord;
import com.newvery.record.ChartRecord;
import com.newvery.record.ChartTagRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.record.QueryChartRecord;
import com.newvery.record.TagCategoryRecord;
import com.newvery.record.TagRecord;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.task.queryChart.QueryChartDeleteTask;
import com.newvery.task.queryChart.QueryChartInsertTask;
import com.newvery.utils.StringUtil;
import com.newvery.utils.TimeUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.response.ChartInitChartQueryBean;
import com.newvery.web.response.ChartListResponse;
import com.newvery.web.response.ChartResponse;
import com.newvery.web.response.ChartTagResponse;
import com.newvery.web.response.PieChartBean;
import com.newvery.web.response.QueryChartBean;
import com.newvery.web.response.QueryChartResponse;
import com.newvery.web.servlet.BaseResponse;

/**
 * 图表
 * @author mi_xb
 *
 */
public class ChartAction extends BaseWebAction {
	
	private static final long serialVersionUID = 5228969995743055897L;
	private String beginDate;
	private String endDate;
	private String tagName;
	private FavoriteRecord parentFavorite;
	private FavoriteRecord childFavorite;
	
	private boolean showResult;	//热点走向 是否显示结果
	private List<ChartDistributionRecord> chartDistributionList;
	private ChartDistributionRecord chartDistribution;
	private List<TagCategoryRecord> tagCategoryList ;
	
	private List<FavoriteRecord> favoriteList;
	private List<QueryChartResponse> queryChartResList;
	private List<QueryChartBean> queryChartBeanList;
	private QueryChartBean queryChartBean;
	
	private List<ArticleRecord> articleList;
	
	private QueryChartRecord queryChart;

	private String chk;
	
	private long[] fid;				//文件夹
	private long[] cid;				//子文件夹
	private long[] yid;				//年
	private long[] optionsRadios;	//选择
	private int optionsRadio;
	
	private long tagId;
	private TagRecord tag;
	private long tagCategoryId;			//标签目录id
	private List<ArticleRecord> rightArticleList;
	private List<TagRecord> tagList;
	private List<QueryChartRecord> queryChartList;
	
	private Date queryDate;
	private Page page = new Page();
	private Map<String, String> params = new HashMap<String, String>();
	private String title;
	
	private String pieDataContent;
	
	public String init() throws Exception {
		
		buildquerycategory();
		
		tagCategoryList = BeanFactory.getTagDao().findTagCategoryRecord();
		queryChartList = BeanFactory.getQueryChartDao().findQueryChart(getCurrentUser().getId(),  QueryChartType.T_INIT);
		
		//报表查询条件
		if(queryChart != null) {
			queryChart = BeanFactory.getQueryChartDao().findQueryChartByPK(queryChart.getId());
			if(queryChart != null && queryChart.getType() == QueryChartType.T_INIT) {
				
				if(StringUtil.isNull(queryChart.getContent()) != null) {
					Gson gson = new Gson();
					ChartInitChartQueryBean cicq = gson.fromJson(queryChart.getContent(), ChartInitChartQueryBean.class);
					if(cicq != null ) {
						tagCategoryId = cicq.getTagCategoryId();
						optionsRadio = cicq.getOptionsRadio();
						yid = cicq.getYid();
						fid = cicq.getFid();
						cid = cicq.getCid();
						beginDate = cicq.getBeginDate();
						endDate = cicq.getEndDate();
					}
				}
			}
		}
		
		//根据查询进行进行输出结果
		Map query = new HashMap();
		if(tagCategoryId > 0) {
			query.put("categoryId", tagCategoryId);
		}
		if(StringUtil.isNull(title) != null) {
			query.put("name", title.trim());
		}
		
		query.put("orderBy", "articleNum");
		query.put("ascdesc", "desc");
		
		if(getRequest().getParameter("optionsRadio") != null || optionsRadio > 0 ) {//必须带查询条件
			tagList = BeanFactory.getTagDao().findTagByPage(query, new Page(0xffffff));
			
			List<PieChartBean> pieData = new ArrayList<PieChartBean>();
			
			//统计对应的标签文章数
			for (TagRecord tag : tagList) {
				Map articleQuery = new HashMap();
				articleQuery.put("tagId",tag.getId());
				//加入文件夹与时间条件
				if(optionsRadio == 1) {	//对应的目录 
					if(fid != null) {
						articleQuery.put("parentFavoriteId",StringUtil.idArrayToString(fid));
					}
					if(cid != null) {
						articleQuery.put("childFavoriteIds", StringUtil.idArrayToString(cid));
					} 
					List<ChartRecord> list = BeanFactory.getArticleDao().findChartByCondition(articleQuery);
					tag.setArticleNum(list.size());
				} else {				//对应的时间
					if (null!=StringUtil.isNull(beginDate)) {
						articleQuery.put("beginDate", beginDate);
					}
					if (null!=StringUtil.isNull(endDate)) {
						articleQuery.put("endDate", endDate+" 23:59:59");
					}
					List<ChartRecord> list = BeanFactory.getArticleDao().findChartByCondition(articleQuery);
					tag.setArticleNum(list.size());
				}
				
				
				if(tag.getArticleNum() > 0) {
					pieData.add(new PieChartBean(tag.getName(),tag.getArticleNum()));
				}
				
				Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
				pieDataContent = gson.toJson(pieData);
				
				//int articleNum = BeanFactory.getArticleDao().countFavoriteArticleByPage(articleQuery);
				//tag.setArticleNum(articleNum);
			}
			
			Collections.sort(tagList, new Comparator() {
				@Override
				public int compare(Object o1, Object o2) {
					TagRecord f1 = (TagRecord)o1; 
					TagRecord f2 = (TagRecord)o2;
					if(f1.getArticleNum() == f2.getArticleNum()) return 0;
					return f1.getArticleNum() < f2.getArticleNum() ? 1 : -1;
				}
			});
			
			
		}
		
		
		return "init";
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
	
	/**
	 * 某个标签下的文件(此处有两个地方调用， 一个是热点发现根据标签id,一个是热点剖析饼图根据标签名称)
	 * @return
	 * @throws Exception
	 */
	public String tagArticle() throws Exception {
		if(StringUtil.isNull(tagName) != null) {
			tag = BeanFactory.getTagDao().findTagRecordByName(tagName);
			if(tag != null) {
				tagId = tag.getId();
			}
		}
		Map query = new HashMap();
		query.put("tagId", tagId);
		int count = BeanFactory.getArticleDao().countFavoriteArticleByPage(query);
		if(count > 0) {
			page.setNumPerPage(12);
			page.setTotalNum(count);
			articleList = BeanFactory.getArticleDao().findFavoriteArticleByPage(query, page);
		}
		return "tagArticle";
	}
	
	public String hot() throws Exception {
		ChartTagResponse result = new ChartTagResponse();
		try{
			Map query = new HashMap();
			if(optionsRadio==1){
				String fids = StringUtil.idArrayToString(fid);
				String cids = StringUtil.idArrayToString(cid); 
				if(null!=StringUtil.isNull(fids)&&!"0".equals(fids)){
					query.put("parentFavoriteIds", Long.valueOf(fids));
				}
				if(null!=StringUtil.isNull(cids)&&!"0".equals(cids)){
					query.put("childFavoriteIds", Long.valueOf(cids));
				}
				
			}else{
				if (beginDate != null && !"".equals(beginDate)) {
					query.put("beginDate", beginDate);
				}
				
				if (endDate != null && !"".equals(endDate)) {
					query.put("endDate", endDate+" 23:59:59");
				}
			}
			
			
			List<ChartTagRecord> chartList = BeanFactory.getArticleDao().findChartTagByCondition(query);
			result.setChartTagList(chartList);
		}catch(ServiceException ex){
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String chart() throws Exception {
		ChartResponse result = new ChartResponse();
		try {
			TagRecord tag = BeanFactory.getTagDao().findTagRecordByName(tagName.trim());
			result.setTagName(tagName.trim());
			if (tag == null) {
				result.setChartList(new ArrayList<ChartRecord>());
			} else {
				Map query = new HashMap();
				query.put("tagId", tag.getId());
				if (beginDate != null && !"".equals(beginDate)) {
					query.put("beginDate", beginDate);
				}
				
				if (endDate != null && !"".equals(endDate)) {
					query.put("endDate", endDate+" 23:59:59");
				}
				String parentFavoriteId = getRequest().getParameter("parentFavoriteId");
				if(null!=StringUtil.isNull(parentFavoriteId)&&!"0".equals(parentFavoriteId)){
					query.put("parentFavoriteId", Long.valueOf(parentFavoriteId));
				}
				String childFavoriteId = getRequest().getParameter("childFavoriteId");
				if(null!=StringUtil.isNull(childFavoriteId)&&!"0".equals(childFavoriteId)){
					query.put("childFavoriteId", Long.valueOf(childFavoriteId));
				}
				
				List<ChartRecord> chartList = BeanFactory.getArticleDao().findChartByCondition(query);
				int maxNum = BeanFactory.getArticleDao().countMaxChartByCondition(query);
				int totalNum = BeanFactory.getArticleDao().countTotalChartByCondition(query);
				result.setChartList(chartList);
				result.setMaxNum(maxNum);
				result.setTotalNum(totalNum);
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		
		return null;
	}
	
	public String initCompare() throws Exception {
		buildquerycategory();
		
		queryChartList = BeanFactory.getQueryChartDao().findQueryChart(getCurrentUser().getId(),  QueryChartType.T_COMPARE);
		//报表查询条件
		if(queryChart != null) {
			queryChart = BeanFactory.getQueryChartDao().findQueryChartByPK(queryChart.getId());
			if(queryChart != null && queryChart.getType() != QueryChartType.T_COMPARE) {
				queryChart = null;
			}
		}
		return "compare";
	}
	
	public String compare() throws Exception {
		ChartListResponse result = new ChartListResponse();
		try {
			if(null!=StringUtil.isNull(chk)){
				chk = chk.trim();
				String[] idx = chk.split(",");
				List<ChartResponse> chartResList = new ArrayList<ChartResponse>();
				
				for(String ix:idx){
					int num = Integer.parseInt(ix);
					optionsRadio = Integer.parseInt(getRequest().getParameter(num==0?"optionsRadios":"optionsRadios" + num));
					
					ChartResponse cr = new ChartResponse();
					
					String tn = getRequest().getParameter(num==0?"tagNames":"tagNames" + num);
					if(null==StringUtil.isNull(tn)){
						throw new ServiceException(-102, "请输入标签名称");
					}
					TagRecord tag = BeanFactory.getTagDao().findTagRecordByName(tn.trim());
					if(tag == null) {
						throw new ServiceException(-102, "标签名称:"+tn+"不存在，请重新选择");
					}
					cr.setTagName(tn.trim());
					
					Map query = new HashMap();
					query.put("tagId", tag.getId());
					if(optionsRadio==1){
						//query.put("tagId", tag.getId());
						long parentFavoriteId = Long.parseLong(getRequest().getParameter(num==0?"fid":"fid_" + num));;
						if(parentFavoriteId>0){
							query.put("parentFavoriteId",parentFavoriteId);
							String[] childFavoriteId = getRequest().getParameterValues(num==0?"cid":"cid_"+num);
							String childFavoriteIds = "";
							if(null!=childFavoriteId&&childFavoriteId.length>0){
								for(String sid:childFavoriteId){
									long cid = Long.parseLong(sid);
									if(cid>0){
										childFavoriteIds += cid+",";
									}
								}
								if(!"".equals(childFavoriteIds)){
									childFavoriteIds = childFavoriteIds.substring(0, childFavoriteIds.length() - 1);
									query.put("childFavoriteIds", childFavoriteIds);
								}
							}
							cr.setParentFavoriteId(parentFavoriteId+"");
							cr.setChildFavoriteIds(childFavoriteIds);
						}
					}else{
						beginDate = getRequest().getParameter(num==0?"beginDates":"beginDates_" + num);
						endDate = getRequest().getParameter(num==0?"endDates":"endDates_" + num);
						if (null!=StringUtil.isNull(beginDate)) {
							query.put("beginDate", beginDate);
						}
						
						if (null!=StringUtil.isNull(endDate)) {
							query.put("endDate", endDate+" 23:59:59");
						}
					}
					
					List<ChartRecord> chartList = BeanFactory.getArticleDao().findChartByCondition(query);
					cr.setChartList(chartList);
					
					chartResList.add(cr);
				}
				result.setChartResList(chartResList);
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String pointCompare() throws Exception {
		ChartResponse result = new ChartResponse();
		try {
			TagRecord tag = BeanFactory.getTagDao().findTagRecordByName(tagName.trim());
			result.setTagName(tagName.trim());
			if (tag == null) {
				result.setArticleList(new ArrayList<ArticleRecord>());
			} else {
				Map query = new HashMap();
				query.put("tagId", tag.getId());
				String parentFavoriteId = getRequest().getParameter("parentFavoriteId");
				if(null!=StringUtil.isNull(parentFavoriteId)&&!"0".equals(parentFavoriteId)&&!"-1".equals(parentFavoriteId)){
					query.put("parentFavoriteId", Long.valueOf(parentFavoriteId));
				}
				String childFavoriteIds = getRequest().getParameter("childFavoriteIds");
				if(null!=StringUtil.isNull(childFavoriteIds)&&!"0".equals(childFavoriteIds)&&!"-1".equals(childFavoriteIds)){
					query.put("childFavoriteIds", childFavoriteIds);
				}
				if(null!=queryDate){
					String qDate = TimeUtil.format(queryDate, TimeUtil.FORMAT_DATE_ONLY);
					query.put("beginDate", qDate);
					query.put("endDate", qDate+" 23:59:59");
				}else{
					if (null!=StringUtil.isNull(beginDate)) {
						query.put("beginDate", beginDate);
					}
					
					if (null!=StringUtil.isNull(endDate)) {
						query.put("endDate", endDate+" 23:59:59");
					}
				}
				List<ArticleRecord> articleChartList = BeanFactory.getArticleDao().findArticleChartByCondition(query);
				result.setArticleList(articleChartList);
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		
		return null;
	}
	
	public String saveQuery() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			queryChart.setUserId(getCurrentUser().getId());
			QueryChartInsertTask task = new QueryChartInsertTask();
			task.setQueryChart(queryChart);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		ajax(result);
		return null;
	}
	
	public String initDistribution() throws Exception {
		showResult = false;
		
		return "distribution";
	}
	
	/**
	 * 热点走向
	 * @return
	 * @throws Exception
	 */
	public String distribution() throws Exception {
		
		buildquerycategory();
		
		Map query = new HashMap();
		//报表查询条件
		if(queryChart != null) {
			queryChart = BeanFactory.getQueryChartDao().findQueryChartByPK(queryChart.getId());
			if(queryChart != null && queryChart.getType() == QueryChartType.T_ANALYSE) {
				
				Gson gson = new Gson();
				ChartInitChartQueryBean cicq = gson.fromJson(queryChart.getContent(), ChartInitChartQueryBean.class);
				if(cicq != null ) {
					tagCategoryId = cicq.getTagCategoryId();
					optionsRadio = cicq.getOptionsRadio();
					yid = cicq.getYid();
					fid = cicq.getFid();
					cid = cicq.getCid();
					beginDate = cicq.getBeginDate();
					endDate = cicq.getEndDate();
					tagName = cicq.getTagName();
				}
				
			}
		} 
		
		queryChartList = BeanFactory.getQueryChartDao().findQueryChart(getCurrentUser().getId(),  QueryChartType.T_ANALYSE);
		
		if(queryChart == null && StringUtil.isNull(tagName) == null ) {
			return "distribution";
		}
		//query.put("tagName", tagName.trim());
		
		TagRecord tag = BeanFactory.getTagDao().findTagRecordByName(tagName.trim());
		if(tag == null) {
			return "distribution";
		}
		query.put("tagId", tag.getId());
		
		switch (optionsRadio) {
			case 1:
				if(cid != null && cid.length > 0 ) {
					query.put("childFavoritIds", StringUtil.idArrayToString(cid));
				}
				break;
			case 2:												//时间
				if (StringUtil.isNull(beginDate) != null) {
					query.put("startDate", beginDate);
				}
				
				if (StringUtil.isNull(endDate) != null) {
					query.put("endDate", endDate);
				}
				break;
			default:
				if(cid != null && cid.length > 0 ) {
					query.put("childFavoritIds", StringUtil.idArrayToString(cid));
				}
				
				if (StringUtil.isNull(beginDate) != null) {
					query.put("startDate", beginDate);
				}
				
				if (StringUtil.isNull(endDate) != null) {
					query.put("endDate", endDate);
				}
				
				break;
		}
		
		
		
		
		chartDistributionList = BeanFactory.getArticleDao().findChartDistributionByCondition(query);
		
		return "distribution";
	}
	
	private String viewRegion;
	public String listTagArticle() throws Exception {
		Map query = new HashMap();
		query.put("tagId", tagId);
		
		switch (optionsRadio) {
		case 1:
			if(cid != null && cid.length > 0 ) {
				query.put("childFavoritIds", StringUtil.idArrayToString(cid));
			}
			break;
		case 2:												//时间
			if (StringUtil.isNull(beginDate) != null) {
				query.put("startDate", beginDate);
			}
			
			if (StringUtil.isNull(endDate) != null) {
				query.put("endDate", endDate+" 23:59:59");
			}
			break;
		default:
			if(cid != null && cid.length > 0 ) {
				query.put("childFavoritIds", StringUtil.idArrayToString(cid));
			}
			
			if (StringUtil.isNull(beginDate) != null) {
				query.put("beginDate", beginDate);
			}
			
			if (StringUtil.isNull(endDate) != null) {
				query.put("endDate", endDate+" 23:59:59");
			}
			break;
		}
		articleList = BeanFactory.getArticleDao().findArticleByConditionForChartDistribution(query);
		
		for (ArticleRecord article : articleList) {
			query.remove("tagId");
			query.put("articleId", article.getId());
			List<ChartDistributionRecord> list = BeanFactory.getArticleDao().findChartDistributionByCondition(query);
			article.setChartDistributionList(list);
		}
		
		if("right".equals(viewRegion)) {
			return "distribution-right";
		}
		return "distribution-container";
	}
	
	/**
	 * 删除保存的查询条件
	 * @return
	 * @throws Exception
	 */
	public String deleteQueryChart() throws Exception {
		BaseResponse result = new BaseResponse();
		
		try {
			QueryChartDeleteTask task = new QueryChartDeleteTask();
			task.setQueryChart(queryChart);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
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

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public FavoriteRecord getChildFavorite() {
		return childFavorite;
	}

	public void setChildFavorite(FavoriteRecord childFavorite) {
		this.childFavorite = childFavorite;
	}

	public List<ChartDistributionRecord> getChartDistributionList() {
		return chartDistributionList;
	}

	public void setChartDistributionList(
			List<ChartDistributionRecord> chartDistributionList) {
		this.chartDistributionList = chartDistributionList;
	}

	public boolean isShowResult() {
		return showResult;
	}

	public void setShowResult(boolean showResult) {
		this.showResult = showResult;
	}

	public FavoriteRecord getParentFavorite() {
		return parentFavorite;
	}

	public void setParentFavorite(FavoriteRecord parentFavorite) {
		this.parentFavorite = parentFavorite;
	}

	public ChartDistributionRecord getChartDistribution() {
		return chartDistribution;
	}

	public void setChartDistribution(ChartDistributionRecord chartDistribution) {
		this.chartDistribution = chartDistribution;
	}

	public List<ArticleRecord> getArticleList() {
		return articleList;
	}

	public void setArticleList(List<ArticleRecord> articleList) {
		this.articleList = articleList;
	}


	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}

	public QueryChartRecord getQueryChart() {
		return queryChart;
	}

	public void setQueryChart(QueryChartRecord queryChart) {
		this.queryChart = queryChart;
	}

	public List<QueryChartResponse> getQueryChartResList() {
		return queryChartResList;
	}

	public void setQueryChartResList(List<QueryChartResponse> queryChartResList) {
		this.queryChartResList = queryChartResList;
	}

	public List<QueryChartBean> getQueryChartBeanList() {
		return queryChartBeanList;
	}

	public void setQueryChartBeanList(List<QueryChartBean> queryChartBeanList) {
		this.queryChartBeanList = queryChartBeanList;
	}

	public String getChk() {
		return chk;
	}

	public void setChk(String chk) {
		this.chk = chk;
	}

	public QueryChartBean getQueryChartBean() {
		return queryChartBean;
	}

	public void setQueryChartBean(QueryChartBean queryChartBean) {
		this.queryChartBean = queryChartBean;
	}

	public long getTagId() {
		return tagId;
	}

	public void setTagId(long tagId) {
		this.tagId = tagId;
	}

	public TagRecord getTag() {
		return tag;
	}

	public void setTag(TagRecord tag) {
		this.tag = tag;
	}

	public List<ArticleRecord> getRightArticleList() {
		return rightArticleList;
	}

	public void setRightArticleList(List<ArticleRecord> rightArticleList) {
		this.rightArticleList = rightArticleList;
	}

	public Date getQueryDate() {
		return queryDate;
	}

	public void setQueryDate(Date queryDate) {
		this.queryDate = queryDate;
	}

	public long[] getFid() {
		return fid;
	}

	public void setFid(long[] fid) {
		this.fid = fid;
	}

	public long[] getCid() {
		return cid;
	}

	public void setCid(long[] cid) {
		this.cid = cid;
	}

	public long[] getYid() {
		return yid;
	}

	public void setYid(long[] yid) {
		this.yid = yid;
	}

	public long[] getOptionsRadios() {
		return optionsRadios;
	}

	public void setOptionsRadios(long[] optionsRadios) {
		this.optionsRadios = optionsRadios;
	}

	public int getOptionsRadio() {
		return optionsRadio;
	}

	public void setOptionsRadio(int optionsRadio) {
		this.optionsRadio = optionsRadio;
	}

	public List<TagCategoryRecord> getTagCategoryList() {
		return tagCategoryList;
	}

	public void setTagCategoryList(List<TagCategoryRecord> tagCategoryList) {
		this.tagCategoryList = tagCategoryList;
	}

	public long getTagCategoryId() {
		return tagCategoryId;
	}

	public void setTagCategoryId(long tagCategoryId) {
		this.tagCategoryId = tagCategoryId;
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

	public Map<String, String> getParams() {
		return params;
	}

	public List<QueryChartRecord> getQueryChartList() {
		return queryChartList;
	}

	public String getViewRegion() {
		return viewRegion;
	}

	public void setViewRegion(String viewRegion) {
		this.viewRegion = viewRegion;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPieDataContent() {
		return pieDataContent;
	}

}
