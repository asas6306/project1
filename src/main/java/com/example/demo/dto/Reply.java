package com.example.demo.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Reply {
	private int rid;
	private int uid;
	private String body;
	private String relTypeCode;
	private int relId;
	private String regDate;
	private String updateDate;
	private String nickname;
	
	private Map<String, Object> extra;
	
	public Map<String, Object> getExtraNotNull() {
		if(extra == null) 
			extra = new HashMap<String, Object>();
		
		return extra;
	}
	
	public String getBody() {
		return this.transContent(body);
	}
	
	public String transContent(String str) {
		str = str.replace("<", "&lt");
		str = str.replace(">", "&gt");
		str = str.replace("\r\n", "<br>");
		
		return str;
	}
}
