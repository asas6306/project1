package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.BoardDao;
import com.example.demo.dto.Board;
import com.example.demo.dto.Member;

@Service
public class SimplerService {
	@Autowired
	ArticleService as;
	@Autowired
	ReplyService rs;
	@Autowired
	BoardDao bd;
	
	
	// @@@@@@@@@@@ MemberService @@@@@@@@@@@
	public int page(HttpServletRequest req, int page, int pageCnt, int itemsCnt) {
		if(page < 1)
			page = 1;
		
		int allPageCnt = (int)(Math.ceil((double)itemsCnt / pageCnt));
		if(allPageCnt == 0)
			allPageCnt = 1;
		
		if(page > allPageCnt) {
			page = allPageCnt;
		} else if(page < 1) {
			page = 1;
		}
		
		int pageStack;
		int pageIndex = 5;
		if(page % pageIndex == 0) {
			pageStack = page;
		} else {
			pageStack = ((int)(Math.floor(page / pageIndex)) + 1) * pageIndex;
		}
		
		List<Integer> printPageIndexs = new ArrayList<Integer>();
		for(int i = 4; i >= 0; i--) 
			if(pageStack - i <= allPageCnt)
				printPageIndexs.add(pageStack - i);
		req.setAttribute("page", page);
		page = (page - 1) * pageCnt;
		req.setAttribute("printPageIndexs", printPageIndexs);
		int printPageIndexUp = printPageIndexs.get(printPageIndexs.size()-1) + 1;
		req.setAttribute("printPageIndexUp", printPageIndexUp);
		int printPageIndexDown = printPageIndexs.get(0) - 1;
		req.setAttribute("printPageIndexDown", printPageIndexDown);
		
		return page;
	}
	
	public void setItems(HttpServletRequest req, String call, int page, int pageCnt, int uid) {
		if(call.equals("article")) {
			req.setAttribute("items", as.getArticles(null, null, 0, page, pageCnt, "article", uid));
		} else if(call.equals("memo")) {
			req.setAttribute("items", as.getArticles(null, null, 0, page, pageCnt, "memo", uid));
		} else if(call.equals("reply")) {
			req.setAttribute("items", rs.getRepliesForMypage(page, pageCnt, uid));
		}
	}

	public int getItemsCnt(HttpServletRequest req, String call, int uid) {
		
		int articleCnt = as.getArticlesCntForMypage("article", uid);
		req.setAttribute("articleCnt", articleCnt);
		int memoCnt = as.getArticlesCntForMypage("memo", uid);
		req.setAttribute("memoCnt", memoCnt);
		int replyCnt = rs.getRepliesCntForMypage(uid);
		req.setAttribute("replyCnt", replyCnt);
		
		if(call.equals("article")) {
			return articleCnt;
		} else if(call.equals("memo")) {
			return memoCnt;
		} else if(call.equals("reply")) {
			return replyCnt;
		}
		
		return 612;
	}

	public Member setSecureID(Member member) {
		
		char[] charID = member.getID().toCharArray();
		int IDLength = charID.length;
		String ID = "";
		
		for(int i = 0; i < IDLength; i++) {
			if(i < (IDLength/2)) {
				ID += charID[i];
			} else {
				ID += "*";
			}
		}
		member.setID(ID); 
		
		return member;
	}
	
	// board 관련 항목은 수가 적어서 이곳에 코딩하겠음...
	public List<Board> getAllBoardInfo(String boardType) {
		
		return bd.getAllBoardInfo(boardType);
	}
	
public List<Board> getBoardCnt(String boardType) {
		
		return bd.getBoardCnt(boardType);
	}
	
}
