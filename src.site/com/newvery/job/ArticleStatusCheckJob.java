package com.newvery.job;

import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;
import com.newvery.task.article.ArticleStatusUpdateTask;
import com.newvery.utils.TimeUtil;

/**
 * 订单状态检查
 * @author mi_xb
 *
 */
public class ArticleStatusCheckJob {
	private Log logger = LogFactory.getLog(ArticleStatusCheckJob.class);
	
	public void checkStatus() {
		try {
			List<ArticleRecord> articleList = BeanFactory.getArticleDao().findArticleByStatus(Constants.ARTICLE_STATUS_INIT);
			for (ArticleRecord article : articleList) {
				Date now = new Date();
				if ((now.getTime() - article.getCreateTime().getTime())/(1000*60*60) >= 24) {	//超过24小时
					logger.info(article.getTitle() + " - " + TimeUtil.format(article.getCreateTime(), TimeUtil.FORMAT_NORMAL) + " - 超过24小时！");
					article.setStatus(Constants.ARTICLE_STATUS_UNREADED);
					
					ArticleStatusUpdateTask task = new ArticleStatusUpdateTask();
					task.setArticle(article);
					
					BeanFactory.getSecurityExecutor().exec(task);
				}
			}
		} catch (ServiceException e) {
			logger.error(e.getMessage());
		}
	}
}
