package com.newvery.record;

import java.util.Date;

/**
 * 用户组
 * @author beimukaibin
 *
 */
public class UserGroupRecord {
	
	private long id;
	private String groupName;
	private int lastVipDays;					//最后充值天数
	private Date vipValidateDate;				//最后有效日期
	
	private Date registerDate;					//用户组创建时间
	
	private long adminId;						//创建人id
	
	private long groupAdminUserId;				//组管理员id

	private int folderTotal;					//文件夹访问数
	private int categoryTotal;					//可访问目录数
	
	private int members;						//有多少成员
	
	private final long ONE_DAY = 1000*60*60*24;
	
	/**
	 * 会员有效期剩余
	 * @return
	 */
	public int getVipRemains() {
		long remainMinutes = vipValidateDate.getTime() - new Date().getTime();
		int days = (int)(remainMinutes / ONE_DAY);
		if(days > 0) {
			return days;
		} else {
			if(remainMinutes > 0) {
				return 1;
			}
		}
		return 0;
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public int getLastVipDays() {
		return lastVipDays;
	}

	public void setLastVipDays(int lastVipDays) {
		this.lastVipDays = lastVipDays;
	}

	public Date getVipValidateDate() {
		return vipValidateDate;
	}

	public void setVipValidateDate(Date vipValidateDate) {
		this.vipValidateDate = vipValidateDate;
	}


	public long getAdminId() {
		return adminId;
	}

	public void setAdminId(long adminId) {
		this.adminId = adminId;
	}

	public Date getRegisterDate() {
		return registerDate;
	}

	public void setRegisterDate(Date registerDate) {
		this.registerDate = registerDate;
	}

	public long getGroupAdminUserId() {
		return groupAdminUserId;
	}

	public void setGroupAdminUserId(long groupAdminUserId) {
		this.groupAdminUserId = groupAdminUserId;
	}

	public int getFolderTotal() {
		return folderTotal;
	}

	public void setFolderTotal(int folderTotal) {
		this.folderTotal = folderTotal;
	}

	public int getCategoryTotal() {
		return categoryTotal;
	}

	public void setCategoryTotal(int categoryTotal) {
		this.categoryTotal = categoryTotal;
	}

	public int getMembers() {
		return members;
	}

	public void setMembers(int members) {
		this.members = members;
	}
	
}
