package com.newvery.task.article;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.newvery.bean.BeanFactory;
import com.newvery.dal.dao.annotate.IAnnotateDao;
import com.newvery.dal.dao.annotate.impl.AnnotateDaoImpl;
import com.newvery.exception.ServiceException;
import com.newvery.record.AnnotateRecord;

/**
 * 文章批量添加批注
 * @author mi_xb
 *
 */
public class ArticleBatchAddAnnotateTask extends ArticleTask {
	private String[] articleIds;
	private AnnotateRecord annotate;

	@Override
	public Object exec() throws ServiceException {
		annotate = getAnnotateDao().insertAnnotate(annotate);
		if (articleIds != null && articleIds.length > 0) {
			for (String articleId : articleIds) {
				Map query = new HashMap();
				query.put("userId", getAnnotate().getUserId());
				query.put("articleId", articleId);
				query.put("type", getAnnotate().getType());
				List<AnnotateRecord> list = BeanFactory.getAnnotateDao().findAnnotate(query);
				
				if (list != null && list.size() > 0) {
					AnnotateRecord a = list.get(0);
					a.setContent(annotate.getContent());
					a.setModifyTime(new Date());
					
					setAnnotate(getAnnotateDao().updateAnnotate(a));
				} else {
					annotate.setCreateTime(new Date());
					annotate.setDeleted(false);
					annotate.setSaved(false);
					annotate.setArticleId(Long.parseLong(articleId));
					
					setAnnotate(getAnnotateDao().insertAnnotate(getAnnotate()));
				}
			}
		}
		// TODO Auto-generated method stub
		return null;
	}

	public IAnnotateDao getAnnotateDao() {
		return (IAnnotateDao) getDaoManagerFactory().getManagerImpl(AnnotateDaoImpl.class);
	}

	public String[] getArticleIds() {
		return articleIds;
	}

	public void setArticleIds(String[] articleIds) {
		this.articleIds = articleIds;
	}

	public AnnotateRecord getAnnotate() {
		return annotate;
	}

	public void setAnnotate(AnnotateRecord annotate) {
		this.annotate = annotate;
	}
}
