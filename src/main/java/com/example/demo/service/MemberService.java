package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.dao.MemberDao;
import com.example.demo.dto.GenFile;
import com.example.demo.dto.Member;
import com.example.demo.util.ResultData;
import com.example.demo.util.Util;

@Service
public class MemberService {
	@Autowired
	MemberDao md;
	@Autowired
	GenFileService fs;
	@Autowired
    private MailService mailService;
	@Autowired
    private AttrService attrService;

	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;
	@Value("${custom.setNeedToChangePassword}")
	private int setNeedToChangePassword;
	
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
		
		loginedMember = getMemberImg(loginedMember);
		
		return new ResultData("S-1", String.format("%s님 환영합니다.", loginedMember.getNickname()), "loginedMember", loginedMember);
	}

	public ResultData signup(Map<String, Object> param) {
		if(this.getMember("ID", String.valueOf(param.get("ID"))) != null)
			return new ResultData("F-1", "이미 존재하는 아이디입니다.");
		
		if(this.getMember("nickname", String.valueOf(param.get("nickname"))) != null)
			return new ResultData("F-2", "이미 존재하는 닉네임입니다.");
		
		md.signup(param);
		
		int uid = Util.getAsInt(param.get("uid"), 0);
		this.setNeedToChangePassword(uid);
		
		return new ResultData("S-1", "회원가입이 완료되었습니다.", "uid", uid);
	}
	
	public Member getMember(String type, String itemValue) {
		
		Member member = md.getMember(type, itemValue);
		
		if(member != null)
			return getMemberImg(member);
		
		return member;
	}

	public boolean authCheck(Member loginedMember) {
		return loginedMember.getAuthLevel() == 7;
	}

	public ResultData update(Map<String, Object> param) {
		
		int uid = (int)param.get("uid");
		
		if (param.get("PW") != null) {
			this.setNeedToChangePassword(uid);
            attrService.remove("member", uid, "extra", "useTempPassword");
        }
		
		md.update(param);
		
		return new ResultData("S-1", "회원정보가 수정되었습니다.");
	}

	public int allMembersCnt() {
		
		return md.allMembersCnt();
	}

	public int getMembersCnt(int authLevel, String searchType, String searchKeyword) {
		
		return md.getMembersCnt(authLevel, searchType, searchKeyword);
	}
	
	// adm에서 사용한 메소드 : 관리자 권한별로 멤버 출력
	public List<Member> getMembers(int authLevel, String searchType, String searchKeyword, int page, int pageCnt) {
		
		List<Member> members = md.getMembers(authLevel, searchType, searchKeyword, page, pageCnt);
		
		// 프로필 이미지 가져오깅
		for(Member member : members) {
			member = getMemberImg(member);
		}
		
		return members;
	}
	
	public Member getMemberImg(Member member) {
		// 프로필 이미지 호출
		List<GenFile> files = fs.getGenFiles("member", member.getUid(), "common", "profile");
		Map<String, GenFile> filesMap = new HashMap<>();
		if(!files.isEmpty()) {
			filesMap.put(files.get(0).getFileNo() + "", files.get(0));
			member.getExtraNotNull().put("file__common__profile", filesMap);
		}
		
		return member;
	}

	public void delete(Integer uid) {
		
		md.delete(uid);
	}

	public Member getMemberForFindId(String name, String email) {
		
		return md.getMemberForFindId(name, email);
	}
	
	public ResultData notifyTempLoginPwByEmail(Member member) {
        String title = "[" + siteName + "] 임시 패스워드 발송";
        String tempPassword = Util.getTempPassword(6);
        String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
        body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

        ResultData sendResultData = mailService.send(member.getEmail(), title, body);

        if (sendResultData.isFail()) {
            return sendResultData;
        }

        setTempPassword(member.getUid(), Util.sha256(tempPassword));

        return new ResultData("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다.");
    }

    private void setTempPassword(int uid, String tempPassword) {
    	attrService.setValue("member", uid, "extra", "useTempPassword", "1", null);
        md.setTempPassword(uid, tempPassword);
    }

	public ResultData checkValidCheckPasswordAuthCode(int uid, String checkPasswordAuthCode) {
		if (attrService.getValue("member__" + uid + "__extra__checkPasswordAuthCode").equals(checkPasswordAuthCode))
			return new ResultData("S-1", "유효한 키 입니다.");

        return new ResultData("F-1", "유효하지 않은 키 입니다.");
	}

	public String genCheckPasswordAuthCode(int uid) {
		String attrName = "member__" + uid + "__extra__checkPasswordAuthCode";
        String authCode = UUID.randomUUID().toString();
        String expireDate = Util.getDateStrLater(60 * 60);

        attrService.setValue(attrName, authCode, expireDate);

        return authCode;
	}

	public boolean isTempPassword(int uid) {
		return attrService.getValue("member", uid, "extra", "useTempPassword").equals("1");
	}

	public boolean needToChangePassword(int uid) {
		
		return attrService.getValue("member", uid, "extra", "needToChangePassword").equals("0") == false;
	}
	
	public void setNeedToChangePassword(int uid) {
		int days = setNeedToChangePassword;
		attrService.setValue("member", uid, "extra", "needToChangePassword", "0", Util.getDateStrLater((60*60*24) * days));
	}
	
	public int getNeedToChangePassword() {
		return setNeedToChangePassword;
	}
}
