package com.newvery;

public class ErrorCode {

	
	
	public static final int NULL_INPUT = 1;						//空值输入
	public static final int ILLEGAL_REQUEST = 2;				//无效请求
	public static final int UNKNOWN_INTERNAL_ERROR = 3;			//未知错误
	public static final int DB_ERROR = 4;						/**常规错误：数据库操作错误*/	
	
	public static final int REPEAT_PK_RECORD = 4;				//重复的业务数据
	
	public static final int ADMIN_LOGIN_ERROR = 30;						//用户登录错误
	
	public static final int USER_LOGIN_ERROR = 31;						//用户登录错误
	public static final int USER_REGISTER_ERROR = 32;					//用户注册错误
	public static final int USER_IS_LOCKED = 33;						//用户锁定
	public static final int USER_IS_DISABLED = 34;						//用户禁用
	public static final int USER_EMAIL_ERROR = 35;						//邮件找回密码错误
	
	public static final int File_NOT_FOUND = -404;
	
	public static final int VALIDATOR_PARAM_ERROR = 402;				//无效参数
	
	public static final int HTTP_READ_TIMEOUT = 500;					//读取响应超时
	
	public static final int FILE_UPLOAD_ERROR = 6001;					//文件上传错误
	
}
