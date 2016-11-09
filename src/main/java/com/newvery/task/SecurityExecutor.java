package com.newvery.task;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import com.newvery.ErrorCode;
import com.newvery.dal.dao.BaseDao;
import com.newvery.exception.ServiceException;
import com.newvery.task.listener.ITaskListener;
import com.newvery.task.listener.ITaskListenerContext;
import com.newvery.task.listener.TaskListenerFactory;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.newvery.dal.dao.factory.ManagerImplFactory;

/**
 * 任务执行器：
 * 执行器是一个业务层的切面，所有针对数据库的写操作都应该通过执行器来执行对应的Task来实现。
 * 执行器还负责控制事务————保证一个Task中所有的DAO操作都在同一个事务中。
 * 这个业务层的切面控制还可以通过TaskListener机制扩展。
 *
 */
public class SecurityExecutor implements ISecurityExecutor, IDaoManagerFactory {
	private static Log logger = LogFactory.getLog(SecurityExecutor.class);
	
	/**
	 * 由Spring注入的数据库事务管理器，
	 * 配置见 config/spring/SpringExecutor.xml
	 */
	private DataSourceTransactionManager transactionManager;
	
	 
	
	/**
	 * 由Spring注入的数据库对应的Hibernate SessionFactory对象，
	 * 配置见 config/spring/SpringExecutor.xml
	 */
	private SqlSessionTemplate sqlSessionTemplate;

	/**
	 * 数据库对应的Dao对象的构造器
	 */
	private ManagerImplFactory managerFactory = new ManagerImplFactory();

	/**
	 * 任务监听器列表
	 */
	private List<ITaskListener> taskListeners = new LinkedList<ITaskListener>();
	
	/**
	 * 私有构造函数，实例必须通过spring来构造
	 */
	protected SecurityExecutor() {
		super();
	}


	public ManagerImplFactory getManagerFactory() {
		return managerFactory;
	}

	public void setManagerFactory(ManagerImplFactory managerFactory) {
		this.managerFactory = managerFactory;
	}

	/**
	 * 构造数据库访问对应的DAO对象
	 */
	public BaseDao getManagerImpl(Class<? extends BaseDao> cl) {
		try {
			return getManagerFactory().getInstance(cl, getSqlSessionTemplate());
		} catch (ServiceException e) {
			e.printStackTrace();
			return null;
		}
	}

	public void setTaskListeners(List<String> listenerClasses) {
		getTaskListeners().clear();
		
		for (String className : listenerClasses) {
			ITaskListener listener = TaskListenerFactory.createListener(className);
			if (listener != null) {
				getTaskListeners().add(listener);
			}
		}
	}

	public List<ITaskListener> getTaskListeners() {
		return taskListeners;
	}
	
	/**
	 * 对Task调用监听器的事务前处理方法
	 * @param task
	 * @param contexts
	 * @throws ServiceException
	 */
	public void fireBeforeTransaction(SecurityTask task, Map<ITaskListener, ITaskListenerContext> contexts) throws ServiceException {
		for (ITaskListener listener : getTaskListeners()) {
			if (listener.beInterested(task)) {
				//创建该Listener的上下文
				ITaskListenerContext context = listener.createContext();
				contexts.put(listener, context);
				
				listener.beforeTransaction(task, context);
			}
		}
	}

	/**
	 * 对Task调用监听器的执行前处理方法
	 * @param task
	 * @param contexts
	 * @throws ServiceException
	 */
	public void fireBeforeExecute(SecurityTask task, Map<ITaskListener, ITaskListenerContext> contexts) throws ServiceException {
		for (ITaskListener listener : getTaskListeners()) {
			ITaskListenerContext context = contexts.get(listener);
			if (listener.beInterested(task)) {
				listener.beforeExecute(task, context);
			}
		}
	}

	/**
	 * 对Task调用监听器的执行后处理方法
	 * @param task
	 * @param contexts
	 * @throws ServiceException
	 */
	public void fireAfterExecute(SecurityTask task, Map<ITaskListener, ITaskListenerContext> contexts) throws ServiceException {
		
		for (ITaskListener listener : getTaskListeners()) {
			ITaskListenerContext context = contexts.get(listener);
			if (listener.beInterested(task)) {
				listener.afterExecute(task, context);
			}
		}
	}
	
	/**
	 * 对Task调用监听器的事务后处理方法
	 * @param task
	 * @param contexts
	 * @throws ServiceException
	 */
	public void fireAfterTransaction(SecurityTask task, Map<ITaskListener, ITaskListenerContext> contexts) throws ServiceException {
		for (ITaskListener listener : getTaskListeners()) {
			ITaskListenerContext context = contexts.get(listener);
			if (listener.beInterested(task)) {
				listener.afterTransaction(task, context);
			}
		}
	}

	/**
	 * 对Task调用监听器的错误处理方法
	 * @param task
	 * @param e
	 * @param contexts
	 */
	public void fireError(SecurityTask task, Throwable e, Map<ITaskListener, ITaskListenerContext> contexts) {
		for (ITaskListener listener : getTaskListeners()) {
			ITaskListenerContext context = contexts.get(listener);
			if (listener.beInterested(task)) {
				listener.onError(task, e, context);
			}
		}
	}

	/**
	 * 执行Task（包括开始和结束事务），触发对应的TaskListener
	 * 如果需要进行串行处理，则获取Task对应的锁对象进行加锁执行
	 * @param	task
	 * @return	task执行的返回结果
	 * @throws	ServiceException
	 */
	public Object exec(SecurityTask task) throws ServiceException {
		//如果Task需要串行处理，则获取其锁对象，在加锁的环境下执行Task
		if (task instanceof SynchronizedTask) {
			Object lock = ((SynchronizedTask)task).getLock();
			if (lock != null) {
				synchronized (lock) {
					return doExec(task);
				}
			}
		}

		return doExec(task);
	}
	
	/**
	 * 事务初始化，构造数据库相关的事务对象
	 * 
	 */
	protected Stack<TransactionEntry> beginTransaction(SecurityTask task) throws ServiceException {
		Stack<TransactionEntry> stack = new Stack<TransactionEntry>();
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = getTransactionManager().getTransaction(def);
		
		stack.push(new TransactionEntry(status, getTransactionManager()));
		
		return stack;
	}
	
	/**
	 * 事务提交，
	 * 注意：提交的顺序和事务构造的顺序相反（对应出栈操作）
	 * 
	 */
	protected void commitTransaction(SecurityTask task, Stack<TransactionEntry> stack) throws ServiceException {
		while (!stack.isEmpty()) {
			TransactionEntry entry = stack.pop();
			entry.getTransactionManager().commit(entry.getStatus());
		}
	}
	
	/**
	 * 事务回滚，
	 * 注意：回滚的顺序和事务构造的顺序相反（对应出栈操作）
	 * 
	 */
	protected void rollbackTransaction(SecurityTask task, Stack<TransactionEntry> stack) throws ServiceException {
		while (!stack.isEmpty()) {
			TransactionEntry entry = stack.pop();
			entry.getTransactionManager().rollback(entry.getStatus());
		}
	}
	
	/**
	 * 依赖注入————对Task注入的DAO对象构造器
	 * 
	 */
	protected void injectDaoManagerFactory(SecurityTask task) throws ServiceException {
		task.setDaoManagerFactory(this);
	}
	
	/**
	 * 依赖解除————对Task解除注入的DAO对象构造器
	 * 
	 */
	protected void unInjectDaoManagerFactory(SecurityTask task) throws ServiceException {
		task.setDaoManagerFactory(null);
	}
	
	/**
	 * 执行Task————调用Task的exec方法
	 * 讲这个简单的调用也封装为一个函数的目的是为了可以在子类中进行重载
	 * 
	 */
	protected Object execTask(final SecurityTask task) throws ServiceException {
		return task.exec();
	}
	
	/**
	 * 执行Task————开始/结束事务，并触发各个相关的监听器
	 * ！这是SecurityExecutor中最最重要的方法！
	 * 
	 */
	protected Object doExec(final SecurityTask task) throws ServiceException {
		Object obj = null;
		
		Map<ITaskListener, ITaskListenerContext> contexts = 
			new HashMap<ITaskListener, ITaskListenerContext>(); 
		
		try {
			//触发事务前处理监听器
			fireBeforeTransaction(task, contexts);

			//事务处理
			Stack<TransactionEntry> transactionStack = beginTransaction(task);
	
			try {
				//用户DAO对象依赖注入
				injectDaoManagerFactory(task);

				//触发前处理监听器
				fireBeforeExecute(task, contexts);
		
				//调用Task的exec方法
				obj = execTask(task);
	
				//触发后处理监听器
				fireAfterExecute(task, contexts);
				
				//用户DAO对象依赖解除
				unInjectDaoManagerFactory(task);

			} catch (ServiceException e) {
				//e.printStackTrace();

				//触发错误监听器
				fireError(task, e, contexts);
				
				//回滚事务
				logger.error("执行[" + task.getClass().getName() + "]失败：" + e.getMessage() + "，回滚事务");
				rollbackTransaction(task, transactionStack);

				throw e;
			} catch (Throwable e) {
				e.printStackTrace();

				//触发错误监听器
				fireError(task, e, contexts);

				//回滚事务
				logger.error("执行[" + task.getClass().getName() + "]失败：" + e.getMessage() + "，回滚事务");
				rollbackTransaction(task, transactionStack);

				throw new ServiceException(ErrorCode.UNKNOWN_INTERNAL_ERROR, "未知错误" + e.getMessage(), e);
			}

			//提交事务
			commitTransaction(task, transactionStack);

			//触发事务后处理监听器
			fireAfterTransaction(task, contexts);

		} catch (TransactionException e) {
			e.printStackTrace();
			throw new ServiceException(ErrorCode.UNKNOWN_INTERNAL_ERROR, "事务错误" + e.getMessage(), e);
		}
		
		return obj;
	}

	public SqlSessionTemplate getSqlSessionTemplate() {
		return sqlSessionTemplate;
	}

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}


	public DataSourceTransactionManager getTransactionManager() {
		return transactionManager;
	}


	public void setTransactionManager(
			DataSourceTransactionManager transactionManager) {
		this.transactionManager = transactionManager;
	}

	
}
