package com.newvery.web.action.chart;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.newvery.bean.BeanFactory;
import com.newvery.record.ChartDistributionRecord;
import com.newvery.record.TagCategoryRecord;
import com.newvery.record.TagRecord;
import com.newvery.utils.StringUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.response.PieChartBean;
import com.newvery.web.response.PieChartResponse;

/**
 * 热点发布饼图
 * @author beimukaibin
 *
 */
public class PieChartAction  extends BaseWebAction {

	private static final long serialVersionUID = 1L;
	private long tagCategoryId;
	
	private int optionsRadio;
	private long cid[];
	private String beginDate;
	private String endDate;
	private String tagName;
	
	
	@Override
	public String execute() throws Exception {
	
		PieChartResponse result = new PieChartResponse();
		List<PieChartBean> data = new ArrayList<PieChartBean>();
		
		
		if(StringUtil.isNull(tagName) != null) {			//必须带参数查询
			
			TagRecord tag = BeanFactory.getTagDao().findTagRecordByName(tagName.trim());
			if(tag != null) {
				
				Map query = new HashMap();
				//query.put("tagName", tagName.trim());
				
				
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
				
				List<Long> articleIds = BeanFactory.getTagDao().findTagArticleCondition(query);
				query.put("articleIds", articleIds);
				
				Set<Long> tagCategorySet = new HashSet<Long>();
				
				query.remove("tagId");
				query.put("pietagId", tag.getId());
				int i = 0;
				List<ChartDistributionRecord> chartDistributionList = BeanFactory.getArticleDao().findChartDistributionByCondition(query);
				for (ChartDistributionRecord distribution : chartDistributionList) {
					
					//过滤分类目录 
					tagCategorySet.add(distribution.getCategoryId());
					
					
					if(i >= 1000) break;				//highcharts 图表最大支持1000个点
					if(distribution.getNum() > 0) {
						
						if(tagCategoryId <= 0) {
							data.add(new PieChartBean(distribution.getTagName(), distribution.getNum()));
						} else {//带分类目录过滤
							if(distribution.getCategoryId() == tagCategoryId) {
								data.add(new PieChartBean(distribution.getTagName(), distribution.getNum()));
							}
						}
						
						i++;
					}
				}
				
				List<TagCategoryRecord> tagCategoryList = new ArrayList<TagCategoryRecord>();
				
				for (Long tagCategoryId : tagCategorySet) {
					tagCategoryList.add(BeanFactory.getTagDao().findTagCategoryRecordByPK(tagCategoryId));
				}
				result.setTagCategoryList(tagCategoryList);
				
			}
			
			
		}
		
		
		result.setData(data);
		ajax(result);
		return null;
	}

	public long getTagCategoryId() {
		return tagCategoryId;
	}

	public void setTagCategoryId(long tagCategoryId) {
		this.tagCategoryId = tagCategoryId;
	}

	public int getOptionsRadio() {
		return optionsRadio;
	}

	public void setOptionsRadio(int optionsRadio) {
		this.optionsRadio = optionsRadio;
	}

	public long[] getCid() {
		return cid;
	}

	public void setCid(long[] cid) {
		this.cid = cid;
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
	
}
