package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleLikeDao;
import com.example.demo.dto.Like;
import com.example.demo.util.ResultData;

@Service
public class ArticleLikeService {
	@Autowired
	ArticleLikeDao ald;

	public List<Like> getLikes(int aid) {
		
		return ald.getLikes(aid);
	}

	public ResultData doLike(int aid, int uid, boolean isLike) {
		if(isLike) {
			ald.undoLike(aid, uid);
			return new ResultData("S-1", "해당 게시물을 좋아요 취소 하였습니다."); 
		} else {
			ald.doLike(aid, uid);
			return new ResultData("S-1", "해당 게시물을 좋아요 하였습니다.");
		}
	}
}
