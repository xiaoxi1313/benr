package com.newvery.record;

import java.io.Serializable;
import java.util.Date;

import com.google.gson.annotations.Expose;

public class UserRecord implements Serializable {
	@Expose
	private long id;
	@Expose
	private String userName;
	private String password;
	
	@Expose
	private String realName;
	private String email;
	private String address;
	private String mobile;
	private String telephone;
	private boolean locked;
	private boolean deleted;
	private Date registerDate;
	private Date lastvisitDate;
	private Date modifyTime;
	
	private String icon;			//头像
	
	private int articleNum;			//文章数量
	
	private String validateCode; 	//找回密码 唯一标示
	private Date outDate;			//找回密码 过期的时间
	
	private RoleRecord role;
	
	private UserGroupRecord userGroup;
	
	@Expose
	private int vipDates;	//会员有效期
	
	
	private boolean visitFloder;			//具有访问项目文件夹权限
	private boolean visitChart;				//具有访问数据分析权限
	private boolean groupAdmin;				//是否为群组管理员
	
	/**
	 * 会员有效期剩余
	 * @return
	 */
	public int getVipRemains() {
		Date now = new Date();
		int days = Math.round((now.getTime() - registerDate.getTime())/(1000*60*60*24));
		return (vipDates - days) >= 0 ? (vipDates - days) : 0;
	}
	
	/**
	 * 是否在线，简化处理
	 * @return
	 */
	public boolean isOnline() {
		Date now = new Date();
		if ((now.getTime() - lastvisitDate.getTime())/(1000*60*60) >= 1) {	//最后访问时间大于1小时
			return false;
		} else {
			return true;
		}
	}
	
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRealName() {
		return realName;
	}
	public void setRealName(String realName) {
		this.realName = realName;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public boolean isLocked() {
		return locked;
	}
	public void setLocked(boolean locked) {
		this.locked = locked;
	}
	public boolean isDeleted() {
		return deleted;
	}
	public void setDeleted(boolean deleted) {
		this.deleted = deleted;
	}
	public Date getRegisterDate() {
		return registerDate;
	}
	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}
	public Date getLastvisitDate() {
		return lastvisitDate;
	}
	public void setLastvisitDate(Date lastvisitDate) {
		this.lastvisitDate = lastvisitDate;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getValidateCode() {
		return validateCode;
	}
	public void setValidateCode(String validateCode) {
		this.validateCode = validateCode;
	}
	public Date getOutDate() {
		return outDate;
	}
	public void setOutDate(Date outDate) {
		this.outDate = outDate;
	}
	public int getArticleNum() {
		return articleNum;
	}
	public void setArticleNum(int articleNum) {
		this.articleNum = articleNum;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public RoleRecord getRole() {
		return role;
	}
	public void setRole(RoleRecord role) {
		this.role = role;
	}
	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public Date getModifyTime() {
		return modifyTime;
	}
	public void setModifyTime(Date modifyTime) {
		this.modifyTime = modifyTime;
	}

	public int getVipDates() {
		return vipDates;
	}

	public void setVipDates(int vipDates) {
		this.vipDates = vipDates;
	}

	public UserGroupRecord getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroupRecord userGroup) {
		this.userGroup = userGroup;
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

	public boolean isGroupAdmin() {
		return groupAdmin;
	}

	public void setGroupAdmin(boolean groupAdmin) {
		this.groupAdmin = groupAdmin;
	}
}
