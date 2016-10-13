package com.newvery.record;

import java.io.Serializable;
import java.util.Date;

public class UserLogRecord implements Serializable{
	
	private static final long serialVersionUID = -5855391777801265637L;

	private Long id;
	private UserRecord user;
	private int type;
	private String ip;
	private Date createdate;
	
	private Date startDate;
	private Date logoutTime;
	private String browser;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public UserRecord getUser() {
		return user;
	}
	public void setUser(UserRecord user) {
		this.user = user;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getLogoutTime() {
		return logoutTime;
	}
	public void setLogoutTime(Date logoutTime) {
		this.logoutTime = logoutTime;
	}
	public String getBrowser() {
		return browser;
	}
	public void setBrowser(String browser) {
		this.browser = browser;
	}
}
