package com.newvery.web.action.article;

import java.util.ArrayList;
import java.util.List;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.record.AnnotateRecord;
import com.newvery.record.ArticleRecord;
import com.newvery.record.TagRecord;
import com.newvery.web.BaseAction;

public class ArticlePrintAction  extends BaseAction {

	private static final long serialVersionUID = -4285783843600760909L;

	private ArticleRecord article;
	
	private List<TagRecord> tagList = new ArrayList<TagRecord>();
	private AnnotateRecord annotate;		//批注
	private AnnotateRecord hotTag;			//热门标签
	private AnnotateRecord trendTag;		//趋势标签
	
	private String templateName;
	
	/**
	 * pdf导出页面
	 * @return
	 * @throws Exception
	 */
	public String show() throws Exception {
		if (article.getId() > 0) {
			article = BeanFactory.getArticleDao().findArticleRecordByPK(article.getId());
			String htmlStr = article.getContent();
			htmlStr = htmlStr.replaceAll("<([pP]+)[^>]*>", "<$1>");
			article.setContent(htmlStr);
			tagList = BeanFactory.getTagDao().findAllTagByArticleId(article.getId());
			
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
		}
		
		if("show".equals(templateName)) {
			return "show";
		}
		return "simple";
		
		
	}

	
	public ArticleRecord getArticle() {
		return article;
	}

	public void setArticle(ArticleRecord article) {
		this.article = article;
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


	public String getTemplateName() {
		return templateName;
	}


	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
}
