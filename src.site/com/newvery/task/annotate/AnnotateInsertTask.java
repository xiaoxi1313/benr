package com.newvery.task.annotate;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;
import com.newvery.record.ArticleRecord;

public class AnnotateInsertTask extends AnnotateTask {

	@Override
	public Object exec() throws ServiceException {
		Map query = new HashMap();
		query.put("userId", getAnnotate().getUserId());
		query.put("articleId", getAnnotate().getArticleId());
		query.put("type", getAnnotate().getType());
		List<AnnotateRecord> list = BeanFactory.getAnnotateDao().findAnnotate(query);
		
		if (list != null && list.size() > 0) {
			AnnotateRecord a = list.get(0);
			a.setContent(getAnnotate().getContent());
			a.setModifyTime(new Date());
			
			setAnnotate(getAnnotateDao().updateAnnotate(a));
		} else {
			getAnnotate().setCreateTime(new Date());
			getAnnotate().setDeleted(false);
			getAnnotate().setSaved(false);
			
			setAnnotate(getAnnotateDao().insertAnnotate(getAnnotate()));
		}
		
		// 修改文章状态
		ArticleRecord article = getArticleDao().findArticleRecordByPK(getAnnotate().getArticleId());
		if (article.getStatus() != Constants.ARTICLE_STATUS_READED_ANNOTATED) {
			getArticleDao().updateArticleStatus(article.getId(), Constants.ARTICLE_STATUS_READED_ANNOTATED);
		} 
		
		return getAnnotate();
	}
}
