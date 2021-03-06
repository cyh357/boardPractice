package com.spring.board.vo;

import java.util.List;

public class PageVo {
	
	private int pageNo = 0;
	private List<CodeVo> codeList;

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public List<CodeVo> getCodeList() {
		return codeList;
	}

	public void setCodeList(List<CodeVo> codeList) {
		this.codeList = codeList;
	}
	
	@Override
	public String toString() {
		return "PageVo [pageNo=" + pageNo + ", codeList=" + codeList + "]";
	}
	
}
