package com.spring.board.vo;

public class CodeVo {
	private String codeId;
	private String codeName;
	
	
	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
	@Override
	public String toString() {
		return "CodeVo [codeId=" + codeId + ", codeName=" + codeName + "]";
	}

}
