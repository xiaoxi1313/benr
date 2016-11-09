package com.newvery.web.response;

import com.google.gson.annotations.Expose;
import com.newvery.web.servlet.BaseResponse;

public class FileUploadResponse extends BaseResponse {
	@Expose
	private String url;
	@Expose
	private long articleImageId;

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public long getArticleImageId() {
		return articleImageId;
	}

	public void setArticleImageId(long articleImageId) {
		this.articleImageId = articleImageId;
	}
}
