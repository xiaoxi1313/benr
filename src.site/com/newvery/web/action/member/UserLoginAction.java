package com.newvery.web.action.member;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ApplicationAware;
import org.apache.struts2.interceptor.SessionAware;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserRecord;
import com.newvery.task.um.LoginTask;
import com.newvery.web.BaseAction;
import com.newvery.web.response.UserLoginResponse;

public class UserLoginAction extends BaseAction implements SessionAware, ApplicationAware {

	private static final long serialVersionUID = 5968842395995173127L;
	private Map<String, Object> application;
	
	private UserRecord user;
	private Map<String, Object> session;
	public static final String REFERER_URL = "REFERER_URL_KEY";
	
	public String login() throws Exception {
		if (user == null) {
			return "login";
		}
		UserLoginResponse result = new UserLoginResponse();
		try {
			LoginTask task = new LoginTask();
			task.setPassword(user.getPassword());
			task.setUserName(user.getUserName().trim());
			task.setOperatorIP(getIp());
			task.setBrowser(getBrowser());
			user = (UserRecord)BeanFactory.getSecurityExecutor().exec(task);
			
			getSession().put(Constants.LOGIN_MEMBER_SESSION_NAME, user);
			getSession().put("userName", user.getUserName());
			session.put("loginTime", new Date().getTime());
			
			// 把用户名放入在线列表
		    List onlineUserList = (List) application.get("onlineUserList");
		    // 第一次使用前，需要初始化
		    if (onlineUserList == null) {
		        onlineUserList = new ArrayList();
		        application.put("onlineUserList", onlineUserList);
		        onlineUserList.add(session);
		    }else{
		    	try {
		    		for(int i=0;i<onlineUserList.size();i++){
			    		Map<String, Object> obj = (Map<String, Object>)onlineUserList.get(i);
			    		if(obj.get("userName") != null && session.get("userName") != null && obj.get("userName").equals(session.get("userName"))){
			    			long obj_time = Long.parseLong(obj.get("loginTime").toString());
			    			long session_time = Long.parseLong(session.get("loginTime").toString());
			    			if(obj_time < session_time){
			    				onlineUserList.add(session);
			    				obj.clear();//销毁原来的session
			    				break;
			    			}
			    		}else{
			    			onlineUserList.add(session);
			    		}
			    	}
		    	}catch(IllegalStateException ex) {//session过期错误不处理。
		    		
		    	}
		    	
		    }
			
			if(session.get(REFERER_URL) != null) {
				result.setRefererUrl(session.get(REFERER_URL).toString());
				session.remove(REFERER_URL);
			}
			
			if (user.getRole().getId() == Constants.ROLE_LURUYUAN) {
				result.setRefererUrl("article_insert.action?menuUrl=article_insert");
			}
			else if (user.getRole().getId() == Constants.ROLE_YANJIUYUAN || user.getRole().getId() == Constants.ROLE_GAOJIYANJIUYUAN|| user.getRole().getId() == Constants.ROLE_SYSTEM) {
				result.setRefererUrl("index.action?menuUrl=index");
			}
			else if (user.getRole().getId() == Constants.ROLE_GAOJIYONGHU || user.getRole().getId() == Constants.ROLE_PUTONGYONGHU) {
				result.setRefererUrl("user_index.action");
			}
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	public String logout() throws Exception {
		String logoutUrl = "logout";
		if(getCurrentUser() != null && (getCurrentUser().getRole().getId() == 4 || getCurrentUser().getRole().getId() == 5)) {
			logoutUrl = "userlogout";
		}
		
		ServletActionContext.getRequest().getSession().removeAttribute(Constants.LOGIN_MEMBER_SESSION_NAME);
		return logoutUrl;
	}
	
	public UserRecord getUser() {
		return user;
	}
	public void setUser(UserRecord user) {
		this.user = user;
	}
	public Map<String, Object> getSession() {
		return session;
	}
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public Map<String, Object> getApplication() {
		return application;
	}

	public void setApplication(Map<String, Object> application) {
		this.application = application;
	}
}
