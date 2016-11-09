package com.newvery.mail;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.StringUtils;
import org.apache.velocity.app.VelocityEngine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;
import org.springframework.ui.velocity.VelocityEngineUtils;

@Component("emailSender")
public class EMailSender {

//		Map<String, Object> model = new HashMap<String, Object>();
//		model.put("userName", "大关");
//		model.put("emailAddress", "woshidaguan@126.com");
//		tves.sendEmail(model, "欢迎您的加入", "com/guan/chapter19/email/welcome.vm",
//				new String[] { "woshiguanxinquan@163.com" }, 
//				new String[] {"F:/Sunset.jpg", "F:/spring-hibernate.rar" });
		// 参数说明：替换velocity模板的变量和值对，邮件主题，velocity模板文件的路径，接收方email地址，附件
		// 简单说明，如果您要群发，可以在接收方email地址中多传入几个email地址，附件可以一次发送多个

		@Autowired
		private JavaMailSender mailSender;
		
		@Autowired
		private VelocityEngine velocityEngine;
		
		public void sendEmail(final String toEmailAddresses, final String fromEmailAddress,
                final String subject)  throws Exception{
			sendEmail(toEmailAddresses, fromEmailAddress, subject, null, null);
		}

		public void sendEmailWithAttachment(final String toEmailAddresses, final String fromEmailAddress,
                              final String subject, final String attachmentPath,
                              final String attachmentName)  throws Exception{
			sendEmail(toEmailAddresses, fromEmailAddress, subject, attachmentPath, attachmentName);
		}
		
		private void sendEmail(final String toEmailAddresses, final String fromEmailAddress,
                 				final String subject, final String attachmentPath,
                 				final String attachmentName) throws Exception{

			 MimeMessagePreparator preparator = new MimeMessagePreparator() {
				public void prepare(MimeMessage mimeMessage) throws Exception {
				    MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true);
				    message.setTo(toEmailAddresses);
				    message.setFrom(new InternetAddress(fromEmailAddress));
				    message.setSubject(subject);
				    String body = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "templates/reminder.vm", "UTF-8", null);
				    message.setText(body, true);
				    if (!StringUtils.isBlank(attachmentPath)) {
						FileSystemResource file = new FileSystemResource(attachmentPath);
						message.addAttachment(attachmentName, file);
				    }
				}
			 };
			 if(mailSender!=null){
				 System.out.println("333333");
			 }
			 this.mailSender.send(preparator);
		 }

		/*
		public void sendEmail(final Map<String, Object> model,
				final String subject, final String vmfile,
				final String[] mailTo, final String[] files) {
			
			MimeMessagePreparator preparator = new MimeMessagePreparator() {
				// 注意MimeMessagePreparator接口只有这一个回调函数
				public void prepare(MimeMessage mimeMessage) throws Exception {
					MimeMessageHelper message = new MimeMessageHelper(mimeMessage, true, "GBK");
					// 这是一个生成Mime邮件简单工具，如果不使用GBK这个，中文会出现乱码
					// 如果您使用的都是英文，那么可以使用MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
					message.setTo(mailTo);// 设置接收方的email地址
					message.setSubject(subject);// 设置邮件主题
					message.setFrom("XXXXXXXXXXXXXXXX");// 设置发送方地址
					String text = VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, vmfile, "GBK", model);
					// 从模板中加载要发送的内容，vmfile就是模板文件的名字
					// 注意模板中有中文要加GBK，model中存放的是要替换模板中字段的值
					message.setText(text, true);
					// 将发送的内容赋值给MimeMessageHelper,后面的true表示内容解析成html
					// 如果您不想解析文本内容，可以使用false或者不添加这项
					if(files.length>0){
						FileSystemResource file;
						// 添加附件
						for (String s : files){
							file = new FileSystemResource(new File(s));// 读取附件
							message.addAttachment(s, file);// 向email中添加附件
						}
					}
				}
			};

			mailSender.send(preparator);// 发送邮件
		}
		*/
}
