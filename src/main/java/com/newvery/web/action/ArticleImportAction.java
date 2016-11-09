package com.newvery.web.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.Range;

import com.newvery.Constants;
import com.newvery.bean.BeanFactory;
import com.newvery.record.ArticleRecord;
import com.newvery.record.CategoryRecord;
import com.newvery.record.UserRecord;
import com.newvery.utils.FileUtils;
import com.newvery.utils.TimeUtil;
import com.newvery.utils.ZipFileUtil;

public class ArticleImportAction extends BaseWebAction  {

	private static final long serialVersionUID = 1L;
	
	
	private File zfile; //上传的文件
    private String zfileFileName; //文件名称
    private String zfileContentType; //文件类型
	
    private String resultInfo ;
    
    
    @Override
    public String execute() throws Exception {

    	return super.execute();
    }
    
    public String save() throws Exception {
    	
    	String userFileDir = "/upload/import/article";
		String realpath = org.apache.struts2.ServletActionContext.getServletContext().getRealPath(userFileDir);
        StringBuffer result = new StringBuffer();
        
        if (zfile != null) {
        	long fileid = System.currentTimeMillis();
        	String fileName = fileid + "." + FileUtils.getFileExtension(zfileFileName);
        	String zipDirectory = realpath + "/" + fileid;
        	File targetDir = new File(zipDirectory);
        	if(!targetDir.exists()) {
        		targetDir.mkdir();
        	}
        	
            File savefile = new File(new File(realpath), fileName);
            if (!savefile.getParentFile().exists()) {
            	savefile.getParentFile().mkdirs();
            }
           org.apache.commons.io.FileUtils.copyFile(zfile, savefile);
            
            //进行解压缩
           //File targetfile = new File(zipDirectory + "/"+fileid);
           //targetfile.mkdir();
           boolean checked = true;
           try {
        	   ZipFileUtil.unzip(savefile, zipDirectory);
           } catch(java.lang.IllegalArgumentException ex) {
        	   result.append("文件格式有误:不能解压缩 " +zfileFileName ) .append("<br/>");
        	   checked = false;
           }catch(Exception ex) {
        	   ex.printStackTrace();
        	   result.append("系统错误" +ex.getMessage() ) .append("<br/>");
        	   checked = false;
           }
          
            if(checked) {
            	targetDir = new File(zipDirectory);
                for (File zipFileDir : targetDir.listFiles()) {
    				String zipFileName = zipFileDir.getName();
    				if(zfileFileName.indexOf(zipFileName) == -1) continue;
    				
    				//进入文章内容目录 
    				for (File c : zipFileDir.listFiles()) {
    					
    					ArticleRecord ar = new ArticleRecord();
    					ar.setStatus(Constants.ARTICLE_STATUS_INIT);
    					ar.setUserId(getCurrentUser().getId());
    					//for (File c : aritcleArc.listFiles()) {
    						
    						String subfix = FileUtils.getFileExtension(c.getName());
    						
    						if(subfix.equalsIgnoreCase("doc")) {//文章内容
    							
    							try {  
    					            //创建存储word文档的对象  
    					            HWPFDocument doc = new HWPFDocument(new FileInputStream(c));  
    					            //用来获得word文档内容  
    					            Range range=doc.getRange();  
    					            //文档段落数目  
    					            int paragraphCount=range.numParagraphs();  
    					            //遍历段落读取数据  
    					            StringBuffer stringBuffer = new StringBuffer();
    					            for(int i=0;i<paragraphCount;i++)  
    					            {  
    					            	Paragraph pph=range.getParagraph(i);  
    					            	switch(i) {
    					            	case 0:									//标题
    					            		ar.setTitle(pph.text());
    					            		break;
    					            	case 1:									//分类
    					            		String category[] = pph.text().trim().split(">");
    					            		CategoryRecord parentCategory = BeanFactory.getCategoryDao().findCategoryByName(category[0]);
    					            		if(parentCategory != null) {
    					            			ar.setParentCategoryId(parentCategory.getId());
    					            		}
    					            		if(category.length > 1) {
    					            			CategoryRecord childCategory = BeanFactory.getCategoryDao().findCategoryByName(category[1]);
    						            		if(childCategory != null) {
    						            			ar.setChildCategoryId(childCategory.getId());
    						            		}
    					            		}
    					            		break;
    					            	case 2:									//标签
    					            		break;
    					            	case 3:									//用户
    					            		UserRecord u = BeanFactory.getUserDao().findUserByUserName(pph.text().trim());
    					            		if(u!=null) {
    					            			ar.setUserId(u.getId());
    					            		}
    					            		break;
    					            	case 4:									//时间
    					            		ar.setCreateTime(TimeUtil.parse(pph.text(), TimeUtil.FORMAT_DATE_ONLY));
    					            		break;
    					            	case 5:									//来源地址
    					            		ar.setSourceLink(pph.text());
    					            		break;
    					            	default:
    					            		stringBuffer.append(pph.text());
    					            		break;
    					            	}
    					            	
    					            }  
    					            
    					            String[] items = stringBuffer.toString().split("========================================");
    					            
    					            if(items.length >=3) {
    					            	ar.setSummary(items[1]);
    						            ar.setContent(items[2]);
    					            } else {
    					            	result.append("文件格式有误: " + c.getName()) .append("<br/>");
    					            	continue;
    					            }
    					            
    					            
    					            //图片
    					            String imagefilePath = c.getParentFile().getAbsolutePath() + "/" + FileUtils.getFileName(c.getName()) + ".jpg";
    					            File imageFile = new File(imagefilePath);
    					            
    					            long imgfileid = System.currentTimeMillis();
    								String imagePath = "/upload/import/article/images/" + imgfileid + ".jpg";
    								
    								String articleImageDir = org.apache.struts2.ServletActionContext.getServletContext().getRealPath("/upload/import/article/images/");
    								
    								File targetImagePath = new File(articleImageDir,imgfileid + ".jpg");
    								org.apache.commons.io.FileUtils.copyFile(imageFile,targetImagePath);
    								
    								ar.setTitleImage(imagePath);
    								
    								BeanFactory.getArticleDao().insertArticleRecord(ar);
    					            
    					        } catch (FileNotFoundException e) {
    					        	result.append("文件未找到: ").append(e.getMessage()) .append("<br/>");
    					        	
    					            e.printStackTrace();  
    					        } catch (IOException e) {  
    					            e.printStackTrace();  
    					        } 
    							
    						} else {
    							
    							if(c.isDirectory()) {
    								continue;
    							}
    							/*
    							long imgfileid = System.currentTimeMillis();
    							String imagePath = "/upload/import/article/images/" + imgfileid + "."+subfix;
    							
    							System.out.println(imagePath);
    							
    							String articleImageDir = org.apache.struts2.ServletActionContext.getServletContext().getRealPath("/upload/import/article/images/");
    							
    							File targetImagePath = new File(articleImageDir,imgfileid + "."+subfix);
    							org.apache.commons.io.FileUtils.copyFile(c,targetImagePath);
    							
    							ar.setTitleImage(imagePath);
    							*/
    						}
    					//}//一篇文章
    					
    					
    					
    				}
    				
    				
    			}
                
            }
       }
            
            
        resultInfo = result.toString();
    	
    	return "success";
    }

	public File getZfile() {
		return zfile;
	}

	public void setZfile(File zfile) {
		this.zfile = zfile;
	}

	public String getZfileFileName() {
		return zfileFileName;
	}

	public void setZfileFileName(String zfileFileName) {
		this.zfileFileName = zfileFileName;
	}

	public String getZfileContentType() {
		return zfileContentType;
	}

	public void setZfileContentType(String zfileContentType) {
		this.zfileContentType = zfileContentType;
	}

	public String getResultInfo() {
		return resultInfo;
	}
}
