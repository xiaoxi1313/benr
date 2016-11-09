package com.newvery.pdf;

import com.newvery.exception.ServiceException;

public class PDFFileInsertTask extends PDFFileTask {

	@Override
	public Object exec() throws ServiceException {
		getPdfFile().setDeleted(false);
		
		setPdfFile(getPDFFileDao().insertPDFFile(getPdfFile()));
		return getPdfFile();
	}

}
