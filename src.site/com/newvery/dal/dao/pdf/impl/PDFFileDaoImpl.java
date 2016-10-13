package com.newvery.dal.dao.pdf.impl;

import java.util.List;
import java.util.Map;

import com.newvery.dal.dao.BaseDao;
import com.newvery.dal.dao.pdf.IPDFFileDao;
import com.newvery.exception.ServiceException;
import com.newvery.record.PDFFileRecord;
import com.newvery.web.bean.Page;

public class PDFFileDaoImpl extends BaseDao implements IPDFFileDao {

	@Override
	public PDFFileRecord insertPDFFile(PDFFileRecord pdf) throws ServiceException {
		getSqlTemplate().insert("insertPDFFile", pdf);
		return pdf;
	}

	@Override
	public void deletePDFFile(long id) throws ServiceException {
		getSqlTemplate().update("deletePDF", id);
	}

	@Override
	public int countPDFFile(Map query) throws ServiceException {
		return getSqlTemplate().selectOne("countPDFByPage", query);
	}

	@Override
	public List<PDFFileRecord> findPDFFileByPage(Map query, Page page) throws ServiceException {
		query.put("page", page);
		return getSqlTemplate().selectList("findPDFByPage", query);
	}

	@Override
	public PDFFileRecord findPDFFileById(long id) throws ServiceException {
		return getSqlTemplate().selectOne("findPDFByPK", id);
	}
}