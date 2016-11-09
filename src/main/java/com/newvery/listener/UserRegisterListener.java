package com.newvery.listener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.newvery.exception.ServiceException;
import com.newvery.task.SecurityTask;
import com.newvery.task.listener.ITaskListener;
import com.newvery.task.listener.ITaskListenerContext;
import com.newvery.task.um.UserRegisterTask;

public class UserRegisterListener implements ITaskListener {
	private Log logger = LogFactory.getLog(UserRegisterListener.class);
	@Override
	public ITaskListenerContext createContext() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean beInterested(SecurityTask task) {
		if (task instanceof UserRegisterTask)
			return true;
		return false;
	}

	@Override
	public void beforeTransaction(SecurityTask task,
			ITaskListenerContext context) throws ServiceException {
		// TODO Auto-generated method stub

	}

	@Override
	public void beforeExecute(SecurityTask task, ITaskListenerContext context)
			throws ServiceException {
		// TODO Auto-generated method stub

	}

	@Override
	public void afterExecute(SecurityTask task, ITaskListenerContext context) throws ServiceException {
//		if (task instanceof UserRegisterTask) {
//			UserRegisterTask userRegisterTask = (UserRegisterTask)task;
//			long userId = userRegisterTask.getUser().getId();
//			String userCode=userRegisterTask.getUser().getUserCode();
//			boolean hasCouponCode = true;
//			
//			/**
//			//判断用户粉丝数是否超过预定值
//			int followers = userRegisterTask.getWeiboUser().getFollowersCount();
//			if(followers>ConfigManager.getInstance().getUserMaxFollowers()){
//				hasCouponCode = false;
//				logger.info("用户注册初始化 粉丝数超过上限不允许分配折扣码：用户粉丝数="+followers);
//			}else{
//				//判断用户是否在黑名单里面
//				BlackUserRecord blackUser = userRegisterTask.getUserDao().findBlackUserByCode(userCode);
//				if(null!=blackUser&&blackUser.getId()>0){
//					hasCouponCode = false;
//					logger.info("用户注册初始化 在黑名单中不允许分配折扣码：用户号="+blackUser.getUserCode()+";用户名="+blackUser.getUserName());
//				}
//			}**/
//			
//			if(hasCouponCode){
//				//初始化分配用户折扣码
//				String couponCode = String.valueOf(996886l+userId);
////				String couponCode = TimeUtil.format(new Date(),"yyyyMMdd")+RandomUtils.generateRandom(5); 
////				while (null != BeanFactory.getUserDao().findUserByCouponCode(couponCode)) {
////					couponCode = TimeUtil.format(new Date(),"yyyyMMdd")+RandomUtils.generateRandom(5);
////				}
//				userRegisterTask.getUserDao().updateUserCouponCode(userId, couponCode);
//				userRegisterTask.getUser().setCouponCode(couponCode);
//				//logger.info("用户注册初始化分配折扣码："+couponCode+";折扣等级："+offLevel.getLevelId()+";折扣率："+offLevel.getOffRate());
//			}else{
//				//logger.info("用户注册初始化不允许分配折扣码：该用户粉丝数="+followers+";");
//			}
//		}
	}

	@Override
	public void afterTransaction(SecurityTask task, ITaskListenerContext context)
			throws ServiceException {
		// TODO Auto-generated method stub

	}

	@Override
	public void onError(SecurityTask task, Throwable e,
			ITaskListenerContext context) {
		// TODO Auto-generated method stub

	}

}
