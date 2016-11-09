package com.newvery.task.um;

import java.sql.Timestamp;
import java.util.UUID;

import com.newvery.ErrorCode;
import com.newvery.config.ConfigManager;
import com.newvery.exception.ServiceException;
import com.newvery.record.UserRecord;
import com.newvery.utils.Mail;
import com.newvery.utils.secure.DigestUtil;
import com.newvery.web.helper.UrlHelper;

/**
 * 忘记密码发送邮件
 * @author mi_xb
 *
 */
public class ForgotPasswordSendEmailTask extends UserTask {
	private String email;

	@Override
	public Object exec() throws ServiceException {
		UserRecord user = getUserDao().findUserByEmail(email);
		if (user == null) {
			throw new ServiceException(ErrorCode.USER_EMAIL_ERROR, "该邮件对应用户不存在!" );
		}
		
		String secretKey = UUID.randomUUID().toString(); // 密钥
        Timestamp outDate = new Timestamp(System.currentTimeMillis() + 30 * 60 * 1000);// 30分钟后过期
        long date = outDate.getTime() / 1000 * 1000;// 忽略毫秒数  mySql 取出时间是忽略毫秒数的
        
        user.setOutDate(outDate);
        user.setValidateCode(secretKey);
        getUserDao().updateForgotPasswordInfo(user);
        
        System.out.println("   UserName >>>> "+ user.getUserName());
        String key = user.getUserName() + "$" + date + "$" + secretKey;
        System.out.println(" key >>>> "+key);
        String digitalSignature = DigestUtil.md5(key);// 数字签名

        String resetPassHref = UrlHelper.getHomeUrl() + "checkLink.action?sid="
                + digitalSignature + "&userName=" + user.getUserName();
        String emailContent = "请勿回复本邮件.点击下面的链接,重设密码<br/><a href="
                + resetPassHref + " target='_BLANK'>" + resetPassHref
                + "</a>  或者    <a href=" + resetPassHref
                + " target='_BLANK'>点击我重新设置密码</a>"
                + "<br/>tips:本邮件超过30分钟,链接将会失效，需要重新申请'找回密码'" + key
                + "\t" + digitalSignature;
        
        String copyto = "";// 抄送人邮件地址
        String subject = "[本然数据库]找回您的账户密码";// 邮件标题
        Mail.sendAndCc(ConfigManager.getInstance().getEmailSmtp(), ConfigManager.getInstance().getEmailFrom(), 
        		email, copyto, subject, emailContent, ConfigManager.getInstance().getEmailUserName(), 
        		ConfigManager.getInstance().getEmailPassword());
		return null;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
