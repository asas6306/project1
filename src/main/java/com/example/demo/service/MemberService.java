package com.example.demo.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.dto.Member;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

@Service
public class MemberService {
	@Autowired
	MemberDao md;
	
	// static 시작
	public static String getAuthLevelName(Member member) {
		switch (member.getAuthLevel()) {
		case 7:
			return "관리자";
		case 3:
			return "일반회원";
		default:
			return "유형정보없음";
		}
	}

	public static String getAuthLevelNameColor(Member member) {
		switch (member.getAuthLevel()) {
		case 7:
			return "red";
		case 3:
			return "gray";
		default:
			return "";
		}
	}
	// static 끝
	
	public ResultData login(String ID) {
		
		Member loginedMember = md.login(ID);
		
		if(loginedMember == null)
			return new ResultData("F-1", "존재하지 않는 회원입니다.");
		
		return new ResultData("S-1", String.format("%s님 환영합니다.", loginedMember.getNickname()), "loginedMember", loginedMember);
	}

	public ResultData signup(Map<String, Object> param) {
		if(this.getMember("ID", String.valueOf(param.get("ID"))) != null)
			return new ResultData("F-1", "이미 존재하는 아이디입니다.");
		
		if(this.getMember("nickname", String.valueOf(param.get("nickname"))) != null)
			return new ResultData("F-2", "이미 존재하는 닉네임입니다.");
		
		md.signup(param);
		
		int uid = Util.getAsInt(param.get("uid"), 0);
		
		return new ResultData("S-1", "회원가입이 완료되었습니다.", "uid", uid);
	}
	
	public Member getMember(String type, String itemValue) {
		
		return md.getMember(type, itemValue);
	}

	public boolean authCheck(Member loginedMember) {
		return loginedMember.getAuthLevel() == 7;
	}

	public ResultData update(Map<String, Object> param) {
		
		md.update(param);
		
		return new ResultData("S-1", "회원정보가 수정되었습니다.");
	}

	public int allMembersCnt() {
		
		return md.allMembersCnt();
	}

	public int getMembersCnt(int authLevel, String searchType, String searchKeyword) {
		
		return md.getMembersCnt(authLevel, searchType, searchKeyword);
	}

	public List<Member> getMembers(int authLevel, String searchType, String searchKeyword, int page, int pageCnt) {
		page = (page - 1) * pageCnt;
		
		return md.getMembers(authLevel, searchType, searchKeyword, page, pageCnt);
	}
}
