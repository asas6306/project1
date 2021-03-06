package com.example.demo.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ReplyDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.GenFile;
import com.example.demo.dto.Reply;
import com.example.demo.util.ResultData;

import net.bytebuddy.matcher.LatentMatcher.ForSelfDeclaredMethod;

@Service
public class ReplyService {
	@Autowired
	ReplyDao rd;
	@Autowired
	GenFileService fs;
	
	public Reply getReply(int rid) {
		
		return rd.getReply(rid);
	}
	
	public List<Reply> getReplies(String relTypeCode, int relId) {
		List<Reply> replies = rd.getReplies(relTypeCode, relId);
		
		for(Reply reply : replies) {
			GenFile file = fs.getGenFile("member", reply.getUid(), "common", "profile", 0);
			Map<String, GenFile> filesMapForGetMember = new HashMap<>();
			
			if(file != null)
				filesMapForGetMember.put(file.getFileNo() + "", file);
			
			reply.getExtraNotNull().put("file__common__profile", filesMapForGetMember);
		}
		
		return replies;
	}
	
	public ResultData addArticleReply(String relTypeCode,int uid, int aid, String body) {
		
		rd.addArticleReply(relTypeCode, uid, aid, body);
		
		return new ResultData("S-1", "댓글이 등록되었습니다.");
	}

	public int getRepliesCntForMypage(int uid) {
		
		return rd.getRepliesCntForMypage(uid);
	}

	public List<Article> getRepliesForMypage(int page, int pageCnt, int uid) {
		
		return rd.getRepliesForMypage(page, pageCnt, uid);
	}

	public ResultData delete(int rid, int uid) {
		
		Reply reply = rd.getReply(rid);
		
		if(reply == null)
			return new ResultData("F-1", "해당 댓글이 존재하지 않습니다.");
		if(reply.getUid() == uid) {
			rd.delete(rid);
			return new ResultData("S-1", "댓글이 삭제되었습니다.");			
		} else {
			return new ResultData("F-2", "해당 댓글을 삭제할 수 없습니다.");
		}
	}

	public int getReplyCnt(String relTypeCode, int relId) {
		
		return rd.getReplyCnt(relTypeCode, relId);
	}

	public void deleteArticleTriger(String relTypeCode, int relId) {
		
		rd.deleteArticleTriger(relTypeCode, relId);
	}

	public ResultData update(int uid, int rid, String body) {
		
		Reply reply = rd.getReply(rid);
		
		if(reply == null)
			return new ResultData("F-1", "존재하지 않는 댓글입니다.");
		else if(reply.getUid() != uid)
			return new ResultData("F-2", "해당 권한이 없습니다.");
		else {
			rd.update(rid, body);
			return new ResultData("S-1", "댓글이 수정되었습니다.", "reply", reply);			
		}
	}


}
