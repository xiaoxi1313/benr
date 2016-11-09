package com.newvery.web.helper;

import com.newvery.config.ConfigManager;

public class UrlHelper {

	public static String getHomeUrl() {
		return ConfigManager.getInstance().getHomeUrl();
	}
	
	/**
	 * 资源文件开始地址
	 * @return
	 */
	public static String getResourceHomeUrl() {
		return ConfigManager.getInstance().getResourceHome();
	}
}
