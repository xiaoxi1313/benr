package com.newvery.utils;


public class Tools {
	public final static boolean checkStrIsNotNull(String s){
		if(s==null)
			return false;
		if("".equals(s))
			return false;
		return true;
	}
	
}
