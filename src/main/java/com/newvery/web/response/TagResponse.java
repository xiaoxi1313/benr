package com.newvery.web.response;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.TagRecord;
import com.newvery.web.servlet.BaseResponse;

public class TagResponse extends BaseResponse {
	@Expose
	private TagRecord tag;
	@Expose
	private List<TagRecord> tagList;

	public TagRecord getTag() {
		return tag;
	}

	public void setTag(TagRecord tag) {
		this.tag = tag;
	}

	public List<TagRecord> getTagList() {
		return tagList;
	}

	public void setTagList(List<TagRecord> tagList) {
		this.tagList = tagList;
	}
}
