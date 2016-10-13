package com.newvery.pdf;

import com.newvery.exception.ServiceException;

public class PDFFileBatchDeleteTask extends PDFFileTask {

	private long[] pid;
	
	@Override
	public Object exec() throws ServiceException {
		for (long id : pid) {
			getPDFFileDao().deletePDFFile(id);
		}
		
		return null;
	}

	public long[] getPid() {
		return pid;
	}

	public void setPid(long[] pid) {
		this.pid = pid;
	}

}
