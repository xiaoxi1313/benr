package com.newvery.config;

import java.util.HashMap;
import java.util.Map;

import com.newvery.bean.SystemConfig.WatermarkPosition;
import com.newvery.utils.secure.DigestUtil;



public class SystemParameterFactory {
	
	public static Map<String, String> PARAMETERS = new HashMap<String, String>();
	
	/**
	 * 允许上传的多媒体文件后缀
	 * @return
	 */
	public static String getAllowedUploadMediaExtension() {
		return PARAMETERS.get("allowedUploadMediaExtension");
	}

	/**
	 * 图片上传的文件后缀
	 * @return
	 */
	public static String getAllowedUploadImageExtension() {
		return PARAMETERS.get("allowedUploadImageExtension");
	}
	
	/**
	 * 其它文件上传的后缀
	 * @return
	 */
	public static String getAllowedUploadFileExtension() {
		return PARAMETERS.get("allowedUploadFileExtension");
	}
	
	
	/**
	 * 文件上传最大M数
	 * @return
	 */
	public static int getUploadLimit() {
		if(PARAMETERS.get("uploadLimit") != null) {
			return Integer.valueOf(PARAMETERS.get("uploadLimit") );
		}
		return 30000;
	}
	
	/**
	 * 水印图片路径
	 * @return
	 */
	public static String getWatermarkImagePath() {
		return PARAMETERS.get("watermarkImagePath");
	}
	
	/**
	 * 水印位置
	 * @return
	 */
	public static WatermarkPosition getWatermarkPosition() {
		return WatermarkPosition.valueOf(PARAMETERS.get("watermarkPosition"));
	}
	
	/**
	 * 商品图片（大）宽度
	 * @return
	 */
	public static int getBigProductImageWidth() {
		if (PARAMETERS.get("bigProductImageWidth") != null) { 
			return Integer.valueOf(PARAMETERS.get("bigProductImageWidth"));
		}
		return 500;
	}
	
	/**
	 * 商品图片（大）高度
	 * @return
	 */
	public static int getBigProductImageHeight() {
		if (PARAMETERS.get("bigProductImageHeight") != null) { 
			return Integer.valueOf(PARAMETERS.get("bigProductImageHeight"));
		}
		return 500;
	}
	
	/**
	 * 商品图片（小）宽度
	 * @return
	 */
	public static int getSmallProductImageWidth() {
		if (PARAMETERS.get("smallProductImageWidth") != null) { 
			return Integer.valueOf(PARAMETERS.get("smallProductImageWidth"));
		}
		return 300;
	}
	
	/**
	 * 商品图片（小）高度
	 * @return
	 */
	public static int getSmallProductImageHeight() {
		if (PARAMETERS.get("smallProductImageHeight") != null) { 
			return Integer.valueOf(PARAMETERS.get("smallProductImageHeight"));
		}
		return 300;
	}
	
	/**
	 * 商品缩略图宽度
	 * @return
	 */
	public static int getThumbnailProductImageWidth() {
		if (PARAMETERS.get("thumbnailProductImageWidth") != null) { 
			return Integer.valueOf(PARAMETERS.get("thumbnailProductImageWidth"));
		}
		return 140;
	}
	
	/**
	 * 商品缩略图高度
	 * @return
	 */
	public static int getThumbnailProductImageHeight() {
		if (PARAMETERS.get("thumbnailProductImageHeight") != null) { 
			return Integer.valueOf(PARAMETERS.get("thumbnailProductImageHeight"));
		}
		return 140;
	}
	
	/**
	 * 水印透明度
	 * @return
	 */
	public static int getWatermarkAlpha() {
		if (PARAMETERS.get("watermarkAlpha") != null) { 
			return Integer.valueOf(PARAMETERS.get("watermarkAlpha"));
		}
		return 50;
	}
	
	/**
	 * 话费接口地址
	 * @return
	 */
	public static String getTelSiteUrl() {
		return PARAMETERS.get("telSiteUrl");
	}
	
	/**
	 * 话费签名、秘钥
	 * @return
	 */
	public static String getTelPrivateKey() {
		return PARAMETERS.get("telPrivateKey");
	}
	
	/**
	 * 话费合作方用户编号
	 * @return
	 */
	public static String getTelUserId() {
		return PARAMETERS.get("telUserId");
	}
	
	public static String getTelPayPwd(){
		return PARAMETERS.get("telPayPwd");
	}
	
	/**
	 * 拉手接口地址
	 * @return
	 */
	public static String getLaShouSiteUrl() {
		return PARAMETERS.get("lashouSiteUrl");
	}
	/**
	 * 话费签名、秘钥
	 * @return
	 */
	public static String getLaShouPrivateKey() {
		return PARAMETERS.get("lashouPrivateKey");
	}
	
	/**
	 * 话费合作方用户编号
	 * @return
	 */
	public static String getlaShouUserId() {
		return PARAMETERS.get("lashouUserId");
	}
	/**
	 * 话费合作方支付密码
	 * @return
	 */
	public static String getLaShouPayPwd(){
		return DigestUtil.md5(PARAMETERS.get("lashouPayPwd"));
	}
	
	/**
	 * 流量接口地址
	 * @return
	 */
	public static String getFlowSiteUrl() {
		return PARAMETERS.get("flowSiteUrl");
	}
	
	/**
	 * 流量签名、秘钥
	 * @return
	 */
	public static String getFlowPrivateKey() {
		return PARAMETERS.get("flowPrivateKey");
	}
	
	/**
	 * 流量合作方用户编号
	 * @return
	 */
	public static String getFlowUserId() {
		return PARAMETERS.get("flowUserId");
	}
	
	/**
	 * 微博粉丝平台消息反馈开关
	 * @return
	 */
	public static boolean getWeiboMessageCallback() {
		if(null!=PARAMETERS.get("weiboMessageCallback")){
			if("true".equals(PARAMETERS.get("weiboMessageCallback").toLowerCase())){
				return true;
			}else{
				return false;
			}
		}
		return false;
	}
	
	/**
	 * 易充宝接口地址
	 * @return
	 */
	public static String getYiChongSiteUrl() {
		return PARAMETERS.get("yichongSiteUrl");
	}
	/**
	 * 易充宝话费签名、秘钥
	 * @return
	 */
	public static String getYiChongPrivateKey() {
		return PARAMETERS.get("yichongPrivateKey");
	}
	
	/**
	 * 易充宝话费合作方用户编号
	 * @return
	 */
	public static String getYiChongUserId() {
		return PARAMETERS.get("yichongUserId");
	}
	
	/**
	 * 手机充值自动返现开关
	 * @return
	 */
	public static boolean getRewardFlag() {
		return Boolean.valueOf(PARAMETERS.get("rewardFlag"));
	}	
	
	/**
	 * 流量充值活动自动返现开关
	 * @return
	 */
	public static boolean getFlowRewardFlag() {
		return Boolean.valueOf(PARAMETERS.get("flowRewardFlag"));
	}
}
