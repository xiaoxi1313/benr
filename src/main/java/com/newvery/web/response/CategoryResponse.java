package com.newvery.web.response;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.CategoryRecord;
import com.newvery.web.servlet.BaseResponse;

public class CategoryResponse extends BaseResponse {
	@Expose
	private List<CategoryRecord> categoryList = new ArrayList<CategoryRecord>();

	public List<CategoryRecord> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<CategoryRecord> categoryList) {
		this.categoryList = categoryList;
	}
}
