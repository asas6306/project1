package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Like {
	int aid;
	int uid;
	
	String nickname;
	
	public String getLikerProfileImgUri() {
        return "/common/genFile/file/member/" + uid + "/common/profile/0";
    }

    public String getLikerProfileFallbackImgUri() {
        return "/gen/member/non_profile.png?updateDate=2021-05-14 21:30:52";
    }

    public String getLikerProfileFallbackImgOnErrorHtmlAttr() {
        return "this.src = '" + getLikerProfileFallbackImgUri() + "'";
    }
}
