package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.dto.Member;
import com.example.demo.util.ResultData;

@Service
public class MemberService {
	@Autowired
	MemberDao md;
	
	public ResultData login(String ID) {
		
		Member loginedMember = md.login(ID);
		
		if(loginedMember == null)
			return new ResultData("F-1", "존재하지 않는 회원입니다.");
		
		return new ResultData("S-1", String.format("%s님 환영합니다.", loginedMember.getNickname()), "loginedMember", loginedMember);
	}
}
