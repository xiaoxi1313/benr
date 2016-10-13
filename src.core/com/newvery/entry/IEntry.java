package com.newvery.entry;

import java.util.Date;

public interface IEntry {
	/**
	 * 所在语言环境
	 * @return
	 */
	public String getLocale();
	
	
	/**
	 * 对象创建时间
	 * @return
	 */
	public Date getCreateTime();
	
	
	/**
	 * 最后更新时间
	 * @return
	 */
	public Date getModifyTime();
}
