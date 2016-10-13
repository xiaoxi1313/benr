package com.newvery.web.response;

import com.google.gson.annotations.Expose;
import com.newvery.record.AnnotateRecord;
import com.newvery.web.servlet.BaseResponse;

public class AnnotateResponse extends BaseResponse {
	@Expose
	private AnnotateRecord annotate;

	public AnnotateRecord getAnnotate() {
		return annotate;
	}

	public void setAnnotate(AnnotateRecord annotate) {
		this.annotate = annotate;
	}
	
}
