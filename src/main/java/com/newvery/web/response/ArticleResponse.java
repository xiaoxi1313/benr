package com.newvery.web.response;

import com.google.gson.annotations.Expose;
import com.newvery.record.ArticleRecord;
import com.newvery.web.servlet.BaseResponse;

public class ArticleResponse extends BaseResponse {
	@Expose
	private ArticleRecord article;

	public ArticleRecord getArticle() {
		return article;
	}

	public void setArticle(ArticleRecord article) {
		this.article = article;
	}
	
}
