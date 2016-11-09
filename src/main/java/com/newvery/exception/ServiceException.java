package com.newvery.exception;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class ServiceException extends Exception {
	private static final long serialVersionUID = 1L;
	
	private static Log log = LogFactory.getLog(ServiceException.class);
	
	private int errorCode;
	
	public ServiceException(int errorCode,String errorString) {
		super(errorString);
		this.errorCode = errorCode;
		
		log.error("ServiceException: errorCode=" + errorCode + ", errorString=" + errorString, this);
	}

	public ServiceException(int errorCode,String errorString,Throwable cause) {
		this(errorCode,errorString);
		log.error("ServiceException: errorCode=" + errorCode + ", errorString=" + errorString, this);
	}
	
	public int getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(int errorCode) {
		this.errorCode = errorCode;
	}
	
}
