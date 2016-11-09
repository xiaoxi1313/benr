package com.newvery.web.action.member;

import java.sql.Timestamp;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.newvery.Constants;
import com.newvery.ErrorCode;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserRecord;
import com.newvery.task.um.ForgotPasswordSendEmailTask;
import com.newvery.utils.secure.DigestUtil;
import com.newvery.web.BaseAction;
import com.newvery.web.servlet.BaseResponse;

/**
 * 找回密码
 * @author mi_xb
 *
 */
public class ForgotPasswordAction extends BaseAction implements SessionAware {

	private static final long serialVersionUID = 6696472008978527787L;
	private String email;
	private String sid;
	private String userName;
	private Map<String, Object> session;
	
	/**
	 * 进入找回密码页面
	 * @return
	 * @throws Exception
	 */
	public String step1() throws Exception {
		
		return "step1";
	}
	
	/**
	 * 发送找回密码邮件
	 * @return
	 * @throws Exception
	 */
	public String step2() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			ForgotPasswordSendEmailTask task = new ForgotPasswordSendEmailTask();
			task.setEmail(email);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 校验重置密码链接
	 * @return
	 * @throws Exception
	 */
	public String step3() throws Exception {
		BaseResponse result = new BaseResponse();
		if (sid.equals("")  || userName.equals("")) {
			result.setErrorCode(ErrorCode.USER_EMAIL_ERROR);
			result.setErrorMessage("链接不完整,请重新生成");
			
			ajax(result);
			return null;
		}
		UserRecord user = BeanFactory.getUserDao().findUserByUserName(userName);
		if (user == null) {
			result.setErrorCode(ErrorCode.USER_EMAIL_ERROR);
			result.setErrorMessage("链接不完整,请重新生成");
			
			ajax(result);
			return null;
		}
		
		Timestamp outDate = (Timestamp) user.getOutDate();
        System.out.println("outDate>>>"+outDate);
        if(outDate.getTime() <= System.currentTimeMillis()){ //表示已经过期
        	 result.setErrorCode(ErrorCode.USER_EMAIL_ERROR);
 			 result.setErrorMessage("链接已经过期,请重新申请找回密码.");
 			
 			 ajax(result);
 			 return null;
         }
         
         String key = user.getUserName()+"$"+outDate.getTime()/1000*1000+"$"+user.getValidateCode();//数字签名
        
         System.out.println("key link》》"+key);
         String digitalSignature = DigestUtil.md5(key);// 数字签名
         
         System.out.println("digitalSignature>>>>"+digitalSignature);
         if(!digitalSignature.equals(sid)) {
        	 result.setErrorCode(ErrorCode.USER_EMAIL_ERROR);
 			 result.setErrorMessage("链接不正确,是否已经过期了?重新申请吧.");
 			
 			 ajax(result);
 			 return null;
          }else {
            //链接验证通过 转到修改密码页面
        	  getSession().put(Constants.LOGIN_MEMBER_SESSION_NAME, user);
        }
		
        ajax(result);
		return null;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSid() {
		return sid;
	}

	public void setSid(String sid) {
		this.sid = sid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
}
