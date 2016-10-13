package com.newvery.validator;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.newvery.ErrorCode;
import com.newvery.exception.ServiceException;


public class ParamValidator {
	public static final int TIME = 1;			//时间
	public static final int KEYWORD = 2;		//关键字	
	public static final int USERNAME = 3;		//用户名
	public static final int CODE = 4;			//验证码
	public static final int PASSWORD = 5;		//密码
	
	public static final int MSN_NUM = 6;		//MSN
	public static final int QQ_NUM = 7;			//QQ号码
	public static final int PHONE_NUM = 8;		//电话号码
	public static final int MOBILE_NUM = 9;		//手机号码
	
	public static final int EMAIL = 10;			//EMAIL地址

	public static final int ID_CARD_NUMBER = 11;	//身份证号码
	/**
	 * 请求参数验证方法
	 * @param params	Map key为参数验证代号，value为需要验证的参数值
	 * @throws ServiceException
	 */
	public static void paramCheck(Map<Integer, Object> params) throws ServiceException{
		paramCheck(params, false);
	}
	
	/**
	 * 请求参数验证方法,附加sql注入的验证
	 * @param params
	 * @param checkSqlImmit		是否进行sql注入验证
	 * @throws ServiceException
	 */
	public static void paramCheck(Map<Integer, Object> params, boolean checkSqlImmit) throws ServiceException{
		Set<Integer> keySet = params.keySet();
		for(int key:keySet){
			Object param = params.get(key);
			if(param == null || param.toString().length()<=0){
				continue;
			}
			switch(key){
				case USERNAME:
					checkUserName(params.get(key).toString());
					break;
				case TIME:
					checkTime(params.get(key).toString());
					break;
				case KEYWORD:
					checkKeyWord(params.get(key).toString());
					break;
				case PASSWORD:
					checkPassword(params.get(key).toString());
					break;
				case MSN_NUM:
					checkMsnNum(params.get(key).toString());
					break;
				case QQ_NUM:
					checkQqNum(params.get(key).toString());
					break;
				case PHONE_NUM:
					checkPhone(params.get(key).toString());
					break;
				case MOBILE_NUM:
					checkMobile(params.get(key).toString());
					break;	
				case EMAIL:
					checkEmail(params.get(key).toString());
					break;	
				case ID_CARD_NUMBER:
					checkIdCardNumber(params.get(key).toString());
					break;	
			}
			
			checkSqlImmit(params.get(key).toString());
		}
	}
	
	//验证单个参数的sql注入
	public static void checkSqlImmit(String param) throws ServiceException{
		//String reg = "^.*([';]+|(--)+).*$";
		String reg = "^.*([';]+|(--)+)|([<>]+).*$";
		Pattern pattern = Pattern.compile(reg);
		Matcher mat = pattern.matcher(param);
		if(mat.find()){
				throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "禁止使用英文标点符号,请使用中文标点符号");
		}		
	}
	
	//验证多个参数的sql注入
	public static void checkSqlImmit(ArrayList<String> params) throws ServiceException{
		String reg = "^.*([';]+|(--)+)|([<>]+).*$";
		Pattern pattern = Pattern.compile(reg);
		for(String param:params){
			if(param==null){
				continue;
			}
			Matcher mat = pattern.matcher(param);
			if(mat.find()){
				throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "禁止使用英文标点符号,请使用中文标点符号");
			}
		}
	}
	
	private static void checkUserName(String userName) throws ServiceException{		
		String pattern1 = "^[a-zA-Z0-9_\\-\\u0391-\uFFE5]{3,15}$";
        Pattern pattern = Pattern.compile(pattern1);
        Matcher mat = pattern.matcher(userName);
        if (!mat.find()) {
        	throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "用户名格式错误错误");
        }
	}
	private static void checkEmail(String email) throws ServiceException{		
		String pattern1 = "^([a-z0-9A-Z]+[-|\\._]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        Pattern pattern = Pattern.compile(pattern1);
        Matcher mat = pattern.matcher(email);
        if (!mat.find()) {
        	throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "电子邮件格式错误");
        }
	}
	private static void checkTime(String time) throws ServiceException{
		if(time.indexOf(' ')<=0){
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			try {
				format.parse(time);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "时间格式错误");
			}
		}else{
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			try {
				format.parse(time);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "时间格式错误");
			}
		}
	}

	private static void checkKeyWord(String keyWord) throws ServiceException{
		if(keyWord.indexOf(' ')>=0){
			throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "关键字格式错误");
		}
	}
	
	/**
	 * @param password
	 * @throws ServiceException
	 */
	private static void checkPassword(String password) throws ServiceException{
		if(password.length()<6){
			throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "密码格式错误：长度不能小于6");
		}
		if(password.indexOf(' ')>=0){
			throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "密码格式错误:密码不允许出现空格");
		}
		try {
			checkSqlImmit(password);
		} catch(ServiceException e) {
			throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "密码格式错误:密码字符中含有非法字符");
		}
		
	}
	
	private static void checkMsnNum(String msnNum) throws ServiceException{
		String pattern1 = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
        Pattern pattern = Pattern.compile(pattern1);
        Matcher mat = pattern.matcher(msnNum);
        if (!mat.find()) {
        	throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "MSN格式错误");
        }
	}
	
	private static void checkQqNum(String qqNum) throws ServiceException{
		String pattern1 = "^[1-9]\\d{4,8}$";
        Pattern pattern = Pattern.compile(pattern1);
        Matcher mat = pattern.matcher(qqNum);
        if (!mat.find()) {
        	throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "qq号码格式错误");
        }
	}
	
	private static void checkPhone(String phone) throws ServiceException{
		if(phone.indexOf('-')<=0){
			String pattern = "^[1-9]\\d{7,8}$";
			Pattern patterner = Pattern.compile(pattern);
	        Matcher mat = patterner.matcher(phone);
	        if (!mat.find()) {
	        	throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "电话号码格式错误");
	        }
		}else{
			String pattern = "^[0][1-9]{2,3}[-][1-9][0-9]{6,7}$";
			Pattern patterner = Pattern.compile(pattern);
	        Matcher mat = patterner.matcher(phone);
	        if (!mat.find()) {
	        	throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "电话号码格式错误");
	        }
		}
	}
	
	private static void checkMobile(String mobile) throws ServiceException{
		String pattern = "^\\d{11}$";
		Pattern patterner = Pattern.compile(pattern);
		Matcher mat = patterner.matcher(mobile);
		if(!mat.find()){
			throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "手机号码格式错误");
		}
	}
	
	private static void checkIdCardNumber(String idNumber) throws ServiceException{
		if(!IdNumberVerifier.verify(idNumber)){
			throw new ServiceException(ErrorCode.VALIDATOR_PARAM_ERROR, "身份证号码错误");
		}
	}
	
	public static void main(String[] args){
		
	}
}
