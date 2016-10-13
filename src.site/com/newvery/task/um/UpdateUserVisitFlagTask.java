package com.newvery.task.um;

import com.newvery.exception.ServiceException;
import com.newvery.record.UserRecord;

public class UpdateUserVisitFlagTask extends UserTask{

	private long userId;
	private boolean visitFloder;
	private boolean visitChart;
	
	@Override
	public Object exec() throws ServiceException {
		UserRecord u = getUserDao().findUserById(userId);
		
		//检查是否超出了限制
		
		u.setVisitChart(visitChart);
		u.setVisitFloder(visitFloder);
		getUserDao().updateUser(u);
		
		return u;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public boolean isVisitFloder() {
		return visitFloder;
	}

	public void setVisitFloder(boolean visitFloder) {
		this.visitFloder = visitFloder;
	}

	public boolean isVisitChart() {
		return visitChart;
	}

	public void setVisitChart(boolean visitChart) {
		this.visitChart = visitChart;
	}
	

}
