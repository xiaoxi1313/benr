package com.newvery.task.annotate;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;

public class AnnotateUpdateTask extends AnnotateTask {

	@Override
	public Object exec() throws ServiceException {
		AnnotateRecord a = getAnnotateDao().findAnnotateByPK(getAnnotate().getId());
		a.setContent(getAnnotate().getContent());
		a.setModifyTime(new Date());
		
		setAnnotate(getAnnotateDao().updateAnnotate(a));
		
		// 修改文章状态
		/** ArticleRecord article = getArticleDao().findArticleRecordByPK(getAnnotate().getArticleId());
		if (article.getStatus() != Constants.ARTICLE_STATUS_READED_ANNOTATED) {
			getArticleDao().updateArticleStatus(article.getId(), Constants.ARTICLE_STATUS_READED_ANNOTATED);
		} */
		
		return a;
	}
}
