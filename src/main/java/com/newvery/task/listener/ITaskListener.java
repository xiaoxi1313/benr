package com.newvery.task.listener;

import com.newvery.exception.ServiceException;
import com.newvery.task.SecurityTask;

public interface ITaskListener {

	//创建监听器所需的上下文
	public ITaskListenerContext createContext();
	
	//判断是否需要对此Task调用监听器
	public boolean beInterested(SecurityTask task);
	
	//事务开始前执行的操作
	public void beforeTransaction(SecurityTask task, ITaskListenerContext context) throws ServiceException;
	
	//任务开始前执行的操作
	public void beforeExecute(SecurityTask task, ITaskListenerContext context) throws ServiceException;

	//任务结束后执行的操作
	public void afterExecute(SecurityTask task, ITaskListenerContext context) throws ServiceException;

	//事务结束后执行的操作
	public void afterTransaction(SecurityTask task, ITaskListenerContext context) throws ServiceException;
	
	//任务执行出错时执行的操作
	public void onError(SecurityTask task, Throwable e, ITaskListenerContext context);
}
