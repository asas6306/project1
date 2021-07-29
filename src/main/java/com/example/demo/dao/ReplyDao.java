package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Article;
import com.example.demo.dto.Reply;

@Mapper
public interface ReplyDao {

	public void addArticleReply(@Param(value="relTypeCode") String relTypeCode, @Param(value="uid") int uid, @Param(value="relId") int relId, @Param(value="body") String body);

	public List<Reply> getReplies(@Param(value="relTypeCode") String relTypeCode, @Param(value="relId") int relId);

	public int getRepliesCntForMypage(@Param(value="uid") int uid);

	public List<Article> getRepliesForMypage(@Param(value="page") int page, @Param(value="pageCnt") int pageCnt, @Param(value="uid") int uid);

	public void delete(@Param(value="rid") int rid);

	public int getReplyCnt(@Param(value="relTypeCode") String relTypeCode, @Param(value="relId") int relId);

	public void deleteArticleTriger(@Param(value="relTypeCode") String relTypeCode, @Param(value="relId") int relId);

	public Reply getReply(@Param(value="rid") int rid);

	public void update(@Param(value="rid") int rid, @Param(value="body") String body);
}
