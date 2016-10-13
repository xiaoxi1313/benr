package com.newvery.utils;

import java.text.DecimalFormat;

public class DecimalUtils {
	
	public static String format(double number) {
		DecimalFormat df1 = new DecimalFormat("####.0");
		df1.setGroupingUsed(false);
		
		return df1.format(number);
	}

	public static double formatD2_Double(double number) {
		return Double.parseDouble(formatD2_String(number));
	}
	
	public static String formatD2_String(double number) {
		DecimalFormat df1 = new DecimalFormat("####.00");
		return df1.format(number);
	}
	
}
