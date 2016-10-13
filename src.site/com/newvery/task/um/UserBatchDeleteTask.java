package com.newvery.task.um;

import java.util.HashMap;
import java.util.Map;

import com.newvery.exception.ServiceException;

/**
 * 批量删除用户
 * @author mi_xb
 *
 */
public class UserBatchDeleteTask extends UserTask {
	private String[] userIds;
	
	@Override
	public Object exec() throws ServiceException {
		if (userIds != null && userIds.length > 0) {
			Map query = new HashMap();
			query.put("userIdList", userIds);
			
			getUserDao().batchDeleteUserRecord(query);
		}
		return null;
	}

	public String[] getUserIds() {
		return userIds;
	}

	public void setUserIds(String[] userIds) {
		this.userIds = userIds;
	}

}
