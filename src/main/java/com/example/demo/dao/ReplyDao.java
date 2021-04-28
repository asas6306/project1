package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.demo.dto.Reply;

@Mapper
public interface ReplyDao {

	public void addArticleReply(@Param(value="relTypeCode") String relTypeCode, @Param(value="uid") int uid, @Param(value="relId") int relId, @Param(value="body") String body);

	public List<Reply> getReplies(@Param(value="relTypeCode") String relTypeCode, @Param(value="relId") int relId);
}
