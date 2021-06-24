package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ReplyDao;
import com.example.demo.dto.Article;
import com.example.demo.dto.Reply;
import com.example.demo.util.ResultData;

@Service
public class ReplyService {
	@Autowired
	ReplyDao rd;
	
	public List<Reply> getReplies(String relTypeCode, int relId) {
		return rd.getReplies(relTypeCode, relId);
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

	public ResultData delete(int itemId) {
		
		rd.delete(itemId);
		
		return new ResultData("S-1", "댓글이 삭제되었습니다.");
	}

	public int getReplyCnt(String relTypeCode, int relId) {
		
		return rd.getReplyCnt(relTypeCode, relId);
	}


}
