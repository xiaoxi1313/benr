package com.newvery.web.action.member;

import java.io.File;

import org.apache.struts2.interceptor.SessionAware;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserRecord;
import com.newvery.task.um.UserUpdateProfileTask;
import com.newvery.utils.FileUtils;
import com.newvery.utils.StringUtil;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.servlet.BaseResponse;

public class UpdateUserProfileAction extends BaseWebAction implements SessionAware {

	private UserRecord user;
	
	private String password;
	private String newPassword;
	private String rePassword;
	
	private File avatar; //上传的文件
    private String avatarFileName; //文件名称
    private String avatarContentType; //文件类型

	
	
	@Override
	public String execute() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			if(!newPassword.equals(rePassword)) {
				throw new ServiceException(-1, "两次输入的密码不正确");
			}
			if(!StringUtil.isEmail(user.getEmail())) {
				throw new ServiceException(-1, "邮箱格式错误");
			}
			
			String userFileDir = "/upload/user";
			String realpath = org.apache.struts2.ServletActionContext.getServletContext().getRealPath(userFileDir);
	        
	        
	        String avatarPath = null;
	        if (avatar != null) {
	        	String fileName = user.getId() + "." + FileUtils.getFileExtension(avatarFileName);
		        avatarPath = userFileDir + "/" + fileName;
	        	
	        	
	            File savefile = new File(new File(realpath), fileName);
	            if (!savefile.getParentFile().exists()) {
	            	savefile.getParentFile().mkdirs();
	            }
	            org.apache.commons.io.FileUtils.copyFile(avatar, savefile);
	        }
	        //System.out.println(avatarPath + "==================");
	        UserUpdateProfileTask task = new UserUpdateProfileTask();
	        task.setEmail(user.getEmail());
	        task.setIcon(avatarPath);
	        task.setPassword(password);
	        task.setNewPassword(newPassword);
	        task.setUserId(user.getId());
	        BeanFactory.getSecurityExecutor().exec(task);
	        
	        UserRecord u = BeanFactory.getUserDao().findUserById(user.getId());
	        getSession().put(Constants.LOGIN_MEMBER_SESSION_NAME, u);
	        
		} catch(ServiceException ex) {
			result.setErrorCode(ex.getErrorCode());
			result.setErrorMessage(ex.getMessage());
		}
		
        ajax(result);
		return null;
	}



	public UserRecord getUser() {
		return user;
	}



	public void setUser(UserRecord user) {
		this.user = user;
	}



	public String getPassword() {
		return password;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public String getNewPassword() {
		return newPassword;
	}



	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}



	public String getRePassword() {
		return rePassword;
	}



	public void setRePassword(String rePassword) {
		this.rePassword = rePassword;
	}



	public File getAvatar() {
		return avatar;
	}



	public void setAvatar(File avatar) {
		this.avatar = avatar;
	}



	public String getAvatarFileName() {
		return avatarFileName;
	}



	public void setAvatarFileName(String avatarFileName) {
		this.avatarFileName = avatarFileName;
	}



	public String getAvatarContentType() {
		return avatarContentType;
	}



	public void setAvatarContentType(String avatarContentType) {
		this.avatarContentType = avatarContentType;
	}
	
}
