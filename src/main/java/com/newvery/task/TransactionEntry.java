package com.newvery.task;

import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionStatus;

public class TransactionEntry {
	private TransactionStatus status;
	private DataSourceTransactionManager transactionManager;
		
	public TransactionEntry(TransactionStatus status,DataSourceTransactionManager transactionManager) {
		super();
		this.status = status;
		this.transactionManager = transactionManager;
	}
	
	public TransactionStatus getStatus() {
		return status;
	}
	public void setStatus(TransactionStatus status) {
		this.status = status;
	}
	public DataSourceTransactionManager getTransactionManager() {
		return transactionManager;
	}
	public void setTransactionManager(DataSourceTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}
}
