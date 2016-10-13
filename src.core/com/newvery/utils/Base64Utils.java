package com.newvery.utils;

import sun.misc.BASE64Decoder;

public class Base64Utils {
	public static String getFromBASE64(String s) {
		if (s == null)
			return null;
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			byte[] b = decoder.decodeBuffer(s);
			return new String(b);
		} catch (Exception e) {
			return null;
		}
	}

	public static String getBASE64(String s) {
		if (s == null)
			return null;
		return (new sun.misc.BASE64Encoder()).encode(s.getBytes());
	}
	
	public static String getBASE64(byte[] b) {
		if (b == null)
			return null;
		return (new sun.misc.BASE64Encoder()).encode(b);
	}
}
