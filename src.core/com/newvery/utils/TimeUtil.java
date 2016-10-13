package com.newvery.utils;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

/**
 * 
 * @author zhanggs
 * 
 */
public class TimeUtil {

	static public final String FORMAT_DATE_ONLY = "yyyy-MM-dd";
	static public final String FORMAT_TIME_ONLY = "HH:mm:ss";
	static public final String FORMAT_TIMESECOND_ONLY = "HH:mm";	
	static public final String FORMAT_COMPACT = "yyyyMMddHHmmss";
	static public final String FORMAT_NORMAL = "yyyy-MM-dd HH:mm:ss";
	static public final String FORMAT_DETAIL = "yyyy-MM-dd HH:mm:ss.SSS";
	static public final String FORMAT_NO_SECOND = "yyyy-MM-dd HH:mm";
	static public final String FORMAT_CHAIN_SECOND = "yyyy-MM-dd E HH:mm";
	static public final String FORMAT_CHAIN_ONLY = "yyyy年MM月dd日";	
	static public final String FORMAT_MONTH_DAY_ONLY = "MM-dd";	
	
	static public final long DATE_SECOND=86400;//一天有86400秒 
	static public final long DATE_MINUTE=1440;//一天有1440分
	static public final long MINUTE_SECOND=60;//一天有60分
	
	public final static int ONE_DAY_TIMES = 86400000;				//一天的毫秒数
	
	private static final long ONE_MINUTE = 60000L;  
    private static final long ONE_HOUR = 3600000L;  
    private static final long ONE_DAY = 86400000L;  
    private static final long ONE_WEEK = 604800000L;  
  
    private static final String ONE_SECOND_AGO = "秒前";  
    private static final String ONE_MINUTE_AGO = "分钟前";  
    private static final String ONE_HOUR_AGO = "小时前";  
    private static final String ONE_DAY_AGO = "天前";  
    private static final String ONE_MONTH_AGO = "月前";  
    private static final String ONE_YEAR_AGO = "年前";  
	
	public static Date parse(String str, String format) {
		try {
			SimpleDateFormat sf = new SimpleDateFormat(format);
			sf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
			return sf.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
			return null;
		}
	}

	public static String format(Date date, String format) {
		SimpleDateFormat sf = new SimpleDateFormat(format);
		sf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
		return sf.format(date);
	}
	
	public static String format(Timestamp date, String format) {
		SimpleDateFormat sf = new SimpleDateFormat(format);
		sf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
		return sf.format(date);
	}

	public static boolean isExpire(String strTime, String strExpiredTime) {
		Date time = parse(strTime, FORMAT_NORMAL);
		Date expiredTime = parse(strExpiredTime, FORMAT_NORMAL);

		return (time.compareTo(expiredTime) >= 0);
	}

	/**
	 * 生成制定日期的Date对象，从0点开始
	 * 
	 * @param year
	 * @param month
	 * @param days
	 * @return
	 */
	public static Date createDate(int year, int month, int days) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, days, 0, 0, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	/**
	 * 计算时间差
	 * 
	 * @param beginTime
	 *            开始时间，格式：yyyy-MM-dd HH:mm:ss
	 * @param endTime
	 *            结束时间，格式：yyyy-MM-dd HH:mm:ss
	 * @return 从开始时间到结束时间之间的时间差（秒）
	 */
	public static long getTimeDifference(String beginTime, String endTime) {
		long between = 0;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date end = null;
		Date begin = null;
		try {// 将截取到的时间字符串转化为时间格式的字符串
			end = sdf.parse(endTime);
			begin = sdf.parse(beginTime);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		between = (end.getTime() - begin.getTime()) / 1000;// 除以1000是为了转换成秒

		return between;
	}
	
	
	
	public static String getTimeDifference(Date beginTime, Date endTime) {

		long between = endTime.getTime() - beginTime.getTime() ;
		if (between <= 0){
			return "已过期";
		}
		
		between = between / 1000;// 除以1000是为了转换成秒
		long date = between / DATE_SECOND;
		long hour = (between - date * DATE_SECOND)/3600;
		long minute = (between -date * DATE_SECOND - hour*3600) / 60;
		long sec = (between -date * DATE_SECOND - hour*3600 - minute*60) ;
		if (date == 0) {
			return hour + "小时" + minute + "分钟"+ sec + "秒";
		}
		else {
			return  date + "天" + hour + "小时" + minute + "分钟" + sec + "秒";
		}
	}
	//得到X天X小时时间
	public static String getDateExplain(long second){
		String time = "";
		long hourCount_ = second / 3600;
		long dayCount_ = hourCount_ / 24;
		long remnantHour = hourCount_ % 24;
		if(dayCount_ != 0) time = dayCount_ + "天";
		if(remnantHour != 0) time += remnantHour + "小时";
		return time;
	}
	//得到当前时间后x天的日期
    public static Date getFutrueDate(Date oldDate,int addDay) {
        Calendar c = Calendar.getInstance();
        c.setTime(oldDate);
        c.add(Calendar.DATE, addDay);

        return c.getTime();
    }
    //得到当前时间后x天的日期
    public static Date getFutrueDate(String oldDate,int addDay) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(parse(oldDate,FORMAT_DATE_ONLY));
    	c.add(Calendar.DATE, addDay);
    	
    	return c.getTime();
    }
    
    public static Date getFutrueYear(Date oldDate,int addYear) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(oldDate);
    	c.add(Calendar.YEAR, addYear);
    	
    	return c.getTime();
    }
    
    //比较两日期大小.
    public static String compare(Date d1,Date d2){
        Calendar c1 = Calendar.getInstance();
        c1.setTime(d1);
        
        Calendar c2 = Calendar.getInstance();
        c2.setTime(d2);
        
        if(c1.after(c2)){
            return ">";
        } else if(c1.before(c2)){
        	return "<";
        } else {
        	return "=";
        }
    }
    
    public static int getDayOfWeek(Date d) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(d);
    	int day =  c.get(Calendar.DAY_OF_WEEK) - 1;
    	if(day < 1) {
    		day = 7;
    	}
    	return day;
    }
    
    public static int getYear(Date d) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(d);
    	return c.get(Calendar.YEAR);
    }
    
    /**
     * 获取小时
     * @param d
     * @return
     */
    public static int getHour(Date d) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(d);
    	return c.get(Calendar.HOUR_OF_DAY);
    }
    
    /**
     * 获取秒
     * @param d
     * @return
     */
    public static int getMinute(Date d) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(d);
    	return c.get(Calendar.MINUTE);
    }
    
    //比较两日期大小
    public static String compare(String s1,String s2){
        Date d1 = parse(s1,FORMAT_DATE_ONLY);
        Date d2 = parse(s2,FORMAT_DATE_ONLY);
        Calendar c1 = Calendar.getInstance();
        Calendar c2 = Calendar.getInstance();
        c1.setTime(d1);
        c2.setTime(d2);
        if(c1.after(c2)){
            return ">";
        } else if(c1.before(c2)){
        	return "<";
        } else {
        	return "=";
        }
    }
	
    /**
     * 获取当前时间X月的开始日期
     * @param d
     * @param addMonth
     */
    public static Date getFutureMonthStartDate(Date d,int addMonth) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(d);
    	c.add(Calendar.MONTH, addMonth);
    	c.set(Calendar.DAY_OF_MONTH, 1);
    	return c.getTime();
    }
    
    public static Date getFutureMonthEndDate(Date d,int addMonth) {
    	Calendar c = Calendar.getInstance();
    	c.setTime(d);
    	c.add(Calendar.MONTH, addMonth + 1);
    	c.set(Calendar.DAY_OF_MONTH, 1);
    	c.add(Calendar.DATE, -1);
    	return c.getTime();
    }
    
    public static Date getDayStartTime(Date d){
    	 Calendar startTime = Calendar.getInstance();  
    	 startTime.setTime(d);
    	 startTime.set(Calendar.HOUR_OF_DAY, 0);  
    	 startTime.set(Calendar.MINUTE, 0);  
    	 startTime.set(Calendar.SECOND, 0);  
    	 startTime.set(Calendar.MILLISECOND, 0);  
         return startTime.getTime();  
    }
    
    public static Date getDayEndTime(Date d){
    	Calendar endTime = Calendar.getInstance();  
    	endTime.setTime(d);
    	endTime.set(Calendar.HOUR_OF_DAY, 23);  
    	endTime.set(Calendar.MINUTE, 59);  
    	endTime.set(Calendar.SECOND, 59);  
    	endTime.set(Calendar.MILLISECOND, 999);    	
        return endTime.getTime();  
   }
    
    /**
     * 刚刚、几分钟前、几天前
     * @param date
     * @return
     */
    public static String formatDateBefore(Date date) {  
        long delta = new Date().getTime() - date.getTime();  
        if (delta < 1L * ONE_MINUTE) {  
            long seconds = toSeconds(delta);  
            return (seconds <= 0 ? 1 : seconds) + ONE_SECOND_AGO;  
        }  
        if (delta < 45L * ONE_MINUTE) {  
            long minutes = toMinutes(delta);  
            return (minutes <= 0 ? 1 : minutes) + ONE_MINUTE_AGO;  
        }  
        if (delta < 24L * ONE_HOUR) {  
            long hours = toHours(delta);  
            return (hours <= 0 ? 1 : hours) + ONE_HOUR_AGO;  
        }  
        if (delta < 48L * ONE_HOUR) {  
            return "昨天";  
        }  
        if (delta < 30L * ONE_DAY) {  
            long days = toDays(delta);  
            return (days <= 0 ? 1 : days) + ONE_DAY_AGO;  
        }  
        if (delta < 12L * 4L * ONE_WEEK) {  
            long months = toMonths(delta);  
            return (months <= 0 ? 1 : months) + ONE_MONTH_AGO;  
        } else {  
            long years = toYears(delta);  
            return (years <= 0 ? 1 : years) + ONE_YEAR_AGO;  
        }  
    }  
  
    private static long toSeconds(long date) {  
        return date / 1000L;  
    }  
  
    private static long toMinutes(long date) {  
        return toSeconds(date) / 60L;  
    }  
  
    private static long toHours(long date) {  
        return toMinutes(date) / 60L;  
    }  
  
    private static long toDays(long date) {  
        return toHours(date) / 24L;  
    }  
  
    private static long toMonths(long date) {  
        return toDays(date) / 30L;  
    }  
  
    private static long toYears(long date) {  
        return toMonths(date) / 365L;  
    }  

	public static void main(String[] args) throws ParseException {
		
		Date d= new Date();
		
		//上个月开始日期
		System.out.println(TimeUtil.format(getFutureMonthStartDate(d, -1), FORMAT_DATE_ONLY));
		
		//上个月结束日期
		System.out.println(TimeUtil.format(getFutureMonthEndDate(d, -1), FORMAT_DATE_ONLY));
		
		
	}
}
