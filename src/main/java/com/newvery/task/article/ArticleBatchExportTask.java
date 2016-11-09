package com.newvery.task.article;

import java.util.UUID;

import com.newvery.bean.BeanFactory;
import com.newvery.config.ConfigManager;
import com.newvery.exception.ServiceException;
import com.newvery.record.ArticleRecord;
import com.newvery.utils.HtmlToPdf;
import com.newvery.utils.ZipFileUtil;

/**
 * 批量导出
 * @author mi_xb
 *
 */
public class ArticleBatchExportTask extends ArticleTask {
	private String[] articleIds;
	@Override
	public Object exec() throws ServiceException {
		if (articleIds != null && articleIds.length > 0) {
			String[] files = new String[articleIds.length];
			for (int i=0;i<articleIds.length;i++) {
				String articleId = articleIds[i];
				ArticleRecord article = BeanFactory.getArticleDao().findArticleRecordByPK(Long.parseLong(articleId));
				// 第一步，生成pdf文件
				String inputFile = ConfigManager.getInstance().getHomeUrl()+"articleprint_show.action?article.id="+article.getId();
				String generatorFilePath = ConfigManager.getInstance().getHomePath()+"upload/pdf/";
				String fileSaveName = article.getId()+".pdf";
				HtmlToPdf.htmlToPdf(inputFile, generatorFilePath, fileSaveName, null, null);
				files[i] = generatorFilePath+fileSaveName;
			}
			String zipName = UUID.randomUUID()+".zip";
			String zipPath = ConfigManager.getInstance().getHomePath()+"upload/pdf/zip/"+zipName;
			try {
				if (ZipFileUtil.zipFiles(files,zipPath)) {
					return zipName;
				}else{
					throw new ServiceException(-601, "压缩文件失败！");
				}
			} catch (Exception e) {
				e.printStackTrace();
				throw new ServiceException(-601, "压缩文件报错："+e.getMessage());
			}
		}
		return null;
	}
	
	public String[] getArticleIds() {
		return articleIds;
	}
	public void setArticleIds(String[] articleIds) {
		this.articleIds = articleIds;
	}

}
