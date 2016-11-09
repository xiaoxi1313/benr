package com.newvery.web.action;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

import org.apache.struts2.interceptor.SessionAware;

import com.newvery.bean.BeanFactory;
import com.newvery.config.ConfigManager;
import com.newvery.record.ArticleRecord;
import com.newvery.record.FavoriteRecord;
import com.newvery.utils.HtmlToPdf;
import com.newvery.utils.ZipFileUtil;

public class ArticleBatchExportAction extends BaseWebAction implements SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long childFavoriteId;
	
	private String exportTemplate;
	
	private InputStream zipStream;
	private String zipfilename;
	
	public static String getChildFavoriteZip(long childFavoriteId) {
		return ConfigManager.getInstance().getHomePath()+"upload/zip/" + childFavoriteId + ".zip";
	}
	
	
	
	public String download() throws Exception {
		FavoriteRecord childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(childFavoriteId);
		
		String zipPath = getChildFavoriteZip(childFavoriteId);
		
		File zipFile = new File(zipPath);
		if(zipFile.exists()) {
			zipStream = new FileInputStream(zipPath);
			zipfilename = new String(childFavorite.getName().getBytes("utf-8"), "ISO8859-1") + ".zip";
		} else {
			zipStream = new ByteArrayInputStream("暂无文章".getBytes());
			zipfilename = new String("暂无文章".getBytes("utf-8"), "ISO8859-1") + ".txt";
		}
		return SUCCESS;
		
	}
	
	public String execute() throws Exception {
		//FavoriteRecord childFavorite = BeanFactory.getFavoriteDao().findFavoriteRecordByPK(childFavoriteId);
		List<ArticleRecord> artilceList = BeanFactory.getArticleDao().findArticleByFavoriteId(childFavoriteId);
		
		if(artilceList != null && artilceList.size() > 0) {
			
			String files[] = new String[artilceList.size()];
			
			String generatorFilePath = ConfigManager.getInstance().getHomePath()+"upload/pdf/";
			for (int i = 0; i < artilceList.size();i++) {
				ArticleRecord article = artilceList.get(i);
				
				String inputFile = ConfigManager.getInstance().getHomeUrl()+"articleprint_show.action?article.id="+article.getId() + "&templateName=" + exportTemplate;
				
				try {
					String fileSaveName = article.getTitle().replaceAll(" ", "_").replace(File.pathSeparator, "_").replaceAll("/", "_")+".pdf";
					HtmlToPdf.htmlToPdf(inputFile, generatorFilePath, fileSaveName, null, null);
					
					//文件保存路径
					String filePath = generatorFilePath + fileSaveName;
					files[i] = filePath;
				} catch(Exception ex) {
					System.out.println("批量导出文章出错，id = " + article.getId() + "=======================");
					ex.printStackTrace();
				}
				
			}
			
			String zipPath = getChildFavoriteZip(childFavoriteId);
			ZipFileUtil.zipFiles(files, zipPath);
			
			//zipStream = new FileInputStream(zipPath);
			//zipfilename = new String(childFavorite.getName().getBytes("utf-8"), "ISO8859-1") + ".zip";
		}
		
		return null;
	}

	public long getChildFavoriteId() {
		return childFavoriteId;
	}

	public void setChildFavoriteId(long childFavoriteId) {
		this.childFavoriteId = childFavoriteId;
	}

	public String getExportTemplate() {
		return exportTemplate;
	}

	public void setExportTemplate(String exportTemplate) {
		this.exportTemplate = exportTemplate;
	}

	public InputStream getZipStream() {
		return zipStream;
	}

	public String getZipfilename() {
		return zipfilename;
	};
}
