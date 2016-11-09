package com.newvery.utils;

import com.newvery.exception.ServiceException;

public class OrderUtils {

	
	public static long getOrderUserId(String orderNo) throws ServiceException {
		try {
			if(orderNo.indexOf("O") != -1) {//老的订单序号
				return Long.valueOf(orderNo.substring(13)); 
			} else {
				return Long.valueOf(orderNo.substring(11)); 
			}
		} catch(Exception ex) {
			throw new ServiceException(-222, "根据订单号转换成用户发生错误" + ex.getMessage());
		}
		
	}
}
