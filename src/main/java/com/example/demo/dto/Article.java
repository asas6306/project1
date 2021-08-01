package com.example.demo.dto;

import java.util.HashMap;
import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
	private int aid;
	private String title;
	private String body;
	private String regDate;
	private String updateDate;
	private int uid;
	private int hit;
	private int like;
	private int boardCode;
	private String articleType;
	
	private String authName;
	private String nickname;
	private String boardName;
	private String extra__thumbImg;
	
	private Map<String, Object> extra;
	
	public Map<String, Object> getExtraNotNull() {
		if(extra == null) 
			extra = new HashMap<String, Object>();
		
		return extra;
	}
	
	public String getWriterProfileImgUri() {
        return "/common/genFile/file/member/" + uid + "/common/profile/0";
    }

    public String getWriterProfileFallbackImgUri() {
        return "/gen/member/non_profile.png?updateDate=2021-05-14 21:30:52";
    }

    public String getWriterProfileFallbackImgOnErrorHtmlAttr() {
        return "this.src = '" + getWriterProfileFallbackImgUri() + "'";
    }
}
