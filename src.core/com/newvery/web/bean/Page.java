package com.newvery.web.bean;

import java.io.Serializable;


public class Page implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	public static final int PAGE_SIZE = 15;
	private int numPerPage = PAGE_SIZE;
	private int startIndex;

	private int curPage = 0;
	private int totalNum = 0;
	
	/** 根据最大页查找 */
	public static Page getMaxPage() {
		return new Page(getMaxResult());
	}

	public static int getMaxResult() {
		return Integer.MAX_VALUE;
	}

	/** 根据每页条数创建分页 */
	public static Page getInstance(int numPerPage) {
		return new Page(numPerPage);
	}

	public Page() {
		super();
	}

	public Page(int numPerPage) {
		super();
		this.numPerPage = numPerPage;
	}

	public Page(int numPerPage, int curPage, int totalNum) {
		super();
		this.numPerPage = numPerPage;
		this.curPage = curPage;
		this.totalNum = totalNum;
	}

	@Override
	public String toString() {
		return this.getCurPage() + "/" + this.getTotalPage() + " - " + this.getNumPerPage();
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public int getCurPage() {
		if(curPage < 1)
			curPage = 1;
		if(curPage > getTotalPage())
			curPage = getTotalPage();
		return curPage;
	}

	/**
	 * 页起始下标
	 * @return
	 */
	public int getStartIndex() {
		startIndex = (getCurPage() - 1) * getNumPerPage();
		if(startIndex < 0) {
			startIndex = 0;
		}
		return startIndex;
	}
	
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getTotalNum() {
		return Math.min(totalNum, getMaxResult());
	}

	public void setTotalNum(int totalNum) {
		this.totalNum = totalNum;
	}

	public int getTrueTotalNum() {
		return this.totalNum;
	}

	public int getPageStart() {
		if (curPage <= 0) {
			return 0;
		}
		if(curPage > getTotalPage()) {
			curPage = getTotalPage();
		}
		return numPerPage * (curPage - 1) ;
	}
	
	public int getPageEnd() {
		return getPageStart() + numPerPage;
		
	}
	
	/**
	 * 返回总页数
	 * @return
	 */
	public int getTotalPage() {
		if(this.totalNum % this.numPerPage ==0){
			return this.totalNum/this.numPerPage;
		}
		return this.totalNum/this.numPerPage + 1;
	}
}
