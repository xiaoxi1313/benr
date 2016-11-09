package com.newvery.dal.dao.pdf;

import java.util.List;
import java.util.Map;

import com.newvery.exception.ServiceException;
import com.newvery.record.PDFFileRecord;
import com.newvery.web.bean.Page;

public interface IPDFFileDao {
	public PDFFileRecord insertPDFFile(PDFFileRecord pdf) throws ServiceException;
	
	public void deletePDFFile(long id) throws ServiceException;
	
	public PDFFileRecord findPDFFileById(long id) throws ServiceException;
	
	public int countPDFFile(Map query) throws ServiceException;
	
	public List<PDFFileRecord> findPDFFileByPage(Map query, Page page) throws ServiceException;;
}
