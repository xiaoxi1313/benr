package com.newvery.web.response;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.newvery.record.UserRecord;
import com.newvery.web.servlet.BaseResponse;

public class GroupAdminCheckResponse extends BaseResponse {

	@Expose
	private boolean flag;
	
	@Expose
	private long adminUserId;
	
	@Expose
	private List<UserRecord> userList;

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public long getAdminUserId() {
		return adminUserId;
	}

	public void setAdminUserId(long adminUserId) {
		this.adminUserId = adminUserId;
	}

	public List<UserRecord> getUserList() {
		return userList;
	}

	public void setUserList(List<UserRecord> userList) {
		this.userList = userList;
	}
	
}
