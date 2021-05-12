package com.example.demo.dto;

import java.util.HashMap;
import java.util.Map;

import com.example.demo.service.MemberService;
import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int uid;
	private String ID;
	@JsonIgnore
	private String PW;
	private int authLevel;
	private String authName;
	@JsonIgnore
	private String authKey;
	private String nickname;
	private String regDate;
	private String email;
	private String phoneNo;
	private String extra__thumbImg;
	
	private Map<String, Object> extra;
	
	public Map<String, Object> getExtraNotNull() {
		if(extra == null) 
			extra = new HashMap<String, Object>();
		
		return extra;
	}
	
//	public String getAuthLevelName() {
//		return MemberService.getAuthLevelName(this);
//	}
//
//	public String getAuthLevelNameColor() {
//		return MemberService.getAuthLevelNameColor(this);
//	}
}
