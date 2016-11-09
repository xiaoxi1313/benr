package com.newvery.web.response;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.UserFavoriteRecord;
import com.newvery.record.UserRecord;
import com.newvery.web.servlet.BaseResponse;

public class UserFavoriteResponse extends BaseResponse {
	@Expose
	private UserRecord user;
	@Expose
	private List<UserFavoriteRecord> userFavoriteList;

	public UserRecord getUser() {
		return user;
	}

	public void setUser(UserRecord user) {
		this.user = user;
	}

	public List<UserFavoriteRecord> getUserFavoriteList() {
		return userFavoriteList;
	}

	public void setUserFavoriteList(List<UserFavoriteRecord> userFavoriteList) {
		this.userFavoriteList = userFavoriteList;
	}
}
