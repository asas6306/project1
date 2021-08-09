package com.example.demo.dto;

import java.util.HashMap;
import java.util.Map;

import com.example.demo.util.Util;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
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
	private String name;
	private String regDate;
	private String email;
	private String phoneNo;
	private int delState;
	private String delDate;
	
	private String extra__thumbImg;
	private Map<String, Object> extra;
	
	public Map<String, Object> getExtraNotNull() {
		if(extra == null) 
			extra = new HashMap<String, Object>();
		
		return extra;
	}

	public Object toJsonStr() {
		return Util.toJsonStr(this);
	}
	
//	public String getAuthLevelName() {
//		return MemberService.getAuthLevelName(this);
//	}
//
//	public String getAuthLevelNameColor() {
//		return MemberService.getAuthLevelNameColor(this);
//	}
	
    public String getProfileImgUri() {
        return "/common/genFile/file/member/" + uid + "/common/profile/0";
    }

    public String getProfileFallbackImgUri() {
        return "/gen/member/basic/non_profile.png";
    }

    public String getProfileFallbackImgOnErrorHtmlAttr() {
        return "this.src = '" + getProfileFallbackImgUri() + "'";
    }
}
