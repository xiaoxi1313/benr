package com.newvery;



public class Constants {
	public static final String LOGIN_MEMBER_SESSION_NAME = "user";
	public static final String LOGIN_ADMIN_SESSION_NAME = "admin";
	public static final String ACCESS_TOKEN = "access_token";
	public static final String FOLLOW_FLAG = "followFlag";
	
	public static final String INSERT_ARTICLE_TOKEN = "article_token";
	
	/**
	 * 对用户表的操作类型
	 * 
	 */
	public static final int USER_OPERATION_LOGIN=1;		//用户登录
	
	public static final int USER_PAGE_SIZE = 10;
	
	public static final int TAG_STATUS_NEW = 1;			//新增标签
	public static final int TAG_STATUS_NORMAL = 2;		//常规标签
	
	public static final long ROLE_GAOJIYANJIUYUAN = 1;		//高级研究员
	public static final long ROLE_YANJIUYUAN = 2;			//研究员
	public static final long ROLE_LURUYUAN = 3;				//录入员
	public static final long ROLE_GAOJIYONGHU = 4;			//高级用户
	public static final long ROLE_PUTONGYONGHU = 5;			//普通用户
	public static final long ROLE_SYSTEM = 6;				//系统管理员
	
	public static final int ARTICLE_STATUS_INIT = 1;					//初始状态：未读（可编辑）
	public static final int ARTICLE_STATUS_UNREADED = 2;				//过24小时后，未读(不可编辑)
	public static final int ARTICLE_STATUS_READED_UNANNOTATED = 3;		//管理员 已读未批注(可编辑)
	public static final int ARTICLE_STATUS_READED_ANNOTATED = 4;		// 管理员 已读已批注(不可编辑)
	
	public static final int ANNOTATE_TYPE_ANNOTATE = 1;			//批注类型-批注
	public static final int ANNOTATE_TYPE_HOT_TAG = 2;			//批注类型-热门标签
	public static final int ANNOTATE_TYPE_TREND_TAG = 3;		//批注类型-趋势标签
	
	public static final int QUERY_CONDITION_INDEX = 1;			//首页查询调教
	
	
	public static final int ARTICLE_PRAISE_TYPE_UP = 1;			//点赞
	public static final int ARTICLE_PRAISE_TYPE_DOWN = 2;		//踩
	
	public static final int PDF_TYPE_TREDN = 1;		//创新趋势
	public static final int PDF_TYPE_INFO = 2;		//创新情报
	
	public static final int START_YEAR = 2010; 		//起始年份-查询条件
	
	public static final int ALL_CHILDREN_CATEGORY = -1;
	
	public static final String LIST_ARTICLE_QUERY_SESSION = "listArticleQuery";
}
