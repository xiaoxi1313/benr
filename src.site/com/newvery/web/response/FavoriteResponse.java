package com.newvery.web.response;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.FavoriteRecord;
import com.newvery.web.servlet.BaseResponse;

public class FavoriteResponse extends BaseResponse {
	@Expose
	private List<FavoriteRecord> favoriteList = new ArrayList<FavoriteRecord>();

	public List<FavoriteRecord> getFavoriteList() {
		return favoriteList;
	}

	public void setFavoriteList(List<FavoriteRecord> favoriteList) {
		this.favoriteList = favoriteList;
	}
}
