package com.newvery.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.newvery.config.ConfigManager;
import com.newvery.exception.ServiceException;

public class SendMailSmtp {
	
	public static void send(
							String subject,
							String sendContext,
							String toMail
			) throws ServiceException {
 
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", ConfigManager.getInstance().getMailHost());
		//props.put("mail.smtp.port", "587");
 
		Session session = Session.getInstance(props,
		  new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(ConfigManager.getInstance().getMailUser(), ConfigManager.getInstance().getMailPassword());
			}
		  });
 
		try {
 
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(ConfigManager.getInstance().getMailUser()));
			message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(toMail));
			
			message.setSubject(subject);
			message.setContent(sendContext, "text/html;charset=utf-8");
			
			Transport.send(message);
 
			//System.out.println("Done");
 
		} catch (MessagingException e) {
			e.printStackTrace();
			throw new ServiceException(-2000,"发送邮件失败");
		}
	}
}
