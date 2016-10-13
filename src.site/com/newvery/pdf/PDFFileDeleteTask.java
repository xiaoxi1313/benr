package com.newvery.pdf;

import com.newvery.exception.ServiceException;

public class PDFFileDeleteTask extends PDFFileTask {

	@Override
	public Object exec() throws ServiceException {
		getPDFFileDao().deletePDFFile(getPdfFile().getId());
		return null;
	}

}
