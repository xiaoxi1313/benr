package com.newvery.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.newvery.ErrorCode;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleImageRecord;
import com.newvery.task.upload.UploadImageTask;
import com.newvery.web.BaseAction;
import com.newvery.web.helper.UtilCommon;
import com.newvery.web.response.FileUploadResponse;

/**
 * 图片上传
 * @author mi_xb
 *
 */
public class UploadAction extends BaseAction {

	private static final long serialVersionUID = -8174577451784271218L;
	private File fileupload; // 和JSP中input标记name同名  
    private String imageUrl;  
    private String attachmentUrl;  
    private String fileRealName;  
    
    private ArticleImageRecord articleImage;
    
    // Struts2拦截器获得的文件名,命名规则，File的名字+FileName  
    // 如此处为 'fileupload' + 'FileName' = 'fileuploadFileName'  
    private String fileuploadFileName; // 上传来的文件的名字  
    
    public String uploadFile() {  
        String extName = ""; // 保存文件拓展名  
        String newFileName = ""; // 保存新的文件名  
        String nowTimeStr = ""; // 保存当前时间  
        PrintWriter out = null;  
        SimpleDateFormat sDateFormat;  
        Random r = new Random();  
        String savePath = ServletActionContext.getServletContext().getRealPath( ""); // 获取项目根路径  
        savePath = savePath + "/file/";  
        HttpServletResponse response = ServletActionContext.getResponse();  
        response.setCharacterEncoding("gbk"); // 务必，防止返回文件名是乱码  
        
        // 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）  
        int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数  
        sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式  
        nowTimeStr = sDateFormat.format(new Date()); // 当前时间  
        
        // 获取拓展名  
        if (fileuploadFileName.lastIndexOf(".") >= 0) {  
            extName = fileuploadFileName.substring(fileuploadFileName  
                    .lastIndexOf("."));  
        }  
        
        FileUploadResponse result = new FileUploadResponse();
        try {  
            out = response.getWriter();  
            newFileName = nowTimeStr + rannum + extName; // 文件重命名后的名字  
            String filePath = savePath + newFileName;  
            filePath = filePath.replace("//", "/");  
            
            //检查上传的是否是图片/pdf
            if (UtilCommon.checkIsImage(extName)) {  
                FileUtils.copyFile(fileupload, new File(filePath));  
                //out.print("<font color='red'>" + fileuploadFileName  
                       // + "上传成功!</font>#" + filePath + "#" + fileuploadFileName);  
                result.setUrl(filePath);
            } else {  
                //out.print("<font color='red'>上传的文件类型错误，请选择jpg,jpeg,png和gif格式的图片!</font>");  
            	result.setErrorCode(ErrorCode.FILE_UPLOAD_ERROR);
    			result.setErrorMessage("上传的文件类型错误，请选择jpg,jpeg,png和gif格式的图片!");
            }  
            out.flush();  
            out.close();  
        } catch (IOException e) {  
            e.printStackTrace();  
            result.setErrorCode(ErrorCode.FILE_UPLOAD_ERROR);
			result.setErrorMessage(e.getMessage());
        }  
        
        ajax(result);
        return null;  
    }  
    
    /**
     * 上传图片
     * @return
     * @throws Exception
     */
    public String uploadImage() throws Exception {
    	FileUploadResponse result = new FileUploadResponse();
        try {  
	    	UploadImageTask task = new UploadImageTask();
	    	task.setArticleImage(articleImage);
	    	
	    	articleImage = (ArticleImageRecord) BeanFactory.getSecurityExecutor().exec(task);
	    	result.setArticleImageId(articleImage.getId());
        } catch (ServiceException e) {  
            e.printStackTrace();  
            result.setErrorCode(ErrorCode.FILE_UPLOAD_ERROR);
			result.setErrorMessage(e.getMessage());
        }  
        
        ajax(result);
    	return null;
    }
    
    public String viewImages() throws Exception {  
    	HttpServletResponse response = null;

        ServletOutputStream out = null;
        try {
//        	String path = ServletActionContext.getServletContext().getRealPath(""); // 获取项目根路径  
//        	path = path + "/file/"; 
//        	File file = new File(path + imageUrl);
        	File file = new File(imageUrl);
            response = ServletActionContext.getResponse();
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition", "attachment;fileName=" + imageUrl);
            
            FileInputStream inputStream = new FileInputStream(file);  
            
            out = response.getOutputStream();  
  
            int b = 0;  
            byte[] buffer = new byte[512];  
            while (b != -1){  
                b = inputStream.read(buffer);  
                out.write(buffer,0,b);  
            }  
            inputStream.close();  
            out.close();  
            out.flush();  
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            if (response != null) {
                try {
                	response = null;
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

        }
        return null; 
    }  
    public File getFileupload() {  
        return fileupload;  
    }  
    public void setFileupload(File fileupload) {  
        this.fileupload = fileupload;  
    }  
    public String getImageUrl() {  
        return imageUrl;  
    }  
    public void setImageUrl(String imageUrl) {  
        this.imageUrl = imageUrl;  
    }  
    public String getAttachmentUrl() {  
        return attachmentUrl;  
    }  
    public void setAttachmentUrl(String attachmentUrl) {  
        this.attachmentUrl = attachmentUrl;  
    }  
    public String getFileRealName() {  
        return fileRealName;  
    }  
    public void setFileRealName(String fileRealName) {  
        this.fileRealName = fileRealName;  
    }  
    public String getFileuploadFileName() {  
        return fileuploadFileName;  
    }  
    public void setFileuploadFileName(String fileuploadFileName) {  
        this.fileuploadFileName = fileuploadFileName;  
    }

	public ArticleImageRecord getArticleImage() {
		return articleImage;
	}

	public void setArticleImage(ArticleImageRecord articleImage) {
		this.articleImage = articleImage;
	}  
}
