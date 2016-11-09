package com.newvery.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigManager {
	
	private static  ConfigManager _instance;
	
	private Properties props;
	
	private static final String SPRING_CONFIG_PATH = "spring.config.path";
	private static final String LOG4J_CONFIG_PATH = "log4j.filepath";
	
	
	private static String staticImagePaht = null;
	
	private ConfigManager() {
		
		InputStream in = ConfigManager.class.getResourceAsStream("/config.properties");
		props = new  Properties();
		try {
			
			props.load(in);
			
			in.close();
		} catch (IOException e) {
			e.printStackTrace();
			//throw new ServiceException(-2, "加载配置文件时出错" + e.getMessage());
		}
	}
	
	public static ConfigManager getInstance() {
		if(_instance == null) {
			_instance = new ConfigManager();
		}
		return _instance;
	}
	
	public String getSpringConfigPath() {
		return props.getProperty(SPRING_CONFIG_PATH);
	}
	
	public String getLog4jConfigFilePath() {
		return props.getProperty(LOG4J_CONFIG_PATH);
	}

	public String getMailHost() {
		return props.getProperty("mail.host");
	}

	public String getMailUser() {
		return props.getProperty("mail.user");
	}

	public String getMailPassword() {
		return props.getProperty("mail.password");
	}
	
	public String getHomeUrl() {
		return props.getProperty("url.home");
	}
	
	public String getResourceHome() {
		return props.getProperty("static.home");
	}
	
	public String getHomePath() {
		return props.getProperty("base.path");
	}
	
	
	/**
	 * 静态文件根路径
	 * @return
	 */
	public String getStaticRootPath() {
		return props.getProperty("file.static.path");
	}

	/**
	 * 获取相对于站点静态文件根目录 
	 * @return
	 */
	public String getStaticUrlRootPath() {
		return props.getProperty("url.static.root");
	}
	
	/**
	 * js文件存放路径
	 * @return
	 */
	public String getStaticJsPath() {
		return props.getProperty("file.static.js.path");
	}
	
	/**
	 * 图片文件存放路径
	 * @return
	 */
	public String getStaticImagePaht() {
		return props.getProperty("file.static.js.images");
	}
	
	public String getSmsSiooApiUrl() {
		return props.getProperty("sms.siooapi.url");
	}
	public String getSmsSiooApiUser() {
		return props.getProperty("sms.sioo.userid");
	}
	public String getSmsSiooApiPassword() {
		return props.getProperty("sms.sioo.password");
	}
	public String getSmsSiooApiCode() {
		return props.getProperty("sms.sioo.appcode");
	}
	public String getKindeditorAttachPath(){
		return props.getProperty("kindedior.attach.path");
	}
	
	public String getERPSellContractAPIURL(){
		return props.getProperty("erp.sellcontract.url");
	}
	
	public String getERPSellCarNoAPIURL(){
		return props.getProperty("erp.sellcarno.url");
	}
	
	public String getERPSellCancelContractAPIURL(){
		return props.getProperty("erp.cancelcontract.url");
	}
	
	
	/**
	 * 获取image URL
	 */
	
	public String getImageHomeUrl() {
		return props.getProperty("image.home");
	}
	
	public String getEmailSmtp() {
		return props.getProperty("email.smtp");
	}
	
	public String getEmailFrom() {
		return props.getProperty("email.from");
	}
	
	public String getEmailUserName() {
		return props.getProperty("email.userName");
	}
	
	public String getEmailPassword() {
		return props.getProperty("email.password");
	}
}
