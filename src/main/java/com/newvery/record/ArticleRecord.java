package com.newvery.record;

import java.util.Date;
import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.Constants;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;
import com.newvery.utils.StringUtil;

/**
 * 文章
 * @author mi_xb
 *
 */
public class ArticleRecord extends Entry implements IEntry {
	@Expose
	private long id;
	@Expose
	private String title;
	@Expose
	private String content;
	
	@Expose
	private String summary;
	
	private String sourceLink;				//源文链接
	
	private long parentCategoryId;
	private String parentCategoryName;
	
	private long childCategoryId;
	private String childCategoryName;
	
	private boolean deleted;
	
	/**
	 * 文章发布后24小时之内就是初始，但是状态栏上显示的是“未读”。
	 * 24小时后状态还是“未读”，但是这个录入员就无法编辑这个文章了。
	 * 如果被研究员（管理员）读了，就变成“已读未批注” 如果研究员（管理员）还批注了那就是“已读已批注”
	 * 一旦被管理员批注过之后，即使是在24小时内，录入员也无法在编辑这个文章了
	 * 如果管理员只是读了文章但是没有批注的话，那么在24小时内的这个录入员的文章他还能编辑
	 */
	private int status;
	private long userId;
	private String titleImage;			//标题图片
	
	private UserRecord user;
	@Expose
	private CategoryRecord parentCategory;
	private CategoryRecord childCategory;
	private String serial;
	@Expose
	private List<ChartDistributionRecord> chartDistributionList;		//只用于图表
	
	@Expose
	private int praiseUpNum;			// 点赞数量
	@Expose
	private int praiseDownNum;			// 踩数量
	
	private List<TagRecord> hot3TagList;				//文章关联的三个标签
	
	/**
	 * 超过72个字符，以省略号代替
	 * @return
	 */
	public String getContentSubStr() {
		return StringUtil.subStringCN(content, 72);
	}
	
	/**
	 * 状态名
	 * @return
	 */
	public String getStatusName() {
		String name = "";
		switch (status) {
		case Constants.ARTICLE_STATUS_INIT:
			name = "未读";
			break;
		case Constants.ARTICLE_STATUS_UNREADED:
			name ="未读";
			break;
		case Constants.ARTICLE_STATUS_READED_UNANNOTATED:
			name ="已读未批注";
			break;
		case Constants.ARTICLE_STATUS_READED_ANNOTATED:
			name ="已读已批注";
			break;
		}
		return name;
	}
	
	/**
	 * 文章是否可编辑
	 * @return
	 */
	public boolean isEditable() {
		if (status == Constants.ARTICLE_STATUS_UNREADED || status == Constants.ARTICLE_STATUS_READED_ANNOTATED) {
			return false;
		}
		if (status == Constants.ARTICLE_STATUS_READED_UNANNOTATED) { //已读未批注只在发布24小时内可编辑
			Date now = new Date();
			if ((now.getTime() - getCreateTime().getTime())/(1000*60*60) >= 24) {
				return false;
			}
		}
		return true;
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getParentCategoryId() {
		return parentCategoryId;
	}
	public void setParentCategoryId(long parentCategoryId) {
		this.parentCategoryId = parentCategoryId;
	}
	public long getChildCategoryId() {
		return childCategoryId;
	}
	public void setChildCategoryId(long childCategoryId) {
		this.childCategoryId = childCategoryId;
	}
	public UserRecord getUser() {
		return user;
	}
	public void setUser(UserRecord user) {
		this.user = user;
	}
	public CategoryRecord getParentCategory() {
		if(parentCategory == null) {
			if(parentCategoryId > 0) {
				parentCategory = new CategoryRecord();
				parentCategory.setId(parentCategoryId);
				parentCategory.setName(parentCategoryName);
			}
		}
		
		return parentCategory;
	}
	public void setParentCategory(CategoryRecord parentCategory) {
		this.parentCategory = parentCategory;
	}
	public CategoryRecord getChildCategory() {
		if(childCategory == null) {
			if(childCategoryId > 0) {
				childCategory = new CategoryRecord();
				childCategory.setId(childCategoryId);
				childCategory.setName(childCategoryName);
			}
		}
		
		return childCategory;
	}
	public void setChildCategory(CategoryRecord childCategory) {
		this.childCategory = childCategory;
	}

	public String getTitleImage() {
		return titleImage;
	}

	public void setTitleImage(String titleImage) {
		this.titleImage = titleImage;
	}

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

	public List<ChartDistributionRecord> getChartDistributionList() {
		return chartDistributionList;
	}

	public void setChartDistributionList(
			List<ChartDistributionRecord> chartDistributionList) {
		this.chartDistributionList = chartDistributionList;
	}

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}

	public int getPraiseUpNum() {
		return praiseUpNum;
	}

	public void setPraiseUpNum(int praiseUpNum) {
		this.praiseUpNum = praiseUpNum;
	}

	public int getPraiseDownNum() {
		return praiseDownNum;
	}

	public void setPraiseDownNum(int praiseDownNum) {
		this.praiseDownNum = praiseDownNum;
	}
	
	public String getSourceLink() {
		return sourceLink;
	}

	public void setSourceLink(String sourceLink) {
		this.sourceLink = sourceLink;
	}

	public List<TagRecord> getHot3TagList() {
		return hot3TagList;
	}

	public void setHot3TagList(List<TagRecord> hot3TagList) {
		this.hot3TagList = hot3TagList;
	}

	public String getParentCategoryName() {
		return parentCategoryName;
	}

	public void setParentCategoryName(String parentCategoryName) {
		this.parentCategoryName = parentCategoryName;
	}

	public String getChildCategoryName() {
		return childCategoryName;
	}

	public void setChildCategoryName(String childCategoryName) {
		this.childCategoryName = childCategoryName;
	}
}
