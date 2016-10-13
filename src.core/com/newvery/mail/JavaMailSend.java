package com.newvery.mail;

import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import com.newvery.config.ConfigManager;

public class JavaMailSend {
	    /** 
	     * send mail 
	     * @param subject 
	     * @param from 
	     * @param to 
	     * @param text 
	     * @param filenames 
	     * @param mimeType 
	     */  
	    public void sendmail(String subject,  String[] to,  
	            String text, String[] filenames, String mimeType) {  
	        try {  
	            Properties props = new Properties();  
	  
	            String smtp = ConfigManager.getInstance().getMailHost(); 				// 设置发送邮件所用到的smtp  
	            final String username = ConfigManager.getInstance().getMailUser();
	    		final String password = ConfigManager.getInstance().getMailPassword();
	    		final String from = username;
	    		
	            props = java.lang.System.getProperties(); // 获得系统属性对象  
	            props.put("mail.smtp.host", smtp); // 设置SMTP主机  
	            props.put("mail.smtp.auth", "true"); // 是否到服务器用户名和密码验证  
	    		props.put("mail.smtp.starttls.enable", "true");
	    		//props.put("mail.smtp.port", "587");
	            
	            // 到服务器验证发送的用户名和密码是否正确  
	            // 设置邮件会话 注意这里将认证信息放进了Session的创建参数里  
	            Session mailSession = Session.getInstance(props,
	          		  new javax.mail.Authenticator() {
	          			protected PasswordAuthentication getPasswordAuthentication() {
	          				return new PasswordAuthentication(username, password);
	          			}
	          		  });
	            // 设置传输协议  
	            // 设置from、to等信息  
	            MimeMessage mimeMsg = new javax.mail.internet.MimeMessage(mailSession);  
	            System.out.println(mimeMsg);
	            if (null != from && !"".equals(from)) {  
	                InternetAddress sentFrom = new InternetAddress(from);  
	                mimeMsg.setFrom(sentFrom); // 设置发送人地址  
	            }  
	  
	            InternetAddress[] sendTo = new InternetAddress[to.length];  
	            for (int i = 0; i < to.length; i++) {  
	                System.out.println("发送到:" + to[i]);  
	                sendTo[i] = new InternetAddress(to[i]);  
	            }  
	  
	            mimeMsg.setRecipients(  
	                    javax.mail.internet.MimeMessage.RecipientType.TO, sendTo);  
	            mimeMsg.setSubject(subject, "utf-8");  
	  
	            MimeBodyPart messageBodyPart1 = new MimeBodyPart();  
	            // messageBodyPart.setText(UnicodeToChinese(text));  
	            messageBodyPart1.setContent(text, mimeType);  
	  
	            // 附件传输格式  
	            Multipart multipart = new MimeMultipart();  
	            multipart.addBodyPart(messageBodyPart1);  
	  
	            for (int i = 0; i < filenames.length; i++) {  
	                MimeBodyPart messageBodyPart2 = new MimeBodyPart();  
	  
	                String filename = filenames[i].split(";")[0];  
	                String displayname = filenames[i].split(";")[1];  
	                // 得到数据源  
	                FileDataSource fds = new FileDataSource(filename);  
	                // BodyPart添加附件本身  
	                messageBodyPart2.setDataHandler(new DataHandler(fds));  
	                // BodyPart添加附件文件名  
	                messageBodyPart2.setFileName(MimeUtility  
	                        .encodeText(displayname));  
	                multipart.addBodyPart(messageBodyPart2);  
	            }  
	            mimeMsg.setContent(multipart);  
	            // 设置信件头的发送日期  
	            mimeMsg.setSentDate(new Date());  
	            System.out.println(mimeMsg);
	            mimeMsg.saveChanges();  
	            // 发送邮件  
	            Transport.send(mimeMsg);  
	            System.out.println("发送到成功!!!");  
	        } catch (Exception e) {  
	            e.printStackTrace();  
	        }  
	    }  
	  
	    /** 
	     * Smtp认证 
	     */  
	    class SmtpAuthenticator extends Authenticator {  
	        String username = null;  
	        String password = null;  
	  
	        /** 
	         * SMTP身份验证 
	         * @param username 
	         * @param password 
	         */  
	        public SmtpAuthenticator(String username, String password) {  
	            super();  
	            this.username = username;  
	            this.password = password;  
	        }  
	  
	        /** 
	         * @return pass 
	         */  
	        public PasswordAuthentication getPasswordAuthentication() {  
	            return new PasswordAuthentication(this.username, this.password);  
	        }  
	    }
}
