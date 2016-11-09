package com.newvery.task.article;

import java.util.Date;

import com.newvery.Constants;
import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticlePraiseRecord;
import com.newvery.record.ArticleRecord;

/**
 * 文章点赞
 * @author mi_xb
 *
 */
public class ArticlePraiseInsertTask extends ArticleTask {
	private ArticlePraiseRecord articlePraise;
	
	@Override
	public Object exec() throws ServiceException {
		ArticlePraiseRecord ap = getArticleDao().findArticlePraise(articlePraise);
		if (ap != null) {
			if (ap.getType() == Constants.ARTICLE_PRAISE_TYPE_UP) {
				throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "您已赞过！");
			}
			
			else if (ap.getType() == Constants.ARTICLE_PRAISE_TYPE_DOWN) {
				throw new ServiceException(ErrorCode.REPEAT_PK_RECORD, "您已踩过！");
			}
		}
		
		articlePraise.setCreateTime(new Date());
		articlePraise = getArticleDao().insertArticlePraise(articlePraise);
		
		// 跟新文章点赞数量
		ArticleRecord a = getArticleDao().findArticleRecordByPK(articlePraise.getArticleId());
		if (articlePraise.getType() == Constants.ARTICLE_PRAISE_TYPE_UP) {
			a.setPraiseUpNum(a.getPraiseUpNum() + 1);
			getArticleDao().updateArticleRecord(a);
		}
		
		else if (articlePraise.getType() == Constants.ARTICLE_PRAISE_TYPE_DOWN) {
			a.setPraiseDownNum(a.getPraiseDownNum() + 1);
			getArticleDao().updateArticleRecord(a);
		}
		return articlePraise;
	}

	public ArticlePraiseRecord getArticlePraise() {
		return articlePraise;
	}

	public void setArticlePraise(ArticlePraiseRecord articlePraise) {
		this.articlePraise = articlePraise;
	}

}
