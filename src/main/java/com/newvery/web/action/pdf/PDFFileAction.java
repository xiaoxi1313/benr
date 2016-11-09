package com.newvery.web.action.pdf;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import com.newvery.Constants;
import com.newvery.ErrorCode;
import com.newvery.bean.BeanFactory;
import com.newvery.exception.ServiceException;
import com.newvery.pdf.PDFFileBatchDeleteTask;
import com.newvery.pdf.PDFFileInsertTask;
import com.newvery.record.PDFFileRecord;
import com.newvery.record.UserGroupRecord;
import com.newvery.web.action.BaseWebAction;
import com.newvery.web.bean.Page;
import com.newvery.web.helper.UtilCommon;
import com.newvery.web.servlet.BaseResponse;

public class PDFFileAction extends BaseWebAction {

	private static final long serialVersionUID = 5461347322191461279L;
	private PDFFileRecord pdfFile;
	private List<PDFFileRecord> pdfFileList;
	
	private File thumbnailFileUpload;
	
	private File pdfFileUpload;
	private String pdfFileUploadFileName; // 上传来的文件的名字
	
	// Struts2拦截器获得的文件名,命名规则，File的名字+FileName  
    // 如此处为 'thumbnailFileUpload' + 'FileName' = 'thumbnailFileUploadFileName'  
    private String thumbnailFileUploadFileName; // 上传来的文件的名字
    
    
    private Page page = new Page();
    
    private String oderByCondition;
	private String orderById;
	
	private Map<String, String> params = new HashMap<String, String>();
	
	private int type;
	
	private String pdfPath;		//pdf文件地址
	private int year;			//pdf文件年份
	
	private List<UserGroupRecord> userGroupList;
	
	/**
	 * 列表管理页面
	 * @return
	 * @throws Exception
	 */
	public String manage() throws Exception {
		Map query = new HashMap();
		if (pdfFile != null && pdfFile.getTitle() != null && !"".equals(pdfFile.getTitle())) {
			query.put("title", pdfFile.getTitle());
			params.put("pdfFile.title", pdfFile.getTitle());
		}
		
		int count = BeanFactory.getPDFFileDao().countPDFFile(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			pdfFileList = BeanFactory.getPDFFileDao().findPDFFileByPage(query, page);
		}
		
		userGroupList = BeanFactory.getUserDao().findUserGroupByPage(new HashMap(), new Page(0xfffff));
		return "manage";
	}
	
	/**
	 * 添加pdf文件
	 * @return
	 * @throws Exception
	 */
	public String add() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			if (pdfFile.getCreateTime() == null) {		//页面没选择时间，默认系统时间
				pdfFile.setCreateTime(new Date());
			}
			
			// 上传缩略图和PDF文件
			pdfFile.setThumbnail(uploadFile(thumbnailFileUpload, thumbnailFileUploadFileName));
			pdfFile.setPdf(uploadFile(pdfFileUpload, pdfFileUploadFileName));
			
			PDFFileInsertTask task = new PDFFileInsertTask();
			task.setPdfFile(pdfFile);
			
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			e.printStackTrace();
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 通过类别查看PDF文件列表
	 * @return
	 * @throws Exception
	 */
	public String listByType() throws Exception {
		Map query = new HashMap();
		query.put("type", type);
		params.put("type", type + "");
		
		if (year > 0) {
			query.put("year", year + "");
			params.put("year", year + "");
		}
		
		query.put("userGroupId", getCurrentUser().getUserGroup().getId());
		
		int count = BeanFactory.getPDFFileDao().countPDFFile(query);
		if (count > 0) {
			page.setNumPerPage(Constants.USER_PAGE_SIZE);
			page.setTotalNum(count);
			pdfFileList = BeanFactory.getPDFFileDao().findPDFFileByPage(query, page);
		}
		return "listByType";
	}
	
	/**
	 * 在线预览pdf
	 * @return
	 * @throws Exception
	 */
	public String view() throws Exception {
		pdfFile = BeanFactory.getPDFFileDao().findPDFFileById(pdfFile.getId());
		pdfPath = pdfFile.getPdf();
		
//		File file = new File(pdfFile.getPdf());
//        
//        BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));  
//        PDDocument pdfDocument = null;
//        PDFParser parser = new PDFParser(bis);
//        parser.parse();
//        pdfDocument = parser.getPDDocument();
//        ByteArrayOutputStream out = new ByteArrayOutputStream();
//        OutputStreamWriter writer = new OutputStreamWriter(out);
//        PDFTextStripper stripper = new PDFTextStripper();
//        stripper.writeText(pdfDocument, writer);
//        writer.close();
//        byte[] contents = out.toByteArray();
//        
//        String ts = new String(contents);
//        
//        HttpServletResponse response = ServletActionContext.getResponse();
//        response.getWriter().write(ts);
        
		return "view";
	}
	
	
	private long[] pid;
	public String delete() throws Exception {
		BaseResponse result = new BaseResponse();
		try {
			
			PDFFileBatchDeleteTask task = new PDFFileBatchDeleteTask();
			task.setPid(pid);
			BeanFactory.getSecurityExecutor().exec(task);
		} catch(ServiceException e) {
			e.printStackTrace();
			result.setErrorCode(e.getErrorCode());
			result.setErrorMessage(e.getMessage());
		}
		
		ajax(result);
		return null;
	}
	
	/**
	 * 上传文件
	 * @return 文件路径
	 * @throws ServiceException
	 */
	private String uploadFile(File fileupload, String fileuploadFileName) throws ServiceException {
		
		
		String extName = ""; // 保存文件拓展名  
        String newFileName = ""; // 保存新的文件名  
        String nowTimeStr = ""; // 保存当前时间  
        SimpleDateFormat sDateFormat;  
        Random r = new Random();  
        String savePath = ServletActionContext.getServletContext().getRealPath( ""); // 获取项目根路径  
        savePath = savePath + "/file/";  
        
        // 生成随机文件名：当前年月日时分秒+五位随机数（为了在实际项目中防止文件同名而进行的处理）  
        int rannum = (int) (r.nextDouble() * (99999 - 10000 + 1)) + 10000; // 获取随机数  
        sDateFormat = new SimpleDateFormat("yyyyMMddHHmmss"); // 时间格式化的格式  
        nowTimeStr = sDateFormat.format(new Date()); // 当前时间  
        
        // 获取拓展名  
        if (fileuploadFileName.lastIndexOf(".") >= 0) {  
            extName = fileuploadFileName.substring(fileuploadFileName.lastIndexOf("."));  
        }  
        
        try {  
            newFileName = nowTimeStr + rannum + extName; // 文件重命名后的名字  
            String filePath = savePath + newFileName;  
            filePath = filePath.replace("//", "/");  
            String url = "/file/"+newFileName;
            
            //检查上传的是否是图片/pdf
            if (UtilCommon.checkIsImage(extName)) {  
                FileUtils.copyFile(fileupload, new File(filePath));  
                
                return url;
            } else {  
                
    			throw new ServiceException(ErrorCode.FILE_UPLOAD_ERROR, "上传的文件类型错误，请选择正确的类型!");
            }  
            
        } catch (IOException e) {  
            e.printStackTrace();  
            throw new ServiceException(ErrorCode.FILE_UPLOAD_ERROR, e.getMessage());
        }  
        
        
	}

	public PDFFileRecord getPdfFile() {
		return pdfFile;
	}

	public void setPdfFile(PDFFileRecord pdfFile) {
		this.pdfFile = pdfFile;
	}

	public List<PDFFileRecord> getPdfFileList() {
		return pdfFileList;
	}

	public void setPdfFileList(List<PDFFileRecord> pdfFileList) {
		this.pdfFileList = pdfFileList;
	}

	public File getThumbnailFileUpload() {
		return thumbnailFileUpload;
	}

	public void setThumbnailFileUpload(File thumbnailFileUpload) {
		this.thumbnailFileUpload = thumbnailFileUpload;
	}

	public File getPdfFileUpload() {
		return pdfFileUpload;
	}

	public void setPdfFileUpload(File pdfFileUpload) {
		this.pdfFileUpload = pdfFileUpload;
	}

	public String getThumbnailFileUploadFileName() {
		return thumbnailFileUploadFileName;
	}

	public void setThumbnailFileUploadFileName(String thumbnailFileUploadFileName) {
		this.thumbnailFileUploadFileName = thumbnailFileUploadFileName;
	}

	public String getPdfFileUploadFileName() {
		return pdfFileUploadFileName;
	}

	public void setPdfFileUploadFileName(String pdfFileUploadFileName) {
		this.pdfFileUploadFileName = pdfFileUploadFileName;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public String getOderByCondition() {
		return oderByCondition;
	}

	public void setOderByCondition(String oderByCondition) {
		this.oderByCondition = oderByCondition;
	}

	public String getOrderById() {
		return orderById;
	}

	public void setOrderById(String orderById) {
		this.orderById = orderById;
	}

	public Map<String, String> getParams() {
		return params;
	}

	public void setParams(Map<String, String> params) {
		this.params = params;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public String getPdfPath() {
		return pdfPath;
	}

	public void setPdfPath(String pdfPath) {
		this.pdfPath = pdfPath;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public long[] getPid() {
		return pid;
	}

	public void setPid(long[] pid) {
		this.pid = pid;
	}

	public List<UserGroupRecord> getUserGroupList() {
		return userGroupList;
	}

	public void setUserGroupList(List<UserGroupRecord> userGroupList) {
		this.userGroupList = userGroupList;
	}

}
