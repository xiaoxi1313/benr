package com.newvery.utils;

import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Random;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 字符串工具类
 * @author Administrator
 *
 */
public class StringUtil {
	static private DecimalFormat decimalFormat = new DecimalFormat("#0.00");
	static public Random secureRand = new Random(new Date().getTime());
	
	/**
	 * 字符串转换成数组
	 * @return
	 */
	public static String[] tokenizeToStringArray(String str, String delimiters) {
		return tokenizeToStringArray(str, delimiters, true, true);
	}

	public static String[] tokenizeToStringArray(String str, String delimiters, boolean trimTokens,
			boolean ignoreEmptyTokens) {
		if (str == null) {
			return null;
		}
		StringTokenizer st = new StringTokenizer(str, delimiters);
		List<String> tokens = new ArrayList<String>();
		while (st.hasMoreTokens()) {
			String token = st.nextToken();
			if (trimTokens) {
				token = token.trim();
			}
			if (!ignoreEmptyTokens || token.length() > 0) {
				tokens.add(token);
			}
		}
		return (String[]) tokens.toArray(new String[tokens.size()]);
	}

	/**
	 * @param str
	 * @return
	 */
	public static String toUpperCase(String str) {
		return str == null ? null : str.toUpperCase();
	}

	/**
	 * @param str
	 * @return
	 */
	public static String toLowerCase(String str) {
		return str == null ? null : str.toLowerCase();
	}

	/**
	 * @param ids
	 * @return
	 */
	public static String idArrayToString(Object[] ids) {
		if ((ids == null) || (ids.length == 0)) {
			return "";
		}

		String result = "";

		for (int i = 0; i < ids.length; i++) {
			result += ("" + ids[i] + ",");
		}

		result = result.substring(0, result.length() - 1);

		return result;
	}
	
	/**
	 * @param ids
	 * @return
	 */
	public static String idArrayToString(int[] ids) {
		if ((ids == null) || (ids.length == 0)) {
			return "''";
		}

		String result = "";

		for (int i = 0; i < ids.length; i++) {
			result += ("'" + ids[i] + "',");
		}
		result = result.substring(0, result.length() - 1);
		return result;
	}
	
	public static String idArrayToString(Integer[] ids) {
		if ((ids == null) || (ids.length == 0)) {
			return "";
		}

		String result = "";

		for (int i = 0; i < ids.length; i++) {
			result += ("" + ids[i] + ",");
		}
		result = result.substring(0, result.length() - 1);
		return result;
	}
	
	/**
	 * 字符串数组用分隔符连接
	 * @param data
	 * @param delimiters
	 * @return
	 */
	public static String arrayToString(String[] data,String delimiters) {
		 if ((data == null) || (data.length == 0)) {
			return "''";
		}
		String result = "";
		for (int i = 0; i < data.length; i++) {
			if(data[i] != null) {
				result += (data[i] + delimiters);
			}
		}
		result = result.substring(0, result.length() - 1);

		return result;
	}
	
	/**
	 * 删除字符数组中某一元素
	 * @param input
	 * @param removeString
	 * @return
	 */
	public static String[] removeString(String[] input,String removeString) {
		List<String> result = new LinkedList<String>();
		for (String item : input) {
			if(!removeString.equals(item)) {
				result.add(item);
			}
		}
		return result.toArray(input);
	}
	
	/**
	 * @param ids
	 * @return
	 */
    public static String idArrayToString(long[] ids) {
        if ((ids == null) || (ids.length == 0)) {
            return "";
        }

        String result = "";

        for (int i = 0; i < ids.length; i++) {
            result += ("" + ids[i] + ",");
        }

        result = result.substring(0, result.length() - 1);

        return result;
    }

	/**
	 * 功能：将字符串数据转换成ArrayList
	 * @param strArray
	 * @return
	 */
	public static List<String> toArrayList(String[] strArray) {
		List<String> result = new ArrayList<String>();
		if (null == strArray || strArray.length == 0) {
			return result;
		}

		for (int i = 0; i < strArray.length; i++) {
			result.add(strArray[i]);
		}

		return result;
	}

	/**
	 * @param oriStr
	 * @param c
	 * @return
	 */
	public static String trim(String oriStr, String c) {
		return oriStr.replaceAll(c, "");
	}

	/**
	 * @param str
	 * @return
	 */
	public static String isNull(String str){
		if(str == null) {
			return null;
		}
		if(str != null && str.trim().length() ==0 ){
			return null;
		}else{
			return str;
		}
	}

	/**
	 * 把null转换""
	 * @param str
	 * @return
	 */
	public static String charNull(String str){
		if(str == null){
			return "";
		}else{
			return str;
		}
	}
	
	/**
	 * 过滤字符串中的无效字�?
	 * @param str
	 * @return
	 */
	public static String replaceEnter(String str){
	
		return str.replaceAll("\\s*","");
	}
	
	public static String unicode(byte []oriData){
		String strData =null;
		try {
			if (oriData.length > 2) {
				if (oriData[0] != 0xFF && oriData[1] != 0xFE) {
					byte[]unicodeData  = new byte[oriData.length + 2];	
					unicodeData[0] = (byte)0xFF;
					unicodeData[1] = (byte)0xFE;
					System.arraycopy(oriData, 0, unicodeData, 2, oriData.length);
					
					oriData = unicodeData;
				}
				if(oriData[oriData.length-1]==0x0 && oriData[oriData.length-2]==0x0)
					strData = new String(oriData,0,oriData.length-2, "UNICODE");
				else{
					strData = new String(oriData, "UNICODE");
				}
				
			}
		} catch (UnsupportedEncodingException e) {
			strData = null;
			e.printStackTrace();
		}

		
		return strData;
	}
	
	/**
	 * 产生随机的字符串（大小写字母和数字的组合
	 * @param size 指定长度
	 * @return
	 */
	public static String getRandomString(int size) {// 随机字符�?
		char[] c = { 
			'1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 
			'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 
			'u', 'v', 'w', 'x', 'y', 'z',
			'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 
			'U', 'V', 'W', 'X', 'Y', 'Z' 
		};
		
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < size; i++) {
			sb.append(c[Math.abs(secureRand.nextInt()) % c.length]);
		}
		return sb.toString();
	}
	
	/**
	 * 产生随机的字符串
	 * @param size 指定长度
	 * @return
	 */
	public static String getRandomNumber(int size) {// 随机字符�?
		char[] c = { '1', '2', '3', '4', '5', '6', '7', '8', '9', '0'};
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < size; i++) {
			sb.append(c[Math.abs(secureRand.nextInt()) % c.length]);
		}
		return sb.toString();
	}
	
	/**
	 * 把double类型数字专函成money格式(保留两位小数,不足两位�?补齐,超过两位四舍五入)
	 * @param money double类型数字
	 * @return 
	 */
	public static String formatMoney(double money){
		if(money==0){
			return "0.00";
		}else{
			return decimalFormat.format(money);
		}
	}
	
	public static String formatMoney(long money){
		if(money==0){
			return "0.00";
		}else{
			return decimalFormat.format(money);
		}
	}
	
	/**
	 * 在字符串左端补齐
	 */
	public static String leftPadding(String text, int len, char c){
		StringBuffer buffer = null;
		int curSize = 0;
		
		if (text != null) {
			curSize = text.length();
			buffer = new StringBuffer(text);
		}
		else {
			curSize = 0;
			buffer = new StringBuffer();
		}

		for (;curSize < len; curSize++){
			buffer.insert(0, c);
		}
		
		return buffer.toString();
	}

	/**
	 * 在字符串右端补齐
	 */
	public static String rightPadding(String text, int len, char c){
		StringBuffer buffer = null;
		int curSize = 0;
		
		if (text != null) {
			curSize = text.length();
			buffer = new StringBuffer(text);
		}
		else {
			curSize = 0;
			buffer = new StringBuffer();
		}

		for (;curSize < len; curSize++){
			buffer.append(c);
		}
		
		return buffer.toString();
	}
	
	/**
	 * @param fileName
	 * @return
	 */
	public static String getFileSuffix(String fileName) {
		String type = "";
		if (fileName == null || fileName.equals(""))
			return type;
		int position = fileName.lastIndexOf(".");
		if (position != -1) {
			type = fileName.substring(position + 1, fileName.length());
		}
		return type;
	}
	
	/**
	 * @param splitMsg
	 * @param splitNum
	 * @return
	 */
	public static String[] getSplitByNumber(String splitMsg,int splitNum) {
		List<String> msgs = new ArrayList<String>();
		if(splitMsg.length() <= splitNum) {
			return new String[]{splitMsg};
		}
		while(splitMsg != null) {
			String msg = null;
			if(splitMsg.length() > splitNum) {
				msg = splitMsg.substring(0,splitNum);
				splitMsg = splitMsg.substring(splitNum);
			} else {
				msg = splitMsg.substring(0);
				splitMsg = null;
			}
			msgs.add(msg);
		}
		
		return msgs.toArray(new String[msgs.size()]);
	}
	/**
	 * @param str
	 * @return
	 */
	public static String hideAnyStr(String str){
		String s = "";
		
		if(str != null && str.length() > 12){
			s = str.substring(0,4) + "****" + str.substring(str.length()-4,str.length());
		}else if(str != null && str.length() > 8){
			s = str.substring(0,3) + "****" + str.substring(str.length()-3,str.length());
		}
		
		return s;
	}
	
	public static String replaceByPosition(String str , int position,char replaceChar) {
		if(str == null) {
			return null;
		}
		
		char[] chars = str.toCharArray();
		chars[position] = replaceChar;
		
		return new String(chars);
	}
	
	public static boolean isDouble(String str) {    
	    Pattern pattern = Pattern.compile("^[-\\+]?[.\\d]*$");    
	    return pattern.matcher(str).matches();    
	  } 
	
	public static boolean isInteger(String str) {    
	    Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");    
	    return pattern.matcher(str).matches();    
	}  
	
	public static boolean isNumeric(String str){
		if(isNull(str) == null) {
			return false;
		}
		if(str.matches("\\d*")){
			return true;
		}
		return false;
	}
	
	public static boolean isMobile(String mobile) {
		if(mobile == null) return false;
		Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");  
		Matcher m = p.matcher(mobile);  
		return m.matches();  
	}
	
	public static String subStringCN(final String str, final int maxLength) {
		if (str == null) {
			return str;
		}
		String suffix = ".........";
		int suffixLen = suffix.length();
		final StringBuffer sbuffer = new StringBuffer();
		final char[] chr = str.trim().toCharArray();
		int len = 0;
		for (int i = 0; i < chr.length; i++) {
			if (chr[i] >= 0xa1) {
				len += 2;
			} else {
				len++;
			}
		}
		if (len <= maxLength) {
			return str;
		}
		len = 0;
		for (int i = 0; i < chr.length; i++) {
			if (chr[i] >= 0xa1) {
				len += 2;
				if (len + suffixLen > maxLength) {
					break;
				} else {
					sbuffer.append(chr[i]);
				}
			} else {
				len++;
				if (len + suffixLen > maxLength) {
					break;
				} else {
					sbuffer.append(chr[i]);
				}
			}
		}
		sbuffer.append(suffix);

		return sbuffer.toString();

	}
	
	public static boolean isEmail(String email) {
		String reg = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";  
		 Pattern regex = Pattern.compile(reg);  
		 Matcher matcher = regex.matcher(email);  
		 return  matcher.matches();  
	}
	
}
