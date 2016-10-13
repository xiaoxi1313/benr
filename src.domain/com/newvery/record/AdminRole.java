package com.newvery.record;

import java.io.Serializable;

import com.google.gson.annotations.Expose;
import com.newvery.entry.Entry;
import com.newvery.entry.IEntry;

public class AdminRole extends Entry implements IEntry,Serializable {
	
	private static final long serialVersionUID = 160405952580025728L;

	@Expose
	private long id;
	private long role_id;
	private long admin_id;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getRole_id() {
		return role_id;
	}

	public void setRole_id(long role_id) {
		this.role_id = role_id;
	}

	public long getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(long admin_id) {
		this.admin_id = admin_id;
	}

}
