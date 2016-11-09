 package com.newvery.web.action;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class UploadFileDemoAction extends ActionSupport {   
	private static final long serialVersionUID = 1L;
	private File fileInput;   
	private String fileInputFileName;//Struts2的拦截器FileUploadInterceptor根据请求对象中参数"fileInput"来自行生产的一个固有属性

 

	public String upload() throws Exception {
		return "upload";
	}
 
	public String uploadFile() throws Exception {  
		HttpServletResponse response = ServletActionContext.getResponse();   
		response.setCharacterEncoding("utf-8"); 
		//上传文件保存路径
		String savePath = ServletActionContext.getServletContext().getRealPath("");
		savePath = savePath + "/file/";
		System.out.println(savePath);
		
		String extName = ""; // 保存文件拓展名  
        String newFileName = ""; // 保存新的文件名  
        String nowTimeStr = ""; // 保存当前时间  
        SimpleDateFormat sDateFormat;  
        Random r = new Random();  
		// 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）  
        int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数  
        sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式  
        nowTimeStr = sDateFormat.format(new Date()); // 当前时间  
        
        // 获取拓展名  
        if (fileInputFileName.lastIndexOf(".") >= 0) {  
            extName = fileInputFileName.substring(fileInputFileName.lastIndexOf("."));  
        }  
        
        newFileName = nowTimeStr + rannum + extName;;
		fileInput.renameTo(new File(savePath+"/"+ newFileName));
		//ajax返回数据
		String reslut = "<img alt='...' src='viewImg.action?imageUrl=" + newFileName + "' />";
		response.getWriter().println(newFileName);
		
		return null;     
	}

	public File getFileInput() {   
		return fileInput;   
	}  

	public void setFileInput(File fileInput) {   
		this.fileInput = fileInput;   
	}  


	public String getFileInputFileName() {   
		return fileInputFileName;   
	}  

	public void setFileInputFileName(String fileInputFileName) {   
		this.fileInputFileName = fileInputFileName;   
	}  
} 