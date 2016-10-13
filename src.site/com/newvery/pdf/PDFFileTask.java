package com.newvery.pdf;

import com.newvery.dal.dao.pdf.IPDFFileDao;
import com.newvery.dal.dao.pdf.impl.PDFFileDaoImpl;
import com.newvery.record.PDFFileRecord;
import com.newvery.task.IDaoManagerFactory;
import com.newvery.task.SecurityTask;

public abstract class PDFFileTask implements SecurityTask {
	private String operatorIP;
	private IDaoManagerFactory daoManagerFactory;
	private PDFFileRecord pdfFile;
	
	public IPDFFileDao getPDFFileDao() {
		return (IPDFFileDao)daoManagerFactory.getManagerImpl(PDFFileDaoImpl.class);
	}
	
	public String getOperatorIP() {
		return operatorIP;
	}
	public void setOperatorIP(String operatorIP) {
		this.operatorIP = operatorIP;
	}
	public IDaoManagerFactory getDaoManagerFactory() {
		return daoManagerFactory;
	}
	public void setDaoManagerFactory(IDaoManagerFactory daoManagerFactory) {
		this.daoManagerFactory = daoManagerFactory;
	}
	public PDFFileRecord getPdfFile() {
		return pdfFile;
	}
	public void setPdfFile(PDFFileRecord pdfFile) {
		this.pdfFile = pdfFile;
	}
}
