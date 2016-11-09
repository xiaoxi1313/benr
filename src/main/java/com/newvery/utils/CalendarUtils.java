package com.newvery.utils;

import java.util.Calendar;
import java.util.Date;

public class CalendarUtils {

	public static final String[] week_names = new String[] {"周一","周二","周三","周四","周五","周六","周日"};
	
	
	private final static int ONE_DAY_TIMES = 86400000;				//一天的毫秒数
	
	public static Date[] getWeek(Date date) {
		
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.setFirstDayOfWeek(Calendar.MONDAY);

		int dayOfWeek = getDayOfWeek(date);
		
		c.add(Calendar.DATE, -dayOfWeek+1);
		
		Date[] weekDays = new Date[7];
		for(int i=0;i<7;i++) {
			weekDays[i] = c.getTime();
			c.add(Calendar.DATE, 1);
		}
		
		return weekDays;
	}
	
	/**
	 * 一个月所有的日时间
	 * @param date
	 * @return
	 */
	public static Date[] getDaysOfMonth(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		
		c.set(Calendar.MONTH, getMonthOfYear(date));		//设置月份
		c.set(Calendar.DATE, 1);
		
		int monthMaxDay = c.getActualMaximum(Calendar.DATE);			//这个月的天数
		
		Date [] monthDays = new Date[monthMaxDay];
		for(int i = 1; i<= monthMaxDay; i++) {
			c.set(Calendar.DATE, i);
			monthDays[i-1] = c.getTime();
		}
		
		return monthDays;
	}
	
	/**
	 * 获取当前日期是星期几， 星期一是一周的开始，（中国标准）
	 * @param date
	 * @return
	 */
	public static int getDayOfWeek(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.setFirstDayOfWeek(Calendar.MONDAY);

		int temp = c.get(Calendar.DAY_OF_WEEK) - 1;
		if(temp == 0) {
			temp = 7;
		}
		return temp;
	}
	
	public static int getMonthOfYear(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		
		return c.get(Calendar.MONTH);
	}
	
	public static int getHour(Date d) {
		Calendar c1 = Calendar.getInstance();
    	c1.setTime(d);
    	
    	return c1.get(Calendar.HOUR_OF_DAY);
	}
	
	/**
	 * 在当前日期基础上加上天数
	 * @param d
	 * @param days
	 * @return
	 */
	public static Date addDay(Date d,int days) {
		Calendar c1 = Calendar.getInstance();
    	c1.setTime(d);
    	
    	c1.add(Calendar.DATE, days);
    	
    	return c1.getTime();
	}
	
	public static Date addHour(Date d,int hours) {
		Calendar c1 = Calendar.getInstance();
    	c1.setTime(d);
    	
    	c1.add(Calendar.HOUR, hours);
    	return c1.getTime();
	}
	
	public static Date addMinute(Date d,int minutes) {
		Calendar c1 = Calendar.getInstance();
    	c1.setTime(d);
    	
    	c1.add(Calendar.MINUTE, minutes);
    	return c1.getTime();
	}
	
	
	public static Date addMonth(Date d,int months) {
		Calendar c1 = Calendar.getInstance();
    	c1.setTime(d);
    	
    	c1.add(Calendar.MONTH, months);
    	
    	return c1.getTime();
	}
	
	public static Date addYear(Date d,int months) {
		Calendar c1 = Calendar.getInstance();
    	c1.setTime(d);
    	
    	c1.add(Calendar.YEAR, months);
    	
    	return c1.getTime();
	}
	
	//是否为同一天
    public static boolean isSameDay(Date d1,Date d2) {
    	Calendar c1 = Calendar.getInstance();
    	c1.setTime(d1);
    	
    	Calendar c2 = Calendar.getInstance();
    	c2.setTime(d2);
    	
    	if(c1.get(Calendar.YEAR) == c2.get(Calendar.YEAR) 
    			&& c1.get(Calendar.DAY_OF_YEAR) == c2.get(Calendar.DAY_OF_YEAR)) {
    		return true;
    	}
    	return false;
    }
	
    /**
     * 两个日期相关的天数
     * @param d1
     * @param d2
     * @return
     */
    public static int getDiffDay(Date d1,Date d2) {
    	
    	
    	return (int)(d1.getTime() - d2.getTime()) / ONE_DAY_TIMES;
    }
    
    
    public static void main(String[] args) {
    	
    	Date date = new Date();
    	Date[] monthDays = getDaysOfMonth(date);
    	for (Date date2 : monthDays) {
			System.out.println(date2);
		}
    	
	}
}
