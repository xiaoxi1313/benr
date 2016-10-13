package com.newvery.task.upload;

import java.util.Date;

import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleImageRecord;
import com.newvery.task.article.ArticleTask;

/**
 * 上传图片
 * @author mi_xb
 *
 */
public class UploadImageTask extends ArticleTask {
	private ArticleImageRecord articleImage;
	
	@Override
	public Object exec() throws ServiceException {
		articleImage.setCreateTime(new Date());
		articleImage.setDeleted(false);

		articleImage = getArticleDao().insertArticleImage(articleImage);
		return articleImage;
	}

	public ArticleImageRecord getArticleImage() {
		return articleImage;
	}

	public void setArticleImage(ArticleImageRecord articleImage) {
		this.articleImage = articleImage;
	}
}
